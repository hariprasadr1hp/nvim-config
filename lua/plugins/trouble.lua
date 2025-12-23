-- lua/plugins/trouble.lua

return {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    -- TODO: `:Trouble profiler`???
    -- TODO: `:Trouble symbols`???
    -- TODO: fzf-lua integration
    -- TODO: code-companion integration (slash-command)
    -- TODO: trouble-to-quickfix
    keys = {
        {
            "<leader>qbd",
            "<cmd>Trouble diagnostics<cr>",
            desc = "diagnostics",
        },

        {
            "<leader>qbo",
            "<cmd>Trouble lsp_document_symbols<cr>",
            desc = "document-symbols",
        },

        {
            "<leader>qbq",
            "<cmd>Trouble quickfix<cr>",
            desc = "quickfix",
        },

        {
            "<leader>qbQ",
            "<cmd>Trouble qflist<cr>",
            desc = "qflist",
        },

        {
            "<leader>qbl",
            "<cmd>Trouble loclist<cr>",
            desc = "llist",
        },
        {
            "<leader>qbt",
            "<cmd>Trouble todo<cr>",
            desc = "todo-list",
        },
    },
}
