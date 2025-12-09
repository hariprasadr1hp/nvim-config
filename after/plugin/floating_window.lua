-- after/plugin/floating_window.lua

if vim.g.vscode then
    return
end

local keymap_set = require("config.helpers").keymap_set

local float_win = nil
local float_buf = nil

local function toggle_float()
    if float_win ~= nil and vim.api.nvim_win_is_valid(float_win) then
        -- Close floating window and return to normal layout
        vim.api.nvim_win_close(float_win, true)
        float_win = nil
        return
    end

    -- Create floating window from current buffer
    float_buf = vim.api.nvim_get_current_buf()

    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    float_win = vim.api.nvim_open_win(float_buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        border = "rounded",
    })
end

keymap_set("n", "<leader>wf", toggle_float, "float-window")
keymap_set("n", "<C-w>f", toggle_float, "float-window")
