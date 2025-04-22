-- after/plugin/fzfmake.lua

---@param filepath (string | nil)
---@return integer
local get_make_file_buffer_nr = function(filepath)
    local makefile_path = filepath or (vim.fn.getcwd() .. "/Makefile")

    if vim.fn.filereadable(makefile_path) == 1 and vim.fn.fnamemodify(makefile_path, ":t") == "Makefile" then
        return vim.fn.bufnr(makefile_path, true)
    end

    return -1
end

---@param bufnr integer
---@return table<string, string> | nil
local get_ts_query_matches = function(bufnr)
    local treesitter = require("vim.treesitter")

    -- local parser = vim.treesitter.get_parser(bufnr, "make")
    local ok, parser = pcall(vim.treesitter.get_parser, bufnr, "make")

    if (not ok) or (parser == nil) then
        print("Error: " .. parser)
        return nil
    end

    local syntax_tree = parser:parse()

    if (syntax_tree == nil) or (syntax_tree[1] == nil) then
        return nil
    end

    local root = syntax_tree[1]:root()

    local query = [[
			(rule
				(targets
					(word)
					@word
					(#not-eq? @word ".PHONY"))
				(recipe
				  (recipe_line
					(shell_text)
					@text)))
		]]

    local query_ok, parsed_query = pcall(function()
        return vim.treesitter.query.parse("make", query)
    end)

    if not query_ok then
        print("Error: Failed to parse Treesitter query")
        return nil
    end

    local result = {}
    local target, recipe = nil, nil

    for id, node in parsed_query:iter_captures(root, bufnr) do
        local name = parsed_query.captures[id]
        if name == "word" then
            target = treesitter.get_node_text(node, bufnr)
        elseif name == "text" then
            recipe = treesitter.get_node_text(node, bufnr)
        end

        if target and recipe then
            result[target] = recipe
            target, recipe = nil, nil -- reset for next match
        end
    end

    return result
end

---@param result table<string, string>
local display_makefile_targets = function(result)
    local pickers = require("telescope.pickers")
    local config = require("telescope.config")
    local actions = require("telescope.actions")
    local actions_state = require("telescope.actions.state")
    local previewers = require("telescope.previewers")

    pickers
        .new({}, {
            title = "Makefile Targets",
            finder = require("telescope.finders").new_table({
                results = vim.tbl_keys(result),
                entry_maker = function(entry)
                    return {
                        value = entry,
                        display = entry,
                        ordinal = entry,
                    }
                end,
            }),
            sorter = config.values.generic_sorter({}),
            attach_mappings = function(_, map)
                ---@diagnostic disable-next-line: unused-local
                map("i", "<CR>", function(prompt_bufnr)
                    local selection = actions_state.get_selected_entry()
                    vim.cmd("FloatermNew --autoclose=0 make " .. selection.value)
                    -- vim.cmd("FloatermNew --autoclose=0 make " .. selection.value)
                end)
                return true
            end,
            previewer = previewers.new_buffer_previewer({
                ---@diagnostic disable-next-line: unused-local
                define_preview = function(self, entry, status)
                    vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, vim.split(result[entry.value], "\n"))
                end,
            }),
        })
        :find()
end

local function make_fzf()
    local bufnr = get_make_file_buffer_nr()
    if bufnr and bufnr ~= -1 then
        local result = get_ts_query_matches(bufnr)

        if result ~= nil then
            display_makefile_targets(result)
        end
    end
    print("Makefile not found!")
end

vim.api.nvim_create_user_command("MakeFzf", make_fzf, {})
