-- lua/plugins/text_transform.lua

local function setup_text_transform()
    require("text-transform").setup({
        --- Prints information about internals of the plugin. Very verbose, only useful for debugging.
        debug = false,
        --- Keymap configurations
        keymap = {
            --- Keymap to open the telescope popup. Set to `false` or `nil` to disable keymapping
            --- You can always customize your own keymapping manually.
            telescope_popup = {
                --- Opens the popup in normal mode
                ["n"] = "<Leader>~",
                --- Opens the popup in visual/visual block modes
                ["v"] = "<Leader>~",
            },
        },
        ---
        --- Configurations for the text-transform replacers
        --- Keys indicate the replacer name, and the value is a table with the following options:
        ---
        --- - `enabled` (boolean): Enable or disable the replacer - disabled replacers do not show up in the popup.
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
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        config = setup_text_transform,
    },
}
