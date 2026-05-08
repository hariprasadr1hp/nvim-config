-- lua/plugins/mini.lua

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

local function setup_mini_icons_config()
    local opts = {
        style = "glyph",
        default = {},
        directory = {},
        extension = {},
        file = {},
        filetype = {},
        lsp = {},
        os = {},
    }
    require("mini.icons").setup(opts)
end

local function setup_mini_pairs_config()
    local opts = {
        modes = { insert = true, command = false, terminal = false },

        mappings = {
            ["("] = { action = "open", pair = "()", neigh_pattern = "^[^\\]" },
            ["["] = { action = "open", pair = "[]", neigh_pattern = "^[^\\]" },
            ["{"] = { action = "open", pair = "{}", neigh_pattern = "^[^\\]" },

            [")"] = { action = "close", pair = "()", neigh_pattern = "^[^\\]" },
            ["]"] = { action = "close", pair = "[]", neigh_pattern = "^[^\\]" },
            ["}"] = { action = "close", pair = "{}", neigh_pattern = "^[^\\]" },

            ['"'] = { action = "closeopen", pair = '""', neigh_pattern = '[^%w"][^"]', register = { cr = false } },
            ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a'][^']", register = { cr = false } },
            ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^%w`][^`]", register = { cr = false } },
        },
    }
    require("mini.pairs").setup(opts)

    -- TODO: create`ToggleAutopairs` usercommand

    -- Filetype-specific pairs using mini.pairs' built-in API
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "tex",
        callback = function()
            -- Use MiniPairs.map_buf() to add buffer-local pairs
            require("mini.pairs").map_buf(0, "i", "$", {
                action = "closeopen",
                pair = "$$",
                neigh_pattern = "[^\\$][^$]",
                register = { cr = false },
            })
        end,
        desc = "Add $$ autopair for TeX files",
    })
end

local function setup_mini_config()
    require("mini.trailspace").setup()
    require("mini.splitjoin").setup()
    require("mini.doc").setup()
    require("mini.sessions").setup()
    require("mini.colors").setup()

    setup_mini_icons_config()
    setup_mini_pairs_config()

    -- local hues = require("mini.hues")
    -- hues.setup(hues.gen_random_base_colors())
    --
    -- vim.api.nvim_create_user_command("RandomThemeGenerate", function()
    --     MiniHues.setup(MiniHues.gen_random_base_colors())
    -- end, {
    --     desc = "generate a theme using random fg and bg colors",
    -- })

    -- map("n", "<leader>yy", ":RandomThemeGenerate<cr>", "random-theme")
end

return {
    {
        "echasnovski/mini.nvim",
        event = "VeryLazy",
        version = false,
        config = setup_mini_config,
    },
}
