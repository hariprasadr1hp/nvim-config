-- lua/plugins/cursor.lua

local use_local_or_remote_plugin_path = require("config.helpers").use_local_or_remote_plugin_path

return {
    use_local_or_remote_plugin_path(
        "cursor.nvim",
        vim.fn.stdpath("config") .. "/lua/plugins/custom/cursor.nvim",
        "hariprasadr1hp/cursor.nvim",
        {
            cmd = {
                "CursorRules",
            },
            dependencies = {},
            config = function()
                require("cursor").setup({
                    keymaps_enabled = true,
                    rules_enabled = true,
                })
            end,
        }
    ),
}
