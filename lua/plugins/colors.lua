-- lua/plugins/color.lua

-- FIX: make the plugin work

return {
    "uhs-robert/color-chameleon.nvim",
    lazy = false,
    priority = 900,
    config = function()
        require("color-chameleon").setup({
            rules = {
                { filetype = "codecompanion", colorscheme = "minispring" },
            },
            default = "kanagawa-dragon",
            keymaps = false,
        })
    end,
}
