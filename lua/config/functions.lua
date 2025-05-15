-- lua/config/functions.lua

local M = {}

---@param lines_above number
---@param lines_below number
---@return string[]
function M.GetTextBetweenLines(lines_above, lines_below)
    local current_line = vim.fn.getpos(".")[2]
    local start_line = current_line + lines_above - 1
    local end_line = current_line + lines_below
    return vim.api.nvim_buf_get_lines(0, start_line, end_line, false)
end

---@return string[]
function M.GetTextFromVisual()
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    return vim.api.nvim_buf_get_text(0, start_pos[2] - 1, start_pos[3] - 1, end_pos[2] - 1, end_pos[3], {})
end

-- converts the input string or string[] to a floating window
-- and `q` to quit
---@param content string | string[]
function M.as_floating_window(content)
    local lines = {}

    if type(content) == "string" then
        lines = vim.split(content, "\n")
    elseif type(content) == "table" then
        lines = lines
    end

    local dummy_buf = vim.api.nvim_create_buf(false, true)
    vim.bo[dummy_buf].filetype = "Dummmy"

    vim.api.nvim_buf_set_lines(dummy_buf, 0, -1, false, lines)

    local width, height = 70, #lines
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    local win = vim.api.nvim_open_win(dummy_buf, true, {
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
    vim.bo[dummy_buf].modifiable = false
    vim.bo[dummy_buf].readonly = true

    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = dummy_buf, silent = true })
end
_G.HP = M
