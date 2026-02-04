-- lua/plugins/overseer.lua

return {
    "stevearc/overseer.nvim",
    ---@module 'overseer'
    ---@type overseer.SetupOpts
    opts = {},
    keys = {
        { "<leader>mA", "<cmd>OverseerShell<cr>", desc = "add-overseer-job" },
        { "<leader>mo", "<cmd>OverseerRun<cr>", desc = "overseer-run" },
        -- TODO: uniquely identifying multiple runs of the same job at `:OverseerTaskAction`
        { "<leader>mO", "<cmd>OverseerTaskAction<cr>", desc = "overseer-run-action" },
        { "<leader>oj", "<cmd>OverseerToggle right<cr>", desc = "jobs-overseer" },
    },
}
