-- lua/plugins/multicursors.lua

-- FIX: multicursor commands only work (on x mode), only after the keymaps are triggered

local setup_multicursors_config = function()
    local cursors = require("multiple-cursors")
    cursors.setup({})

    local map = vim.keymap.set
    local key_opts = { noremap = true, silent = true }

    map({ "n", "x" }, "<C-j>", ":MultipleCursorsAddDown<CR>", key_opts)
    map({ "n", "x" }, "<C-k>", ":MultipleCursorsAddUp<CR>", key_opts)
    map({ "n", "x" }, "<C-Up>", ":MultipleCursorsAddUp<CR>", key_opts)
    map({ "n", "x" }, "<C-Down>", ":MultipleCursorsAddDown<CR>", key_opts)
    map({ "n", "x" }, "<C-LeftMouse>", ":MultipleCursorsMouseAddDelete<CR>", key_opts)
    map({ "n", "x" }, "<leader>xa", ":MultipleCursorsAddMatches<CR>", key_opts)
    map({ "n", "x" }, "<leader>xA", ":MultipleCursorsAddMatchesV<CR>", key_opts)
    map({ "n", "x" }, "<leader>xd", ":MultipleCursorsAddJumpNextMatch<CR>", key_opts)
    map({ "n", "x" }, "<leader>xD", ":MultipleCursorsJumpNextMatch<CR>", key_opts)
    map({ "n", "x" }, "<leader>xl", ":MultipleCursorsLock<CR>", key_opts)
end

local setup_multicursors = function()
    MiniDeps.add({
        source = "brenton-leighton/multiple-cursors.nvim",
        checkout = "v0.15",
    })
    setup_multicursors_config()
end

MiniDeps.later(setup_multicursors)
