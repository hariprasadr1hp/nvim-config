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

local mini_hipatterns_opts = {
    highlighters = {},
    delay = {
        text_change = 200,
        scroll = 50,
    },
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

local function setup_mini_config()
    require("mini.ai").setup(mini_ai_opts)
    require("mini.surround").setup(mini_surrround_opts)
    require("mini.hipatterns").setup(mini_hipatterns_opts)
    require("mini.extra").setup()
    require("mini.trailspace").setup()
    require("mini.operators").setup()
    require("mini.move").setup()
    require("mini.splitjoin").setup()
    require("mini.align").setup()
    require("mini.doc").setup()
    require("mini.sessions").setup()
    require("mini.colors").setup()
    require("mini.icons").setup(mini_icon_opts)
    require("mini.fuzzy").setup()

    -- local hues = require("mini.hues")
    -- hues.setup(hues.gen_random_base_colors())
    --
    -- vim.api.nvim_create_user_command("RandomThemeGenerate", function()
    --     MiniHues.setup(MiniHues.gen_random_base_colors())
    -- end, {
    --     desc = "generate a theme using random fg and bg colors",
    -- })

    local keymap_set = require("config.helpers").keymap_set

    keymap_set("n", "<leader>,", ":Pick files<CR>", "files")
    keymap_set("n", "<leader>bB", ":Pick buffers<CR>", "buffers")
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
