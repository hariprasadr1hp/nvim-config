-- lua/plugins/themes/kanagawa.lua

local function setup_kanagawa_config()
    require("kanagawa").setup({
        compile = false,
        undercurl = true,
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false,
        dimInactive = false,
        terminalColors = true,
        colors = {
            palette = {},
            theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        overrides = function(colors)
            return {}
        end,
        theme = "dragon",
        background = {
            dark = "dragon",
            light = "lotus",
        },
    })

    -- vim.cmd("colorscheme kanagawa")
end

return {
    {
        "rebelot/kanagawa.nvim",
        priority = 1000,
        config = setup_kanagawa_config,
    },
}
