-- lua/plugins/mini.lua

local function setup_mini_snippets()
    local gen_loader = require("mini.snippets").gen_loader
    local opts = {
        snippets = {
            -- Load custom file with global snippets first
            gen_loader.from_file("~/.config/nvim/snippets/global.json"),

            -- Load snippets based on current language by reading files from
            -- "snippets/" subdirectories from 'runtimepath' directories.
            gen_loader.from_lang(),
        },
        mappings = {
            expand = "",

            -- Interact with default `expand.insert` session.
            -- Created for the duration of active session(s)
            jump_next = "<C-l>",
            jump_prev = "<C-h>",
            stop = "<C-c>",
        },
    }
    require("mini.snippets").setup(opts)
end

local mini_comment_opts = {
    -- Options which control module behavior
    options = {
        -- Function to compute custom 'commentstring' (optional)
        custom_commentstring = nil,

        -- Whether to ignore blank lines in actions and textobject
        ignore_blank_line = false,

        -- Whether to recognize as comment only lines without indent
        start_of_line = false,

        -- Whether to force single space inner padding for comment parts
        pad_comment_parts = true,
    },

    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
        -- Toggle comment (like `gcip` - comment inner paragraph) for both
        -- Normal and Visual modes
        -- comment = "gc",
        comment = "<leader>/",

        -- Toggle comment on current line
        -- comment_line = "gcc",
        comment_line = "<leader>/",

        -- Toggle comment on visual selection
        -- comment_visual = "gc",
        comment_visual = "<leader>/",

        -- Define "comment" textobject (like `dgc` - delete whole comment block)
        -- Works also in Visual mode if mapping differs from `comment_visual`
        -- textobject = "gc",
        textobject = "<leader>/",
    },

    -- Hook functions to be executed at certain stage of commenting
    hooks = {
        -- Before successful commenting. Does nothing by default.
        pre = function() end,
        -- After successful commenting. Does nothing by default.
        post = function() end,
    },
}

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

local mini_icon_opts = {
    -- Icon style: 'glyph' or 'ascii'
    style = "glyph",

    -- Customize per category. See `:h MiniIcons.config` for details.
    default = {},
    directory = {},
    extension = {},
    file = {},
    filetype = {},
    lsp = {},
    os = {},

    -- Control which extensions will be considered during "file" resolution
    -- use_file_extension = function(ext, file) return true end,
}

local mini_starter_opts = {
    -- Whether to open Starter buffer on VimEnter. Not opened if Neovim was
    -- started with intent to show something else.
    autoopen = false,

    -- Whether to evaluate action of single active item
    evaluate_single = false,

    -- Items to be displayed. Should be an array with the following elements:
    -- - Item: table with <action>, <name>, and <section> keys.
    -- - Function: should return one of these three categories.
    -- - Array: elements of these three types (i.e. item, array, function).
    -- If `nil` (default), default items will be used (see |mini.starter|).
    items = nil,

    -- Header to be displayed before items. Converted to single string via
    -- `tostring` (use `\n` to display several lines). If function, it is
    -- evaluated first. If `nil` (default), polite greeting will be used.
    header = nil,

    -- Footer to be displayed after items. Converted to single string via
    -- `tostring` (use `\n` to display several lines). If function, it is
    -- evaluated first. If `nil` (default), default usage help will be shown.
    footer = nil,

    -- Array  of functions to be applied consecutively to initial content.
    -- Each function should take and return content for Starter buffer (see
    -- |mini.starter| and |MiniStarter.get_content()| for more details).
    content_hooks = nil,

    -- Characters to update query. Each character will have special buffer
    -- mapping overriding your global ones. Be careful to not add `:` as it
    -- allows you to go into command mode.
    query_updaters = "abcdefghijklmnopqrstuvwxyz0123456789_-.",

    -- Whether to disable showing non-error feedback
    silent = false,
}

local mini_notify_opts = {
    -- Content management
    content = {
        -- Function which formats the notification message
        -- By default prepends message with notification time
        format = nil,
        -- Function which orders notification array from most to least important
        -- By default orders first by level and then by update timestamp
        sort = nil,
    },

    -- Notifications about LSP progress
    lsp_progress = {
        -- Whether to enable showing
        enable = true,
        -- Notification level
        level = "INFO",
        -- Duration (in ms) of how long last message should be shown
        duration_last = 1000,
    },

    -- Window options
    window = {
        -- Floating window config
        config = {},
        -- Maximum window width as share (between 0 and 1) of available columns
        max_width_share = 0.382,
        -- Value of 'winblend' option
        winblend = 25,
    },
}

local function setup_mini_config()
    require("mini.ai").setup(mini_ai_opts)
    require("mini.surround").setup(mini_surrround_opts)
    require("mini.hipatterns").setup(mini_hipatterns_opts)
    require("mini.pick").setup()
    require("mini.extra").setup()
    require("mini.files").setup()
    require("mini.trailspace").setup()
    require("mini.operators").setup()
    require("mini.move").setup()
    require("mini.splitjoin").setup()
    require("mini.align").setup()
    require("mini.test").setup()
    require("mini.doc").setup()
    require("mini.diff").setup()
    require("mini.sessions").setup()
    require("mini.colors").setup()
    require("mini.comment").setup(mini_comment_opts)
    require("mini.icons").setup(mini_icon_opts)
    require("mini.fuzzy").setup()
    require("mini.git").setup()
    require("mini.starter").setup(mini_starter_opts)

    local hues = require("mini.hues")
    hues.setup(hues.gen_random_base_colors())

    vim.api.nvim_create_user_command("RandomThemeGenerate", function()
        MiniHues.setup(MiniHues.gen_random_base_colors())
    end, {
        desc = "generate a theme using random fg and bg colors",
    })

    setup_mini_snippets()
    require("mini.notify").setup(mini_notify_opts)

    local map = require("config.helpers").map

    map("n", "<leader>,", ":Pick files<CR>", "files")
    map("n", "<leader>we", MiniHues.gen_random_base_colors, "files")
end

return {
    {
        "echasnovski/mini.nvim",
        event = "VeryLazy",
        version = false,
        config = setup_mini_config,
    },
}
