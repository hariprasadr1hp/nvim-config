-- lua/plugins/multicursors.lua

-- FIX: multicursor commands only work (on x mode), only after the keymaps are triggered

-- FIX: disable autopairs while using multicursors

return {
    "brenton-leighton/multiple-cursors.nvim",
    version = "*",
    event = "BufReadPre",
    opts = {},
    cmd = { "MultipleCursorsAddVisualArea" },
    keys = {
        { "<C-j>", "<Cmd>MultipleCursorsAddDown<CR>", mode = { "n", "x" }, desc = "add-cursor-and-move-down" },
        { "<C-k>", "<Cmd>MultipleCursorsAddUp<CR>", mode = { "n", "x" }, desc = "add-cursor-and-move-up" },
        { "<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", mode = { "n", "i", "x" }, desc = "add-cursor-and-move-up" },
        { "<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>", mode = { "n", "i", "x" }, desc = "add-cursor-and-move-down" },
        {
            "<C-LeftMouse>",
            "<Cmd>MultipleCursorsMouseAddDelete<CR>",
            mode = { "n", "i" },
            desc = "add-or-remove-cursor",
        },
        -- {"<leader>m", "<Cmd>MultipleCursorsAddVisualArea<CR>", mode = {"x"}, desc = "Add cursors to the lines of the visual area"},
        { "<leader>xa", "<Cmd>MultipleCursorsAddMatches<CR>", mode = { "n", "x" }, desc = "add-cursors-to-cword" },
        {
            "<leader>xA",
            "<Cmd>MultipleCursorsAddMatchesV<CR>",
            mode = { "n", "x" },
            desc = "add-cursors-to-cword-in-previous-area",
        },
        {
            "<leader>xd",
            "<Cmd>MultipleCursorsAddJumpNextMatch<CR>",
            mode = { "n", "x" },
            desc = "add-cursor-and-jump-to-next-cword",
        },
        { "<leader>xD", "<Cmd>MultipleCursorsJumpNextMatch<CR>", mode = { "n", "x" }, desc = "jump-to-next-cword" },
        { "<leader>xl", "<Cmd>MultipleCursorsLock<CR>", mode = { "n", "x" }, desc = "lock-virtual-cursors" },
    },
}
