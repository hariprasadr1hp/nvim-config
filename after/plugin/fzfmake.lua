-- after/plugin/fzfmake.lua

local keymap_set = require("config.helpers").keymap_set

---@param filepath (string | nil)
---@return integer
local function get_make_file_buffer_nr(filepath)
    local makefile_path = filepath or (vim.fn.getcwd() .. "/Makefile")

    if vim.fn.filereadable(makefile_path) == 1 and vim.fn.fnamemodify(makefile_path, ":t") == "Makefile" then
        return vim.fn.bufnr(makefile_path, true)
    end

    return -1
end

---@param bufnr integer
---@return table<string, string> | nil
local function get_ts_query_matches(bufnr)
    local treesitter = require("vim.treesitter")

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

    -- TODO: capture the comment block on top of the target
    -- starting with `## `. Use it in the fzf-preview for viewing help
    -- docs for the target

    local query = [[
			(rule
				(targets
					(word)
					@target)
				(recipe) @recipe)

            (rule
				(targets
					(word)
					@target)
                normal: (prerequisites (word) @prereq)
				(recipe) @recipe)
    ]]

    local query_ok, parsed_query = pcall(function()
        return vim.treesitter.query.parse("make", query)
    end)

    if not query_ok then
        print("Error: Failed to parse Treesitter query")
        return nil
    end

    local entries = {}
    local target, recipe, prereq = nil, nil, nil
    local sep = string.rep("-", 30)

    for id, node in parsed_query:iter_captures(root, bufnr) do
        local name = parsed_query.captures[id]
        if name == "target" then
            target = treesitter.get_node_text(node, bufnr)
        elseif name == "recipe" then
            recipe = treesitter.get_node_text(node, bufnr)
        elseif name == "prereq" then
            prereq = treesitter.get_node_text(node, bufnr)
        end

        if target and recipe then
            entries[target] = string.format("%s:\t%s\n%s\n\n%s", target, prereq or "(none)", sep, recipe)
            target, recipe, prereq = nil, nil, nil -- reset for next match
        end
    end

    return entries
end

---@param entries table<string, string>
local function display_makefile_target(entries)
    local fzflua = require("fzf-lua")
    local toggleterm = require("toggleterm")

    local targets = {}

    for key, _ in pairs(entries) do
        table.insert(targets, key)
    end

    fzflua.fzf_exec(targets, {
        prompt = "Make target> ",
        preview = function(item)
            local preview_text = entries[item[1]] or "No preview available"
            return preview_text
        end,
        actions = {
            default = function(selected, _)
                toggleterm.exec(" make " .. selected[1])
            end,
        },
    })
end

local function make_fzf()
    -- FIX: update makefile loading mechanism
    -- instead of extracting TS from buffer, use fpath
    -- therefore, no need for an active Makefile buffer
    local bufnr = get_make_file_buffer_nr()
    if bufnr and bufnr ~= -1 then
        local entries = get_ts_query_matches(bufnr)

        if entries ~= nil then
            display_makefile_target(entries)
        end
    end
    print("Makefile not found!")
end

-- TODO: Selection always on the last-run target, by default
keymap_set("n", "<leader>mz", make_fzf, "make-fzf")

vim.api.nvim_create_user_command("MakeFzf", make_fzf, {})
