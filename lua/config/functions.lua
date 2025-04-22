-- lua/config/functions.lua

local M = {}

---@param lines_above number
---@param lines_below number
---@return string[]
M.GetTextBetweenLines = function(lines_above, lines_below)
    local current_line = vim.fn.getpos(".")[2]
    local start_line = current_line + lines_above - 1
    local end_line = current_line + lines_below
    return vim.api.nvim_buf_get_lines(0, start_line, end_line, false)
end

---@return string[]
M.GetTextFromVisual = function()
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    return vim.api.nvim_buf_get_text(0, start_pos[2] - 1, start_pos[3] - 1, end_pos[2] - 1, end_pos[3], {})
end

_G.HP = M
