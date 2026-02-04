-- lua/plugins/trouble.lua

return {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    -- TODO: `:Trouble profiler` (as quickfix-list)
    -- TODO: `:Trouble symbols` (as quickfix-list)
    -- TODO: `:Trouble lsp_*` (as quickfix-list)
    -- TODO: fzf-lua integration
    -- TODO: code-companion integration (slash-command)
    keys = function()
        local trouble = require("trouble")

        return {
            { "<leader>iq", "<cmd>Trouble quickfix<cr>", desc = "quickfix-pretty" },
            { "<leader>iQ", "<cmd>Trouble loclist<cr>", desc = "loclist-pretty" },
            { "<leader>qlp", "<cmd>Trouble loclist<cr>", desc = "pretty-mode" },
            {
                "<leader>q0",
                function()
                    vim.fn.setqflist(trouble.get_items())
                end,
                desc = "trouble",
            },
            { "<leader>qp", "<cmd>Trouble quickfix<cr>", desc = "pretty-mode" },
            { "<leader>rt", trouble.refresh, desc = "trouble-list-refresh" },
            { "<leader>stk", trouble.close, desc = "close" },
            { "<leader>sto", trouble.open, desc = "open" },
            { "<leader>stq", "<cmd>Trouble quickfix<cr>", desc = "quickfix" },
            { "<leader>stQ", "<cmd>Trouble loclist<cr>", desc = "llist" },
            { "<leader>str", trouble.refresh, desc = "refresh" },
        }
    end,
}
