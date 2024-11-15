-- lua/plugins/substitute.lua

local M = {}

local opts = {
    on_substitute = nil,
    yank_substituted_text = false,
    preserve_cursor_position = false,
    modifiers = nil,
    highlight_substituted_text = {
        enabled = true,
        timer = 500,
    },
    range = {
        prefix = "s",
        prompt_current_text = false,
        confirm = false,
        complete_word = false,
        subject = nil,
        range = nil,
        suffix = "",
        auto_apply = false,
        cursor_position = "end",
    },
    exchange = {
        motion = false,
        use_esc_to_cancel = true,
        preserve_cursor_position = false,
    },
}

local function setup_substitute_config()
    local substitute = require("substitute")

    vim.keymap.set("n", "s", substitute.operator, { noremap = true })
    vim.keymap.set("n", "ss", substitute.line, { noremap = true })
    vim.keymap.set("n", "S", substitute.eol, { noremap = true })
    vim.keymap.set("x", "s", substitute.visual, { noremap = true })
end

M = {
    "gbprod/substitute.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = opts,
    config = setup_substitute_config,
}

return M
