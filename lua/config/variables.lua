-- lua/config/variables.lua

local M = {}

-- Flag to track if autocmd debug is enabled
M.autocmd_debug_enabled = false

-- Dedicated augroup
M.autocmd_debug_augroup = vim.api.nvim_create_augroup("AutocmdDebug", { clear = true })

-- Events to watch
M.autocmd_debug_events = {
    "BufEnter",
    "BufLeave",
    "BufWinEnter",
    "BufWinLeave",
    "WinEnter",
    "WinLeave",
    "InsertEnter",
    "InsertLeave",
    "TermEnter",
    "TermLeave",
    "TermOpen",
    "TermClose",
    "VimEnter",
    "VimLeavePre",
    "CmdlineEnter",
    "CmdlineLeave",
    "ModeChanged",
    "CursorMoved",
    "CursorMovedI",
    "TextChanged",
    "TextChangedI",
    "DirChanged",
    "FileType",
    "FocusGained",
    "FocusLost",
    "UIEnter",
    "UILeave",
}

return M
