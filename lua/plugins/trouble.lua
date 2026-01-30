-- lua/plugins/trouble.lua

return {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    -- TODO: `:Trouble profiler`???
    -- TODO: `:Trouble symbols`???
    -- TODO: fzf-lua integration
    -- TODO: code-companion integration (slash-command)
    -- TODO: trouble-to-quickfix, possible?
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
            { "<leader>rt", trouble.refresh, desc = "trouble-reload" },

            {
                "<leader>vd1",
                "<cmd>Trouble diagnostics filter.severity=vim.diagnostic.severity.ERROR<cr>",
                desc = "only-errors",
            },

            {
                "<leader>vd2",
                "<cmd>Trouble diagnostics filter.severity=vim.diagnostic.severity.WARNING<cr>",
                desc = "only-warnings",
            },

            {
                "<leader>vd3",
                "<cmd>Trouble diagnostics filter.severity=vim.diagnostic.severity.INFO<cr>",
                desc = "only-info",
            },

            {
                "<leader>vd4",
                "<cmd>Trouble diagnostics filter.severity=vim.diagnostic.severity.HINT<cr>",
                desc = "only-hints",
            },

            {
                "<leader>vd5",
                "<cmd>Trouble diagnostics filter = { severity={vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARNING} }<cr>",
                desc = "errors-and-warnings",
            },

            {
                "<leader>vd6",
                "<cmd>Trouble diagnostics filter = { severity={vim.diagnostic.severity.HINT, vim.diagnostic.severity.INFO} }<cr>",
                desc = "hints-and-info",
            },

            { "<leader>vdd", "<cmd>Trouble diagnostics<cr>", desc = "all-diagnostics" },
            { "<leader>vk", trouble.close, desc = "close" },

            { "<leader>vl0", "<cmd>Trouble lsp_outgoing_calls<cr>", desc = "lsp-outgoing-calls" },
            { "<leader>vl1", "<cmd>Trouble lsp_incoming_calls<cr>", desc = "lsp-incoming-calls" },
            { "<leader>vlD", "<cmd>Trouble lsp_definitions<cr>", desc = "lsp-definitions" },
            { "<leader>vld", "<cmd>Trouble lsp_declarations<cr>", desc = "lsp-declarations" },
            { "<leader>vlf", "<cmd>Trouble lsp_references<cr>", desc = "lsp-reFerences" },
            { "<leader>vli", "<cmd>Trouble lsp_implementations<cr>", desc = "lsp-implementations" },
            { "<leader>vlo", "<cmd>Trouble lsp_document_symbols<cr>", desc = "lsp-document-symbols" },

            { "<leader>vo", "<cmd>Trouble open<cr>", desc = "open" },
            { "<leader>vq", "<cmd>Trouble quickfix<cr>", desc = "quickfix" },
            { "<leader>vQ", "<cmd>Trouble loclist<cr>", desc = "llist" },
            { "<leader>vr", trouble.refresh, desc = "refresh" },
            { "<leader>vs", "<cmd>Trouble symbols<cr>", desc = "symbols" },
            { "<leader>vt", "<cmd>Trouble todo<cr>", desc = "todo-list" },
        }
    end,
}
