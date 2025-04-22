-- lua/plugins/mini.lua

-- local mini_pairs_opts = {
--     -- In which modes mappings from this `config` should be created
--     modes = { insert = true, command = false, terminal = false },
--
--     -- Global mappings. Each right hand side should be a pair information, a
--     -- table with at least these fields (see more in |MiniPairs.map|):
--     -- - <action> - one of "open", "close", "closeopen".
--     -- - <pair> - two character string for pair to be used.
--     -- By default pair is not inserted after `\`, quotes are not recognized by
--     -- <CR>, `'` does not insert pair after a letter.
--     -- Only parts of tables can be tweaked (others will use these defaults).
--     -- Supply `false` instead of table to not map particular key.
--     mappings = {
--         ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
--         ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
--         ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },
--
--         [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
--         ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
--         ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },
--
--         ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\].", register = { cr = false } },
--         ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
--         ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },
--     },
-- }
--
-- MiniDeps.later(function()
--     require("mini.pairs").setup(mini_pairs_opts)
-- end)

local mini_ai_opts = {
    -- Table with textobject id as fields, textobject specification as values.
    -- Also use this to disable builtin textobjects. See |MiniAi.config|.
    custom_textobjects = nil,

    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
        -- Main textobject prefixes
        around = "a",
        inside = "i",

        -- Next/last textobjects
        around_next = "an",
        inside_next = "in",
        around_last = "al",
        inside_last = "il",

        -- Move cursor to corresponding edge of `a` textobject
        goto_left = "g[",
        goto_right = "g]",
    },

    -- Number of lines within which textobject is searched
    n_lines = 50,

    -- How to search for object (first inside current line, then inside
    -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
    -- 'cover_or_nearest', 'next', 'prev', 'nearest'.
    search_method = "cover_or_next",

    -- Whether to disable showing non-error feedback
    -- This also affects (purely informational) helper messages shown after
    -- idle time if user input is required.
    silent = false,
}

MiniDeps.later(function()
    require("mini.ai").setup(mini_ai_opts)
end)

local mini_surrround_opts = {
    -- Add custom surroundings to be used on top of builtin ones. For more
    -- information with examples, see `:h MiniSurround.config`.
    custom_surroundings = nil,

    -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
    highlight_duration = 500,

    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
        add = "sa", -- Add surrounding in Normal and Visual modes
        delete = "sd", -- Delete surrounding
        find = "sf", -- Find surrounding (to the right)
        find_left = "sF", -- Find surrounding (to the left)
        highlight = "sh", -- Highlight surrounding
        replace = "sr", -- Replace surrounding
        update_n_lines = "sn", -- Update `n_lines`

        suffix_last = "l", -- Suffix to search with "prev" method
        suffix_next = "n", -- Suffix to search with "next" method
    },

    -- Number of lines within which surrounding is searched
    n_lines = 20,

    -- Whether to respect selection type:
    -- - Place surroundings on separate lines in linewise mode.
    -- - Place surroundings on each line in blockwise mode.
    respect_selection_type = false,

    -- How to search for surrounding (first inside current line, then inside
    -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
    -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
    -- see `:h MiniSurround.config`.
    search_method = "cover",

    -- Whether to disable showing non-error feedback
    -- This also affects (purely informational) helper messages shown after
    -- idle time if user input is required.
    silent = false,
}

MiniDeps.later(function()
    require("mini.surround").setup(mini_surrround_opts)
end)

local mini_hipatterns_opts = {
    -- Table with highlighters (see |MiniHipatterns.config| for more details).
    -- Nothing is defined by default. Add manually for visible effect.
    highlighters = {},

    -- Delays (in ms) defining asynchronous highlighting process
    delay = {
        -- How much to wait for update after every text change
        text_change = 200,

        -- How much to wait for update after window scroll
        scroll = 50,
    },
}

MiniDeps.later(function()
    require("mini.hipatterns").setup(mini_hipatterns_opts)
end)

MiniDeps.later(function()
    require("mini.pick").setup()
end)

MiniDeps.later(function()
    require("mini.extra").setup()
end)

MiniDeps.later(function()
    require("mini.files").setup()
end)

MiniDeps.later(function()
    require("mini.trailspace").setup()
end)

MiniDeps.later(function()
    require("mini.operators").setup()
end)

MiniDeps.later(function()
    require("mini.move").setup()
end)

MiniDeps.later(function()
    require("mini.splitjoin").setup()
end)

MiniDeps.later(function()
    require("mini.align").setup()
end)

MiniDeps.later(function()
    require("mini.test").setup()
end)

MiniDeps.later(function()
    require("mini.doc").setup()
end)

MiniDeps.later(function()
    require("mini.diff").setup()
end)

MiniDeps.later(function()
    require("mini.sessions").setup()
end)

MiniDeps.later(function()
    require("mini.colors").setup()
end)

MiniDeps.later(function()
    local hues = require("mini.hues")
    hues.setup(hues.gen_random_base_colors())
end)

vim.api.nvim_create_user_command("RandomThemeGenerate", function()
    MiniHues.setup(MiniHues.gen_random_base_colors())
end, {
    desc = "generate a theme using random fg and bg colors",
})
