-- lua/plugins/refactor.lua

local keymap_set = require("config.helpers").keymap_set

local function setup_refactoring_config()
    local refactoring = require("refactoring")

    refactoring.setup({
        prompt_func_return_type = {
            lua = true,
            python = true,
        },

        prompt_func_param_type = {
            lua = true,
            python = true,
        },
        printf_statements = {},
        print_var_statements = {},
        show_success_message = true, -- shows a message with information about the refactor on success
        -- i.e. [Refactor] Inlined 3 variable occurrences
    })
end

return {
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        keys = {
            { "<leader>rre", mode = { "n", "x" }, ":Refactor extract<cr>", desc = "extract" },
            { "<leader>rrf", mode = { "n", "x" }, ":Refactor extract_to_file<cr>", desc = "extract-to-file" },
            { "<leader>rrv", mode = { "n", "x" }, ":Refactor extract_var<cr>", desc = "refactor-var" },
            { "<leader>rri", mode = { "n", "x" }, ":Refactor inline_var<cr>", desc = "refactor-inline-var" },
            { "<leader>rrI", mode = { "n", "x" }, ":Refactor inline_func<cr>", desc = "refactor-func" },
            { "<leader>rrb", mode = { "n", "x" }, ":Refactor extract_block<cr>", desc = "extract-block" },
            {
                "<leader>rrF",
                mode = { "n", "x" },
                ":Refactor extract_block_to_file<cr>",
                desc = "extract-block-to-file",
            },
        },
        config = setup_refactoring_config,
    },
}

-- TODO: additional functionalities?
