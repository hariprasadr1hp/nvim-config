-- lua/plugins/custom/buffer/lang/json.lua

local M = {}

-- Namespaces
local TS = {}
local Exec = {}
local Render = {}
local Pipeline = {}

---@return TSNode|nil
function TS.node_under_cursor(buf)
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    row = row - 1
    return vim.treesitter.get_node({ bufnr = buf, pos = { row, col } })
end

---@param node TSNode|nil
---@param type_name string
---@return TSNode|nil
function TS.find_ancestor(node, type_name)
    while node and node:type() ~= type_name do
        node = node:parent()
    end
    return node
end

---@param arr_node TSNode
---@param buf integer
---@return string[] objects_as_text
function TS.collect_objects_in_array(arr_node, buf)
    local out = {}
    for _, child in ipairs(arr_node:named_children()) do
        if child:type() == "object" then
            table.insert(out, vim.treesitter.get_node_text(child, buf))
        end
    end
    return out
end

---@return boolean
function Exec.have_jq()
    return vim.fn.executable("jq") == 1
end

---@param input string
---@param filter string
---@param cb fun(res:{code:integer, stdout:string, stderr:string})
function Exec.run_jq(input, filter, cb)
    vim.system({ "jq", filter }, { text = true, stdin = input }, function(res)
        cb({
            code = res.code or 1,
            stdout = res.stdout or "",
            stderr = res.stderr or "",
        })
    end)
end

---@param lines string[]
---@param title string
---@param is_json boolean
---@return integer buf, integer win
function Render.open_float(lines, title, is_json)
    local api = vim.api
    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.6)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    local buf = api.nvim_create_buf(false, true)
    api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    local win = api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        border = "rounded",
        title = title,
        title_pos = "center",
        style = "minimal",
    })

    vim.wo[win].wrap = false
    vim.wo[win].cursorline = true
    vim.bo[buf].modifiable = true
    vim.bo[buf].readonly = false

    -- Close with 'q'
    vim.keymap.set("n", "q", function()
        if api.nvim_win_is_valid(win) then
            api.nvim_win_close(win, true)
        end
    end, { buffer = buf, nowait = true, silent = true, desc = "Close window" })

    return buf, win
end

---@param code integer
---@param stderr string
function Render.show_error(code, stderr)
    local err_lines = {
        ("jq error (exit %d):"):format(code),
        stderr ~= "" and stderr or "(no stderr)",
    }
    Render.open_float(err_lines, "jq error", false)
end

---@param siblings string[]
---@return string json_array
function Pipeline.pack_json_array(siblings)
    return "[" .. table.concat(siblings, ",\n") .. "]\n"
end

---@param cb fun(filter:string|nil)
function Pipeline.prompt_filter(cb)
    vim.ui.input({ prompt = "jq filter (applied to the array): ", default = ".[]" }, function(filter)
        cb(filter)
    end)
end

---@return boolean
function M.jq_sibling_action()
    local api = vim.api
    local buf = api.nvim_get_current_buf()

    local node = TS.node_under_cursor(buf)
    if not node then
        vim.notify("No Tree-sitter node at cursor.", vim.log.levels.WARN)
        return false
    end

    local object_node = TS.find_ancestor(node, "object")
    if not object_node then
        vim.notify("Cursor is not inside a JSON object.", vim.log.levels.WARN)
        return false
    end

    local parent = object_node:parent()
    while parent and parent:type() ~= "array" do
        parent = parent:parent()
    end
    if not parent or parent:type() ~= "array" then
        vim.notify("No enclosing array of objects found.", vim.log.levels.WARN)
        return false
    end

    local siblings = TS.collect_objects_in_array(parent, buf)
    if #siblings == 0 then
        vim.notify("No sibling objects found in the array.", vim.log.levels.WARN)
        return false
    end

    local payload = Pipeline.pack_json_array(siblings)

    Pipeline.prompt_filter(function(filter)
        if filter == nil then
            return
        end
        if filter == "" then
            filter = ".[]"
        end

        local run = Exec.run_jq
        if run == Exec.run_jq and not Exec.have_jq() then
            vim.notify("`jq` not found in PATH.", vim.log.levels.ERROR)
            return
        end

        run(payload, filter, function(res)
            vim.schedule(function()
                if res.code == 0 then
                    local lines = vim.split(res.stdout, "\n", { plain = true })
                    Render.open_float(lines, "JQ Result", true)
                else
                    Render.show_error(res.code, res.stderr)
                end
            end)
        end)
    end)

    return true
end

vim.api.nvim_create_user_command("JsonJqSiblings", M.jq_sibling_action, {})

return M

-- local show_actions = require("plugins.custom.buffer.actions").show_actions

-- local M = {}
--
-- local function get_node_at_cursor(buf)
--     local api = vim.api
--     local row, col = unpack(api.nvim_win_get_cursor(0))
--     row, col = row - 1, col
--     -- Support both 0.10 (get_node) and 0.9 (get_node_at_pos)
--     if vim.treesitter.get_node then
--         return vim.treesitter.get_node({ bufnr = buf, pos = { row, col } })
--     else
--         return vim.treesitter.get_node_at_pos(buf, row, col, {})
--     end
-- end
--
-- local function find_ancestor(node, type_name)
--     while node and node:type() ~= type_name do
--         node = node:parent()
--     end
--     return node
-- end
--
-- local function get_sibling_objects_in_array(arr_node, buf)
--     local res = {}
--     for _, child in ipairs(arr_node:named_children()) do
--         if child:type() == "object" then
--             table.insert(res, vim.treesitter.get_node_text(child, buf))
--         end
--     end
--     return res
-- end
--
-- ---@param lines string[]
-- ---@param title string
-- ---@return integer buf, integer win
-- local function open_float_with_text(lines, title)
--     local buf_id = vim.api.nvim_create_buf(false, true)
--     vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, lines)
--
--     local width = math.floor(vim.o.columns * 0.8)
--     local height = math.floor(vim.o.lines * 0.6)
--     local row = math.floor((vim.o.lines - height) / 2)
--     local col = math.floor((vim.o.columns - width) / 2)
--
--     local win = vim.api.nvim_open_win(buf_id, true, {
--         relative = "editor",
--         width = width,
--         height = height,
--         row = row,
--         col = col,
--         style = "minimal",
--         border = "rounded",
--         title = title or "Results",
--         title_pos = "center",
--     })
--
--     vim.wo[win].wrap = false
--     vim.wo[win].cursorline = true
--     vim.bo[buf_id].modifiable = false
--     vim.bo[buf_id].readonly = true
--
--     vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = buf_id, silent = true })
-- end
--
-- function M.run_jq_on_sibling_nodes()
--     local api = vim.api
--     local buf = api.nvim_get_current_buf()
--
--     -- Ensure JSON parser exists
--     local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype or "json") or "json"
--     local ok = pcall(vim.treesitter.language.require_language, lang)
--     if not ok then
--         vim.notify("Tree-sitter JSON parser not found.", vim.log.levels.ERROR)
--         return
--     end
--
--     local node = get_node_at_cursor(buf)
--     if not node then
--         vim.notify("No Tree-sitter node at cursor.", vim.log.levels.WARN)
--         return
--     end
--
--     -- Make sure we're inside an object that lives in an array
--     local object_node = find_ancestor(node, "object")
--     if not object_node then
--         vim.notify("Cursor is not inside a JSON object.", vim.log.levels.WARN)
--         return
--     end
--
--     local parent = object_node:parent()
--     while parent and parent:type() ~= "array" do
--         parent = parent:parent()
--     end
--     if not parent or parent:type() ~= "array" then
--         vim.notify("No enclosing array of objects found.", vim.log.levels.WARN)
--         return
--     end
--
--     local siblings = get_sibling_objects_in_array(parent, buf)
--     if #siblings == 0 then
--         vim.notify("No sibling objects found in the array.", vim.log.levels.WARN)
--         return
--     end
--
--     local payload = "[" .. table.concat(siblings, ",\n") .. "]\n"
--
--     -- Prompt for jq filter
--     vim.ui.input({ prompt = "jq filter (applied to the array): ", default = "." }, function(filter)
--         if filter == nil then
--             return
--         end
--         filter = (filter == "" and "." or filter)
--
--         -- Run jq with stdin = payload
--         local jq_ok = vim.fn.executable("jq") == 1
--         if not jq_ok then
--             vim.notify("`jq` not found in PATH.", vim.log.levels.ERROR)
--             return
--         end
--
--         vim.system({ "jq", filter }, { text = true, stdin = payload }, function(res)
--             vim.schedule(function()
--                 local out = res.stdout or ""
--                 local err = res.stderr or ""
--                 local code = res.code or 1
--
--                 if code == 0 then
--                     local lines = vim.split(out, "\n", { plain = true })
--                     open_float_with_text(lines, "JQ Results")
--                 else
--                     local lines = { "jq error (exit " .. tostring(code) .. "):", err ~= "" and err or "(no stderr)" }
--                     open_float_with_text(lines, "jq error")
--                 end
--             end)
--         end)
--     end)
-- end
--
-- return M
