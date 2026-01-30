-- lua/plugins/text_transform.lua

local function setup_text_transform()
    require("text-transform").setup({
        debug = false,
        keymap = {
            telescope_popup = nil,
        },
        replacers = {
            camel_case = { enabled = true },
            const_case = { enabled = true },
            dot_case = { enabled = true },
            kebab_case = { enabled = true },
            pascal_case = { enabled = true },
            snake_case = { enabled = true },
            title_case = { enabled = true },
        },

        ---@type "frequency" | "name"
        sort_by = "frequency",

        ---@type "telescope" | "select"
        popup_type = "select",
    })
end

return {
    {
        "chenasraf/text-transform.nvim",
        version = "*",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = setup_text_transform,
        cmd = {
            "TtTitle",
            "TtCamel",
            "TtConst",
            "TtDot",
            "TtKebab",
            "TtPascal",
            "TtSnake",
            "TtSelect",
        },
    },
}
