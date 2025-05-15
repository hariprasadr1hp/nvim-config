-- lua/plugins/themes/oxocarbon.lua

local function setup_carbon_config()
    -- vim.cmd.colorscheme("oxocarbon")
end

return {
    "nyoom-engineering/oxocarbon.nvim",
    priority = 1000,
    config = setup_carbon_config,
}
