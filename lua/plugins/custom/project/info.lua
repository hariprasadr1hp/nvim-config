-- lua/plugins/custom/project/info.lua

local M = {}

local function get_project_metadata()
    return {
        { "Path:", vim.fn.getcwd() },
        { "Name:", "Not Implemented" },
        { "Git Branch:", "Not Implemented" },
        { "Git Remote URL:", "Not Implemented" },
        { "Discovery:", "Not Implemented" },
        { "Languages:", "Not Implemented" },
        { "Workflows:", "Not Implemented" },
    }
end

function M.show_project_info()
    local buf_id = vim.api.nvim_get_current_buf()
    local items = get_project_metadata()

    local lines = { "Current Project Info", string.rep("─", 50) }
    for _, pair in ipairs(items) do
        table.insert(lines, string.format("%-20s %s", pair[1], pair[2]))
    end
    table.insert(lines, string.rep("─", 50))
    table.insert(lines, "Press 'q' to close this window.")

    local info_buf = vim.api.nvim_create_buf(false, true)
    vim.bo[info_buf].filetype = "InfoProject"
    vim.api.nvim_buf_set_lines(info_buf, 0, -1, false, lines)

    local width, height = 70, #lines
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    local win = vim.api.nvim_open_win(info_buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
    })

    vim.wo[win].wrap = false
    vim.wo[win].cursorline = true
    vim.bo[info_buf].modifiable = false
    vim.bo[info_buf].readonly = true

    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = info_buf, silent = true })
end

if ... == nil then
    M.show_project_info()
end

return M
