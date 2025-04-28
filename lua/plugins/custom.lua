-- lua/plugins/custom.lua

local function setup_custom_config()
    -- print("cogito, ergo sum")
end

return {
    {
        dir = vim.env.CUSTOM_PLUGIN_DIR,
        name = "cplug",
        config = setup_custom_config,
    },
}
