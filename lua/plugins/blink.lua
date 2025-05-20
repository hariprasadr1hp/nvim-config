-- lua/plugins/blink.lua

local function setup_blink_config()
    local blink_cmp = require("blink.cmp")

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    local opts = {}

    opts.appearance = {
        highlight_ns = vim.api.nvim_create_namespace("blink_cmp"),
        use_nvim_cmp_as_default = false,
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
        keymap = {
            preset = "cmdline",
            ["<Down>"] = { "select_next", "fallback" },
            ["<Up>"] = { "select_prev", "fallback" },
        },

        ---@diagnostic disable-next-line: assign-type-mismatch
        sources = function()
            local cmd_type = vim.fn.getcmdtype()
            if cmd_type == "/" or cmd_type == "?" then
                return { "buffer" }
            end
            if cmd_type == ":" or cmd_type == "@" then
                return { "cmdline" }
            end
            return {}
        end,

        completion = {
            trigger = {
                show_on_blocked_trigger_characters = {},
                show_on_x_blocked_trigger_characters = {},
            },
            list = {
                selection = {
                    preselect = true,
                    auto_insert = true,
                },
            },
            menu = { auto_show = false },
            ghost_text = { enabled = true },
        },
    }

    opts.completion = {}

    opts.completion.accept = {
        dot_repeat = true,
        create_undo_point = true,
        resolve_timeout_ms = 100,
        auto_brackets = {
            enabled = true,
            default_brackets = { "(", ")" },
            override_brackets_for_filetypes = {},
            kind_resolution = {
                enabled = true,
                blocked_filetypes = { "typescriptreact", "javascriptreact", "vue" },
            },
            semantic_token_resolution = {
                enabled = true,
                blocked_filetypes = { "java" },
                timeout_ms = 400,
            },
        },
    }

    opts.completion.documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        update_delay_ms = 50,
        treesitter_highlighting = true,
        draw = function(options)
            options.default_implementation()
        end,
        window = {
            min_width = 10,
            max_width = 80,
            max_height = 20,
            border = "rounded",
            winblend = 0,
            winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
            scrollbar = true,
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
        max_items = 200,
        selection = {
            preselect = true,
            auto_insert = true,
        },
        cycle = {
            from_bottom = true,
            from_top = true,
        },
    }

    opts.completion.menu = {
        enabled = true,
        min_width = 25,
        max_height = 10,
        border = "rounded",
        winblend = 0,
        winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
        scrolloff = 2,
        scrollbar = true,
        direction_priority = { "s", "n" },
        auto_show = true,
        cmdline_position = function()
            if vim.g.ui_cmdline_pos ~= nil then
                local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
                return { pos[1] - 1, pos[2] }
            end
            local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
            return { vim.o.lines - height, 0 }
        end,

        draw = {
            align_to = "label",
            padding = 1,
            gap = 1,
            treesitter = { "lsp" },
            columns = {
                { "kind_icon", "label", gap = 1 },
                { "label_description", gap = 1 },
                { "source_id" },
                { "kind" },
            },

            components = {
                kind_icon = {
                    ellipsis = false,
                    text = function(ctx)
                        return ctx.kind_icon .. ctx.icon_gap
                    end,
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
        prefetch_on_insert = true,
        show_in_snippet = true,
        show_on_keyword = true,
        show_on_trigger_character = true,
        show_on_blocked_trigger_characters = { " ", "\n", "\t" },
        show_on_accept_on_trigger_character = true,
        show_on_insert_on_trigger_character = true,
        show_on_x_blocked_trigger_characters = { "'", '"', "(" },
    }

    opts.fuzzy = {
        implementation = "rust",
        prebuilt_binaries = {
            force_version = "v1.1.1",
        },
        sorts = {
            "exact",
            "score",
            "sort_text",
        },
        use_frecency = true,
    }

    opts.keymap = {
        preset = "default",
        ["<Down>"] = { "select_next", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },
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

        ["<C-S-space>"] = { "show_documentation", "hide_documentation" },

        ["<C-e>"] = {
            function(cmp)
                cmp.show({
                    providers = { "snippets" },
                })
            end,
            "cancel",
        },

        ["<A-1>"] = {
            function(cmp)
                cmp.accept({ index = 1 })
            end,
        },
        ["<A-2>"] = {
            function(cmp)
                cmp.accept({ index = 2 })
            end,
        },
        ["<A-3>"] = {
            function(cmp)
                cmp.accept({ index = 3 })
            end,
        },
        ["<A-4>"] = {
            function(cmp)
                cmp.accept({ index = 4 })
            end,
        },
        ["<A-5>"] = {
            function(cmp)
                cmp.accept({ index = 5 })
            end,
        },
    }

    opts.signature = {
        enabled = true,
        window = {
            min_width = 1,
            max_width = 100,
            max_height = 10,
            border = "rounded",
            winblend = 0,
            winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
            scrollbar = false,
            direction_priority = { "n", "s" },
            treesitter_highlighting = true,
            show_documentation = true,
        },
        trigger = {
            enabled = true,
            show_on_keyword = false,
            blocked_trigger_characters = {},
            blocked_retrigger_characters = {},
            show_on_trigger_character = true,
            show_on_insert = false,
            show_on_insert_on_trigger_character = true,
        },
    }

    opts.sources = {}
    opts.sources.default = { "avante", "lsp", "path", "snippets", "buffer", "emoji" }

    opts.sources.per_filetype = {
        sql = { "snippets", "dadbod", "buffer" },
        codecompanion = { "codecompanion" },
    }

    opts.sources.providers = {}

    opts.sources.providers.lsp = {
        name = "LSP",
        module = "blink.cmp.sources.lsp",
        transform_items = function(_, items)
            return vim.tbl_filter(function(item)
                return item.kind ~= require("blink.cmp.types").CompletionItemKind.Text
            end, items)
        end,
        opts = { tailwind_color_icon = "██" },
        enabled = true,
        async = false,
        timeout_ms = 2000,
        should_show_items = true,
        max_items = nil,
        min_keyword_length = 0,
        fallbacks = {},
        score_offset = 0,
        override = nil,
    }

    opts.sources.providers.path = {
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
    }

    opts.sources.providers.snippets = {
        module = "blink.cmp.sources.snippets",
        score_offset = -1,
        should_show_items = function(ctx)
            return ctx.trigger.initial_kind ~= "trigger_character"
        end,
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
    }

    opts.sources.providers.emoji = {
        module = "blink-emoji",
        name = "Emoji",
        score_offset = 15,
        opts = { insert = true },
        should_show_items = function()
            return vim.tbl_contains({ "gitcommit", "markdown" }, vim.o.filetype)
        end,
    }

    opts.sources.providers.omni = {
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
    }

    opts.sources.providers.dadbod = {
        name = "Dadbod",
        module = "vim_dadbod_completion.blink",
    }

    opts.sources.providers.avante = {
        module = "blink-cmp-avante",
        name = "Avante",
        opts = {},
    }

    opts.term = {
        enabled = false,
    }

    blink_cmp.setup(opts)
end

return {
    {
        "saghen/blink.compat",
        version = "*",
        event = { "InsertEnter" },
        opts = {},
    },
    {
        "saghen/blink.cmp",
        -- event = "VimEnter",
        lazy = true,
        dependencies = {
            { "Kaiser-Yang/blink-cmp-avante" },
            { "rafamadriz/friendly-snippets" },
            { "echasnovski/mini.snippets" },
            {
                "kristijanhusak/vim-dadbod-completion",
                ft = { "sql", "mysql", "plsql", "bqsql" },
                lazy = true,
            },
            { "moyiz/blink-emoji.nvim" },
        },
        version = "1.*",
        config = setup_blink_config,
    },
}
