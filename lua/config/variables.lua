-- lua/config/variables.lua

local M = {}

-- Flag to track if autocmd debug is enabled
M.autocmd_debug_enabled = false

-- Dedicated augroup
M.autocmd_debug_augroup = vim.api.nvim_create_augroup("AutocmdDebug", { clear = true })

-- Events to watch
M.autocmd_debug_events = {
    "BufAdd",
    "BufDelete",
    "BufEnter",
    "BufLeave",
    "BufNew",
    "BufNewFile",
    "BufWinEnter",
    "BufWinLeave",
    "BufWipeout",
    "CmdlineEnter",
    "CmdlineLeave",
    "CursorMoved",
    "CursorMovedI",
    "DirChanged",
    "FileType",
    "FocusGained",
    "FocusLost",
    "InsertEnter",
    "InsertLeave",
    "ModeChanged",
    "TermClose",
    "TermEnter",
    "TermLeave",
    "TermOpen",
    "TextChanged",
    "TextChangedI",
    "UIEnter",
    "UILeave",
    "VimEnter",
    "VimLeavePre",
    "WinEnter",
    "WinLeave",
}

return M
