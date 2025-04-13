-- lua/plugins/mini.lua

local M = {}

local function setup_mini_plugin()
    require("mini.pick").setup()
    require("mini.deps").setup()
end

M = {
    {
        "echasnovski/mini.nvim",
        -- version = "*",
        version = false,
        config = function()
            setup_mini_plugin()
        end,
    },
}

return M
