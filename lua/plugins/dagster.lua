-- lua/plugins/dagster.lua

local use_local_or_remote_plugin_path = require("config.helpers").use_local_or_remote_plugin_path

return {
    use_local_or_remote_plugin_path(
        "dagster.nvim",
        vim.fn.stdpath("config") .. "/lua/plugins/custom/dagster.nvim",
        "hariprasadr1hp/dagster.nvim",
        {
            cmd = {
                "DagsterInfo",
            },
            dependencies = {
                { "mistweaverco/kulala.nvim" },
            },
            config = function()
                require("dagster").setup({
                    keymaps_enabled = true,
                })
            end,
        }
    ),
}
