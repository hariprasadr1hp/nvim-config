-- lua/plugins/custom/buffer/resize.lua

-- to resize window interactively, rather than pressing `<C-w>>/<` everytime
-- `:WindowResizeModeEnter` to enter the mode
-- once entered, h/j/k/l or arrow keys to resize interactively
-- `q/i` to quit mode

local nvim_echo = vim.api.nvim_echo
local nvim_buf_del_keymap = vim.api.nvim_buf_del_keymap
local keymap_set = require("config.helpers").keymap_set
local mini_notify = require("mini.notify")

local M = {}

---@return nil
function M.exit_window_resize_mode()
    local cmd_message = "-- window-resize-mode succesfully exited!"
    local notify_message = "✓ Window resize mode exited"

    if vim.g.win_resize_interactive_notif_id then
        pcall(function()
            mini_notify.remove(vim.g.win_resize_interactive_notif_id)
        end)
        vim.g.win_resize_interactive_notif_id = nil
    end

    vim.notify(notify_message)
    nvim_echo({ { cmd_message, "InfoMsg" } }, false, {})

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

---@return nil
function M.enter_window_resize_mode()
    -- TODO: replace with `nvim_echo` with `mini.notify`
    local cmd_message = "-- window-resize-mode: Use h/j/k/l or arrows to resize, q/i to exit --"
    local notify_message = [[

╭─ Window Resize Mode ─╮
│                      │
│  h/j/k/l or arrows   │
│  to resize window    │
│                      │
│  q/i to exit mode    │
│                      │
╰──────────────────────╯
    ]]

    local ok, result = pcall(function()
        return mini_notify.add(notify_message, "INFO", "DiagnosticInfo", {})
    end)

    if ok and result then
        vim.g.win_resize_interactive_notif_id = result
    end

    nvim_echo({ { cmd_message, "WarningMsg" } }, false, {})

    keymap_set("n", "h", ":vertical resize +1<cr>", "move l/r", { buffer = 0 })
    keymap_set("n", "k", ":resize +1<cr>", "move u/d", { buffer = 0 })
    keymap_set("n", "j", ":resize -1<cr>", "move u/d", { buffer = 0 })
    keymap_set("n", "l", ":vertical resize -1<cr>", "move l/r", { buffer = 0 })
    keymap_set("n", "q", M.exit_window_resize_mode, "quit-resize-mode", { buffer = 0 })
    keymap_set("n", "i", M.exit_window_resize_mode, "quit-resize-mode", { buffer = 0 })
    keymap_set("n", "<up>", ":resize +1<cr>", "move u/d", { buffer = 0 })
    keymap_set("n", "<down>", ":resize -1<cr>", "move u/d", { buffer = 0 })
    keymap_set("n", "<right>", ":vertical resize +1<cr>", "move l/r", { buffer = 0 })
    keymap_set("n", "<left>", ":vertical resize -1<cr>", "move l/r", { buffer = 0 })
end

return M
