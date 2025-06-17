-- lua/plugins/custom/init.lua

return {
    {
        dir = vim.fn.stdpath("config") .. "/lua/plugins/custom/buffer",
        name = "zzbuffer",
        cmd = {
            "BufferActions",
            "BufferInfo",
        },
        keys = {
            { "<leader>aa", "<cmd>BufferActions<CR>", desc = "actions-by-ft" },
            { "<leader>ib", "<cmd>BufferInfo<CR>", desc = "buffer-info" },
        },
        dependencies = {
            { "saghen/blink.cmp" },
        },
        config = function()
            require("plugins.custom.buffer").setup({})
        end,
        -- opts = {},
    },
}
