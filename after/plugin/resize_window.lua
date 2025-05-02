-- after/plugin/resize_window.lua

-- to resize window interactively, rather than pressing `<C-w>>/<` everytime
-- `:WindowResizeModeEnter` to enter the mode
-- once entered, h/j/k/l or arrow keys to resize interactively
-- `q/i` to quit mode

local map = require("config.helpers").map

local function exit_window_resize_mode()
    vim.api.nvim_echo({ { "-- window-resize-mode succesfully exited!", "InfoMsg" } }, false, {})

    vim.api.nvim_buf_del_keymap(0, "n", "h")
    vim.api.nvim_buf_del_keymap(0, "n", "l")
    vim.api.nvim_buf_del_keymap(0, "n", "j")
    vim.api.nvim_buf_del_keymap(0, "n", "k")
    vim.api.nvim_buf_del_keymap(0, "n", "<up>")
    vim.api.nvim_buf_del_keymap(0, "n", "<down>")
    vim.api.nvim_buf_del_keymap(0, "n", "<left>")
    vim.api.nvim_buf_del_keymap(0, "n", "<right>")
    vim.api.nvim_buf_del_keymap(0, "n", "q")
    vim.api.nvim_buf_del_keymap(0, "n", "i")
end

local function enter_window_resize_mode()
    vim.api.nvim_echo(
        { { "-- window-resize-mode: Use h/j/k/l or arrows to resize, q/i to exit --", "WarningMsg" } },
        false,
        {}
    )

    map("n", "h", ":vertical resize +1<CR>", "move l/r", { buffer = 0 })
    map("n", "k", ":resize +1<CR>", "move u/d", { buffer = 0 })
    map("n", "j", ":resize -1<CR>", "move u/d", { buffer = 0 })
    map("n", "l", ":vertical resize -1<CR>", "move l/r", { buffer = 0 })
    map("n", "q", ":WindowResizeModeExit<CR>", "quit-resize-mode", { buffer = 0 })
    map("n", "i", ":WindowResizeModeExit<CR>", "quit-resize-mode", { buffer = 0 })
    map("n", "<up>", ":resize +1<CR>", "move u/d", { buffer = 0 })
    map("n", "<down>", ":resize -1<CR>", "move u/d", { buffer = 0 })
    map("n", "<right>", ":vertical resize +1<CR>", "move l/r", { buffer = 0 })
    map("n", "<left>", ":vertical resize -1<CR>", "move l/r", { buffer = 0 })
end

map("n", "<C-w>a", enter_window_resize_mode, "window-resize-mode")
map("n", "<leader>wa", enter_window_resize_mode, "window-resize-mode")

vim.api.nvim_create_user_command("WindowResizeModeEnter", enter_window_resize_mode, {})
vim.api.nvim_create_user_command("WindowResizeModeExit", exit_window_resize_mode, {})
