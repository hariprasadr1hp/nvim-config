-- lua/plugins/terminal.lua

local opts = {
    ---@type "float" | "horizontal"
    direction = "horizontal",
}

local setup_terminal = function()
    MiniDeps.add({
        source = "voldikss/vim-floaterm",
        depends = {
            {
                source = "akinsho/toggleterm.nvim",
                checkout = "v2.13.1",
            },
        },
    })

    local toggleterm = require("toggleterm")
    toggleterm.setup(opts)

    vim.g.floaterm_gitcommit = "floaterm"
    vim.g.floaterm_autoinsert = 1
    vim.g.floaterm_width = 0.99
    vim.g.floaterm_height = 0.99
    vim.g.floaterm_wintitle = 0
    vim.g.floaterm_autoclose = 1
    vim.g.floaterm_opener = "edit"
    vim.g.floaterm_keymap_toggle = "<Leader>ot"
    -- vim.g.floaterm_keymap_toggle = "<F1>"
    -- vim.g.floaterm_keymap_next   = "<F2>"
    -- vim.g.floaterm_keymap_prev   = "<F3>"
    -- vim.g.floaterm_keymap_new    = "<F4>"
    -- vim.g.floaterm_title=""

    local key_opts = { noremap = true, silent = true }
    local map = vim.keymap.set

    map("t", "<M-m>", "<C-\\><C-n>:ToggleTerm<CR>", key_opts)
    map("n", "<M-m>", ":ToggleTerm<CR>", key_opts)
    map("n", "<leader>tt", ":ToggleTermSendCurrentLine<CR>", key_opts)
    map("x", "<leader>tt", ":ToggleTermSendVisualSelection<CR>", key_opts)
end

MiniDeps.later(setup_terminal)
