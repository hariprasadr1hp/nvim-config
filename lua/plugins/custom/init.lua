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
            { "<leader>aa", "<cmd>ProjectActions<cr>", desc = "actions-project" },
            { "<leader>bi", "<cmd>BufferInfo<cr>", desc = "buffer-info" },
            { "<leader>ib", "<cmd>BufferInfo<cr>", desc = "buffer-info" },
        },
        dependencies = {
            { "saghen/blink.cmp" },
        },
        config = function()
            require("plugins.custom.extract").setup({})
            require("plugins.custom.ui").setup({})
            require("plugins.custom.buffer").setup({})
            require("plugins.custom.project").setup({})
        end,
        -- opts = {},
    },
}
