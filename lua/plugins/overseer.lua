-- lua/plugins/overseer.lua

return {
    "stevearc/overseer.nvim",
    ---@module 'overseer'
    ---@type overseer.SetupOpts
    opts = {},
    keys = {
        { "<leader>mA", "<cmd>OverseerShell<CR>", desc = "add-overseer-job" },
        { "<leader>mo", "<cmd>OverseerRun<CR>", desc = "overseer-run" },
        -- TODO: uniquely identifying multiple runs of the same job at `:OverseerTaskAction`
        { "<leader>mO", "<cmd>OverseerTaskAction<CR>", desc = "overseer-run-action" },
        { "<leader>oj", "<cmd>OverseerToggle right<CR>", desc = "jobs-overseer" },
    },
}
