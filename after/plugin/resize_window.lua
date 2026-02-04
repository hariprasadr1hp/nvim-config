-- after/plugin/resize_window.lua

-- to resize window interactively, rather than pressing `<C-w>>/<` everytime
-- `:WindowResizeModeEnter` to enter the mode
-- once entered, h/j/k/l or arrow keys to resize interactively
-- `q/i` to quit mode

if vim.g.vscode then
    return
end

local nvim_echo = vim.api.nvim_echo
local nvim_buf_del_keymap = vim.api.nvim_buf_del_keymap
local nvim_create_user_command = vim.api.nvim_create_user_command
local keymap_set = require("config.helpers").keymap_set

--- Window Resize Module
---@class WinResizeModule
local M = {}

function M.exit_window_resize_mode()
    nvim_echo({ { "-- window-resize-mode succesfully exited!", "InfoMsg" } }, false, {})

    nvim_buf_del_keymap(0, "n", "h")
    nvim_buf_del_keymap(0, "n", "k")
    nvim_buf_del_keymap(0, "n", "j")
    nvim_buf_del_keymap(0, "n", "l")
    nvim_buf_del_keymap(0, "n", "q")
    nvim_buf_del_keymap(0, "n", "i")
    nvim_buf_del_keymap(0, "n", "<up>")
    nvim_buf_del_keymap(0, "n", "<down>")
    nvim_buf_del_keymap(0, "n", "<right>")
    nvim_buf_del_keymap(0, "n", "<left>")
end

function M.enter_window_resize_mode()
    nvim_echo({ { "-- window-resize-mode: Use h/j/k/l or arrows to resize, q/i to exit --", "WarningMsg" } }, false, {})

    keymap_set("n", "h", ":vertical resize +1<cr>", "move l/r", { buffer = 0 })
    keymap_set("n", "k", ":resize +1<cr>", "move u/d", { buffer = 0 })
    keymap_set("n", "j", ":resize -1<cr>", "move u/d", { buffer = 0 })
    keymap_set("n", "l", ":vertical resize -1<cr>", "move l/r", { buffer = 0 })
    keymap_set("n", "q", ":WindowResizeModeExit<cr>", "quit-resize-mode", { buffer = 0 })
    keymap_set("n", "i", ":WindowResizeModeExit<cr>", "quit-resize-mode", { buffer = 0 })
    keymap_set("n", "<up>", ":resize +1<cr>", "move u/d", { buffer = 0 })
    keymap_set("n", "<down>", ":resize -1<cr>", "move u/d", { buffer = 0 })
    keymap_set("n", "<right>", ":vertical resize +1<cr>", "move l/r", { buffer = 0 })
    keymap_set("n", "<left>", ":vertical resize -1<cr>", "move l/r", { buffer = 0 })
end

function M.setup_commands()
    nvim_create_user_command("WindowResizeModeEnter", M.enter_window_resize_mode, {})
    nvim_create_user_command("WindowResizeModeExit", M.exit_window_resize_mode, {})
end

function M.setup_keymaps()
    keymap_set("n", "<C-w>a", M.enter_window_resize_mode, "window-resize-mode")
    keymap_set("n", "<leader>wa", M.enter_window_resize_mode, "window-resize-mode")
end

function M.setup()
    M.setup_commands()
    M.setup_keymaps()
end

M.setup()

return M
