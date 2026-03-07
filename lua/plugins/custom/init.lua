-- lua/plugins/custom/init.lua

return {
    {
        dir = vim.fn.stdpath("config") .. "/lua/plugins/custom",
        name = "hpcustom",
        cmd = {
            "BufferActions",
            "BufferInfo",
            "ProjectPrintEnv",
            "ProjectCopyEnv",
        },
        keys = {
            { "<leader>;a", "<cmd>BufferActions<cr>", desc = "actions-by-ft" },
            { "<leader>pa", "<cmd>ProjectActions<cr>", desc = "project-actions" },
            { "<leader>bi", "<cmd>BufferInfo<cr>", desc = "buffer-info" },
            { "<leader>ib", "<cmd>BufferInfo<cr>", desc = "buffer-info" },
            { "<leader>ip", "<cmd>ProjectInfo<cr>", desc = "buffer-info" },
            { "<leader>wa", "<cmd>WindowResizeModeEnter<cr>", desc = "window-resize-mode" },
            { "<C-w>a", "<cmd>WindowResizeModeEnter<cr>", desc = "window-resize-mode" },
        },
        dependencies = {
            { "saghen/blink.cmp" },
            { "echasnovski/mini.notify" },
            { "akinsho/toggleterm.nvim" },
        },
        config = function()
            require("plugins.custom.extract").setup({})
            require("plugins.custom.ui").setup({})
            require("plugins.custom.buffer").setup({})
            require("plugins.custom.project").setup({})
            require("plugins.custom.window").setup({})
        end,
        -- opts = {},
    },
}
