-- lua/plugins/custom.lua

local function setup_custom_config()
    print("cogito, ergo sum")
end

return {
    {
        dir = vim.env.CUSTOM_PLUGIN_DIR,
        name = "cplug",
        dev = true,
        lazy = true,
        dependencies = {
            "ibhagwan/fzf-lua",
            "stevearc/conform.nvim",
            "mfussenegger/nvim-lint",
        },
        config = setup_custom_config,
    },
}
