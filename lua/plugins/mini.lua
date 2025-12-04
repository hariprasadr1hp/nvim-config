-- lua/plugins/mini.lua

local mini_ai_opts = {
    custom_textobjects = nil,
    mappings = {
        around = "a",
        inside = "i",

        around_next = "an",
        inside_next = "in",
        around_last = "al",
        inside_last = "il",

        goto_left = "g[",
        goto_right = "g]",
    },
    n_lines = 50,
    search_method = "cover_or_next",
    silent = false,
}

local mini_surrround_opts = {
    custom_surroundings = nil,
    highlight_duration = 500,
    mappings = {
        add = "sa",
        delete = "sd",
        find = "sf",
        find_left = "sF",
        highlight = "sh",
        replace = "sr",
        update_n_lines = "sn",

        suffix_last = "l",
        suffix_next = "n",
    },
    n_lines = 20,
    respect_selection_type = false,
    search_method = "cover",
    silent = false,
}

local mini_icon_opts = {
    style = "glyph",
    default = {},
    directory = {},
    extension = {},
    file = {},
    filetype = {},
    lsp = {},
    os = {},
}

local function setup_mini_hipatterns_config()
    local mini_hipatterns = require("mini.hipatterns")
    mini_hipatterns.setup({
        highlighters = {
            -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
            -- fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
            -- hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
            -- todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
            -- note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

            hex_color = mini_hipatterns.gen_highlighter.hex_color(),
        },
        delay = {
            text_change = 200,
            scroll = 50,
        },
    })

    vim.api.nvim_create_user_command("HexColorToggle", function()
        local highlighters = mini_hipatterns.config.highlighters
        local hex_color = highlighters.hex_color
        if hex_color == nil then
            highlighters.hex_color = mini_hipatterns.gen_highlighter.hex_color()
        else
            highlighters.hex_color = nil
        end
    end, {
        desc = "toggle-hex-color-highlight",
    })
end

local function setup_mini_config()
    require("mini.ai").setup(mini_ai_opts)
    require("mini.extra").setup()
    require("mini.trailspace").setup()
    require("mini.operators").setup()
    require("mini.splitjoin").setup()
    require("mini.align").setup()
    require("mini.doc").setup()
    require("mini.sessions").setup()
    require("mini.colors").setup()
    require("mini.icons").setup(mini_icon_opts)
    require("mini.fuzzy").setup()

    setup_mini_hipatterns_config()

    -- local hues = require("mini.hues")
    -- hues.setup(hues.gen_random_base_colors())
    --
    -- vim.api.nvim_create_user_command("RandomThemeGenerate", function()
    --     MiniHues.setup(MiniHues.gen_random_base_colors())
    -- end, {
    --     desc = "generate a theme using random fg and bg colors",
    -- })

    -- map("n", "<leader>tt", ":RandomThemeGenerate<CR>", "random-theme")
end

return {
    {
        "echasnovski/mini.nvim",
        event = "VeryLazy",
        version = false,
        config = setup_mini_config,
    },
}
