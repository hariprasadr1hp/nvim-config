-- lua/plugins/dbt.lua

local use_local_or_remote_plugin_path = require("config.helpers").use_local_or_remote_plugin_path

return {
    use_local_or_remote_plugin_path(
        "dbt.nvim",
        vim.fn.stdpath("config") .. "/lua/plugins/custom/dbt.nvim",
        "hariprasadr1hp/dbt.nvim",
        {
            cmd = {
                "DBTToggleCyclingFiles",
                "DBTUpstreamFiles",
                "DBTDownstreamFiles",
            },
            dependencies = {
                { "ibhagwan/fzf-lua" },
            },
            config = function()
                require("dbt").setup({
                    enable_keymaps = true,
                    cycling_enabled = true,
                })
            end,
        }
    ),
}
