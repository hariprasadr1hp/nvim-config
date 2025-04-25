-- lua/plugins/terminal.lua

local opts = {
    ---@type "float" | "horizontal"
    direction = "horizontal",
}

local function setup_terminal()
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

    local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, {
            noremap = true,
            silent = true,
            desc = desc,
        })
    end

    map("t", "<M-m>", "<C-\\><C-n>:ToggleTerm<CR>", "toggle-term")
    map("t", "<C-`>", "<C-\\><C-n>:ToggleTerm<CR>", "toggle-term")
    -- map("t", "<C-`>", ":ToggleTerm<CR>", "toggle-term")
    map("n", "<M-m>", ":ToggleTerm<CR>", "toggle-term")

    map("n", "<leader>tt", ":ToggleTermSendCurrentLine<CR>", "send-cline-terminal")
    map("x", "<leader>tt", ":ToggleTermSendVisualSelection<CR>", "send-vi-select-terminal")

    map("n", "<leader>ma", function()
        toggleterm.exec(" make temp")
    end, "make temp")

    map("n", "<leader>mc", function()
        toggleterm.exec(" make clean")
    end, "make clean")

    map("n", "<leader>md", function()
        toggleterm.exec(" make debug")
    end, "make debug")

    map("n", "<leader>mf", function()
        toggleterm.exec(" make format")
    end, "make format")

    map("n", "<leader>m", function()
        toggleterm.exec(" make all")
    end, "make all")

    map("n", "<leader>mt", function()
        toggleterm.exec(" make test")
    end, "make test")

    local eval_cmd_by_ft = require("config.helpers").eval_cmd_by_ft

    map("n", "<space>ee", function()
        local cmd = eval_cmd_by_ft()
        if cmd ~= nil then
            print("executing...")
            toggleterm.exec(cmd)
        else
            print("Not sure how to execute filetype: " .. vim.bo.filetype)
        end
    end, "exec-buffer")
end

MiniDeps.later(setup_terminal)
