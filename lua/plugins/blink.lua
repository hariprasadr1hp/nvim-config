-- lua/plugins/blink.lua

local function setup_blink_config()
    local blink_cmp = require("blink.cmp")

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    local opts = {}

    opts.appearance = {
        highlight_ns = vim.api.nvim_create_namespace("blink_cmp"),
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = false,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
        kind_icons = {
            Text = "󰉿",
            Method = "",
            Function = "󰊕",
            Constructor = "󰒓",

            Field = "󰜢",
            Variable = "",
            Property = "",

            Class = "",
            Interface = "",
            Struct = "",
            Module = "󰅩",

            Unit = "󰪚",
            Value = "󰦨",
            Enum = "󰦨",
            EnumMember = "󰦨",

            Keyword = "󰻾",
            Constant = "󰏿",

            Snippet = "",
            Color = "󰏘",
            File = "󰈔",
            Reference = "󰬲",
            Folder = "󰉋",
            Event = "󱐋",
            Operator = "󰪚",
            TypeParameter = "󰬛",
        },
    }

    opts.cmdline = {
        enabled = true,
        -- use 'inherit' to inherit mappings from top level `keymap` config
        keymap = {
            preset = "cmdline",
            ["<Down>"] = { "select_next", "fallback" },
            ["<Up>"] = { "select_prev", "fallback" },
        },
        -- sources = function()
        --     local type = vim.fn.getcmdtype()
        --     -- Search forward and backward
        --     if type == "/" or type == "?" then
        --         return { "buffer" }
        --     end
        --     -- Commands
        --     if type == ":" or type == "@" then
        --         return { "cmdline" }
        --     end
        --     return {}
        -- end,
        completion = {
            trigger = {
                show_on_blocked_trigger_characters = {},
                show_on_x_blocked_trigger_characters = {},
            },
            list = {
                selection = {
                    -- When `true`, will automatically select the first item in the completion list
                    preselect = true,
                    -- When `true`, inserts the completion item automatically when selecting it
                    auto_insert = true,
                },
            },
            -- Whether to automatically show the window when new completion items are available
            menu = { auto_show = false },

            -- Displays a preview of the selected item on the current line
            ghost_text = { enabled = true },
        },
    }

    opts.completion = {}

    opts.completion.accept = {
        -- Write completions to the `.` register
        dot_repeat = true,
        -- Create an undo point when accepting a completion item
        create_undo_point = true,
        -- How long to wait for the LSP to resolve the item with additional information before continuing as-is
        resolve_timeout_ms = 100,
        -- Experimental auto-brackets support
        auto_brackets = {
            -- Whether to auto-insert brackets for functions
            enabled = true,
            -- Default brackets to use for unknown languages
            default_brackets = { "(", ")" },
            -- Overrides the default blocked filetypes
            override_brackets_for_filetypes = {},
            -- Synchronously use the kind of the item to determine if brackets should be added
            kind_resolution = {
                enabled = true,
                blocked_filetypes = { "typescriptreact", "javascriptreact", "vue" },
            },
            -- Asynchronously use semantic token to determine if brackets should be added
            semantic_token_resolution = {
                enabled = true,
                blocked_filetypes = { "java" },
                -- How long to wait for semantic tokens to return before assuming no brackets should be added
                timeout_ms = 400,
            },
        },
    }

    opts.completion.documentation = {
        -- Controls whether the documentation window will automatically show when selecting a completion item
        auto_show = true,
        -- Delay before showing the documentation window
        auto_show_delay_ms = 500,
        -- Delay before updating the documentation window when selecting a new item,
        -- while an existing item is still visible
        update_delay_ms = 50,
        -- Whether to use treesitter highlighting, disable if you run into performance issues
        treesitter_highlighting = true,
        -- Draws the item in the documentation window, by default using an internal treesitter based implementation
        draw = function(options)
            options.default_implementation()
        end,
        window = {
            min_width = 10,
            max_width = 80,
            max_height = 20,
            border = "rounded", -- Defaults to `vim.o.winborder` on nvim 0.11+ or 'padded' when not defined/<=0.10
            winblend = 0,
            winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
            -- Note that the gutter will be disabled when border ~= 'none'
            scrollbar = true,
            -- Which directions to show the documentation window,
            -- for each of the possible menu window directions,
            -- falling back to the next direction when there's not enough space
            direction_priority = {
                menu_north = { "e", "w", "n", "s" },
                menu_south = { "e", "w", "s", "n" },
            },
        },
    }

    opts.completion.keyword = {
        range = "prefix",
    }

    opts.completion.list = {
        -- Maximum number of items to display
        max_items = 200,

        selection = {
            -- When `true`, will automatically select the first item in the completion list
            preselect = true,
            -- preselect = function(ctx) return vim.bo.filetype ~= 'markdown' end,

            -- When `true`, inserts the completion item automatically when selecting it
            -- You may want to bind a key to the `cancel` command (default <C-e>) when using this option,
            -- which will both undo the selection and hide the completion menu
            auto_insert = true,
            -- auto_insert = function(ctx) return vim.bo.filetype ~= 'markdown' end
        },

        cycle = {
            -- When `true`, calling `select_next` at the _bottom_ of the completion list
            -- will select the _first_ completion item.
            from_bottom = true,
            -- When `true`, calling `select_prev` at the _top_ of the completion list
            -- will select the _last_ completion item.
            from_top = true,
        },
    }

    opts.completion.menu = {
        enabled = true,
        min_width = 25,
        max_height = 10,
        border = "rounded", -- Defaults to `vim.o.winborder` on nvim 0.11+
        winblend = 0,
        winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
        -- Keep the cursor X lines away from the top/bottom of the window
        scrolloff = 2,
        -- Note that the gutter will be disabled when border ~= 'none'
        scrollbar = true,
        -- Which directions to show the window,
        -- falling back to the next direction when there's not enough space
        direction_priority = { "s", "n" },

        -- Whether to automatically show the window when new completion items are available
        auto_show = true,

        -- Screen coordinates of the command line
        cmdline_position = function()
            if vim.g.ui_cmdline_pos ~= nil then
                local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
                return { pos[1] - 1, pos[2] }
            end
            local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
            return { vim.o.lines - height, 0 }
        end,

        draw = {
            -- Aligns the keyword you've typed to a component in the menu
            align_to = "label", -- or 'none' to disable, or 'cursor' to align to the cursor

            -- Left and right padding, optionally { left, right } for different padding on each side
            padding = 1,
            -- Gap between columns
            gap = 1,
            -- Use treesitter to highlight the label text for the given list of sources
            -- treesitter = {},
            treesitter = { "lsp" },

            -- Components to render, grouped by column
            columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },

            -- Definitions for possible components to render. Each defines:
            --   ellipsis: whether to add an ellipsis when truncating the text
            --   width: control the min, max and fill behavior of the component
            --   text function: will be called for each item
            --   highlight function: will be called only when the line appears on screen
            components = {
                kind_icon = {
                    ellipsis = false,
                    text = function(ctx)
                        return ctx.kind_icon .. ctx.icon_gap
                    end,
                    -- Set the highlight priority to 20000 to beat the cursorline's default priority of 10000
                    highlight = function(ctx)
                        return { { group = ctx.kind_hl, priority = 20000 } }
                    end,
                },

                kind = {
                    ellipsis = false,
                    width = { fill = true },
                    text = function(ctx)
                        return ctx.kind
                    end,
                    highlight = function(ctx)
                        return ctx.kind_hl
                    end,
                },

                label = {
                    width = { fill = true, max = 60 },
                    text = function(ctx)
                        return ctx.label .. ctx.label_detail
                    end,
                    highlight = function(ctx)
                        -- label and label details
                        local highlights = {
                            {
                                0,
                                #ctx.label,
                                group = ctx.deprecated and "BlinkCmpLabelDeprecated" or "BlinkCmpLabel",
                            },
                        }
                        if ctx.label_detail then
                            table.insert(
                                highlights,
                                { #ctx.label, #ctx.label + #ctx.label_detail, group = "BlinkCmpLabelDetail" }
                            )
                        end

                        -- characters matched on the label by the fuzzy matcher
                        for _, idx in ipairs(ctx.label_matched_indices) do
                            table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
                        end

                        return highlights
                    end,
                },

                label_description = {
                    width = { max = 30 },
                    text = function(ctx)
                        return ctx.label_description
                    end,
                    highlight = "BlinkCmpLabelDescription",
                },

                source_name = {
                    width = { max = 30 },
                    text = function(ctx)
                        return ctx.source_name
                    end,
                    highlight = "BlinkCmpSource",
                },

                source_id = {
                    width = { max = 30 },
                    text = function(ctx)
                        return ctx.source_id
                    end,
                    highlight = "BlinkCmpSource",
                },
            },
        },
    }

    opts.completion.trigger = {
        -- When true, will prefetch the completion items when entering insert mode
        prefetch_on_insert = true,

        -- When false, will not show the completion window automatically when in a snippet
        show_in_snippet = true,

        -- When true, will show the completion window after typing any of alphanumerics, `-` or `_`
        show_on_keyword = true,

        -- When true, will show the completion window after typing a trigger character
        show_on_trigger_character = true,

        -- LSPs can indicate when to show the completion window via trigger characters
        -- however, some LSPs (i.e. tsserver) return characters that would essentially
        -- always show the window. We block these by default.
        show_on_blocked_trigger_characters = { " ", "\n", "\t" },
        -- You can also block per filetype with a function:
        -- show_on_blocked_trigger_characters = function(ctx)
        --   if vim.bo.filetype == 'markdown' then return { ' ', '\n', '\t', '.', '/', '(', '[' } end
        --   return { ' ', '\n', '\t' }
        -- end,

        -- When both this and show_on_trigger_character are true, will show the completion window
        -- when the cursor comes after a trigger character after accepting an item
        show_on_accept_on_trigger_character = true,

        -- When both this and show_on_trigger_character are true, will show the completion window
        -- when the cursor comes after a trigger character when entering insert mode
        show_on_insert_on_trigger_character = true,

        -- List of trigger characters (on top of `show_on_blocked_trigger_characters`) that won't trigger
        -- the completion window when the cursor comes after a trigger character when
        -- entering insert mode/accepting an item
        show_on_x_blocked_trigger_characters = { "'", '"', "(" },
        -- or a function, similar to show_on_blocked_trigger_character
    }

    opts.fuzzy = {
        implementation = "prefer_rust_with_warning",
        prebuilt_binaries = {
            force_version = "v1.1.1",
        },
    }

    opts.keymap = {
        preset = "default",
        ["<Down>"] = { "select_next", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Left>"] = { "select_and_accept", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },

        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<Tab>"] = { "select_and_accept", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<C-y>"] = { "select_and_accept", "fallback" },
        ["<C-l>"] = { "snippet_forward", "select_and_accept", "fallback" },
        ["<C-h>"] = { "snippet_backward", "fallback" },

        ["<C-space>"] = {
            -- function(cmp)
            --     cmp.show({
            --         -- providers = { "lsp", "snippets" },
            --         providers = { "lsp" },
            --     })
            -- end,
            "show",
            "hide",
            "select_and_accept",
        },

        ["<C-S-space>"] = { "show_documentation", "hide_documentation" },

        -- show with a list of providers
        ["<C-e>"] = {
            function(cmp)
                cmp.show({
                    providers = { "snippets" },
                })
            end,
            "cancel",
        },

        -- control whether the next command will be run when using a function
        -- ["<C-n>"] = {
        --     function(cmp)
        --         if some_condition then
        --             return
        --         end -- runs the next command
        --         return true -- doesn't run the next command
        --     end,
        --     "select_next",
        -- },
    }

    opts.signature = {
        enabled = true,
        window = {
            min_width = 1,
            max_width = 100,
            max_height = 10,
            border = "rounded", -- Defaults to `vim.o.winborder` on nvim 0.11+ or 'padded' when not defined/<=0.10
            winblend = 0,
            winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
            scrollbar = false, -- Note that the gutter will be disabled when border ~= 'none'
            -- Which directions to show the window,
            -- falling back to the next direction when there's not enough space,
            -- or another window is in the way
            direction_priority = { "n", "s" },
            -- Disable if you run into performance issues
            treesitter_highlighting = true,
            show_documentation = true,
        },
        trigger = {
            -- Show the signature help automatically
            enabled = true,
            -- Show the signature help window after typing any of alphanumerics, `-` or `_`
            show_on_keyword = false,
            blocked_trigger_characters = {},
            blocked_retrigger_characters = {},
            -- Show the signature help window after typing a trigger character
            show_on_trigger_character = true,
            -- Show the signature help window when entering insert mode
            show_on_insert = false,
            -- Show the signature help window when the cursor comes after a trigger character when entering insert mode
            show_on_insert_on_trigger_character = true,
        },
    }

    opts.sources = {
        default = {
            -- "lazydev",
            "lsp",
            "path",
            "snippets",
            "buffer",
            "git",
            "emoji",
            "ripgrep",
        },

        per_filetype = { sql = { "dadbod" } },
    }

    opts.sources.providers = {
        buffer = {
            module = "blink.cmp.sources.buffer",
            score_offset = -3,
            opts = {
                -- default to all visible buffers
                get_bufnrs = function()
                    return vim.iter(vim.api.nvim_list_wins())
                        :map(function(win)
                            return vim.api.nvim_win_get_buf(win)
                        end)
                        :filter(function(buf)
                            return vim.bo[buf].buftype ~= "nofile"
                        end)
                        :totable()
                end,
            },
        },

        cmdline = {
            module = "blink.cmp.sources.cmdline",
            -- Disable shell commands on windows, since they cause neovim to hang
            enabled = function()
                return vim.fn.has("win32") == 0
                    or vim.fn.getcmdtype() ~= ":"
                    or not vim.fn.getcmdline():match("^[%%0-9,'<>%-]*!")
            end,
        },

        dadbod = {
            module = "vim_dadbod_completion.blink",
        },

        emoji = {
            module = "blink-emoji",
            name = "Emoji",
            score_offset = 15, -- Tune by preference
            opts = { insert = true }, -- Insert emoji (default) or complete its name
            should_show_items = function()
                return vim.tbl_contains({ "gitcommit", "markdown" }, vim.o.filetype)
            end,
        },

        git = {
            module = "blink-cmp-git",
            name = "Git",
            enabled = function()
                return vim.tbl_contains({ "octo", "gitcommit", "markdown" }, vim.bo.filetype)
            end,
            opts = {
                -- TODO: configure git completion: https://github.com/Kaiser-Yang/blink-cmp-git
            },
        },

        lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100, -- make lazydev completions top priority (see `:h blink.cmp`)
            fallbacks = { "lsp" },
        },

        lsp = {
            name = "LSP",
            module = "blink.cmp.sources.lsp",
            -- You may enable the buffer source, when LSP is available, by setting this to `{}`
            -- You may want to set the score_offset of the buffer source to a lower value, such as -5 in this case
            fallbacks = { "buffer" },
            opts = {
                tailwind_color_icon = "██",
            },
            --- NOTE: All of these options may be functions to get dynamic behavior
            --- See the type definitions for more information

            enabled = true, -- Whether or not to enable the provider
            async = false, -- Whether we should show the completions before this provider returns, without waiting for it
            timeout_ms = 200, -- How long to wait for the provider to return before showing completions and treating it as asynchronous

            -- Filter text items from the LSP provider, since we have the buffer provider for that
            transform_items = function(_, items)
                return vim.tbl_filter(function(item)
                    return item.kind ~= require("blink.cmp.types").CompletionItemKind.Text
                end, items)
            end,

            should_show_items = true, -- Whether or not to show the items
            max_items = nil, -- Maximum number of items to display in the menu
            min_keyword_length = 0, -- Minimum number of characters in the keyword to trigger the provider
            -- If this provider returns 0 items, it will fallback to these providers.
            -- If multiple providers fallback to the same provider, all of the providers must return 0 items for it to fallback
            score_offset = 0, -- Boost/penalize the score of the items
            override = nil, -- Override the source's functions
        },

        omni = {
            module = "blink.cmp.sources.complete_func",
            enabled = function()
                return vim.bo.omnifunc ~= "v:lua.vim.lsp.omnifunc"
            end,
            ---@type blink.cmp.CompleteFuncOpts
            opts = {
                complete_func = function()
                    return vim.bo.omnifunc
                end,
            },
        },

        path = {
            module = "blink.cmp.sources.path",
            score_offset = 3,
            fallbacks = { "buffer" },
            opts = {
                trailing_slash = true,
                label_trailing_slash = true,
                get_cwd = function(context)
                    return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
                end,
                show_hidden_files_by_default = false,
            },
        },

        ripgrep = {
            module = "blink-ripgrep",
            name = "Ripgrep",
            -- the options below are optional, some default values are shown
            ---@module "blink-ripgrep"
            ---@type blink-ripgrep.Options
            opts = {
                prefix_min_len = 3,
                context_size = 5,
                max_filesize = "1M",
                ignore_paths = { "~/", "/" },
                project_root_marker = { ".git", "package.json", ".root", "pyproject.toml" },
            },
        },

        snippets = {
            module = "blink.cmp.sources.snippets",
            score_offset = -1,

            opts = {
                friendly_snippets = true,
                search_paths = { vim.fn.stdpath("config") .. "/snippets" },
                global_snippets = { "all" },
                extended_filetypes = {},
                ignored_filetypes = {},
                get_filetype = function(_)
                    return vim.bo.filetype
                end,
                clipboard_register = nil,
                use_show_condition = true,
                show_autosnippets = true,
                use_items_cache = true,
            },
        },
    }

    opts.term = {
        enabled = false,
    }

    blink_cmp.setup(opts)
end

local function setup_blink()
    MiniDeps.add({
        source = "saghen/blink.cmp",
        checkout = "v1.1.1",
        depends = {
            "echasnovski/mini.fuzzy",
            "echasnovski/mini.snippets",
            "mikavilpas/blink-ripgrep.nvim",
            "Kaiser-Yang/blink-cmp-git",
            "moyiz/blink-emoji.nvim",
        },
    })

    -- require("blink.cmp").setup()
    setup_blink_config()
end

MiniDeps.later(setup_blink)
