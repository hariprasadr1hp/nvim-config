-- lua/plugins/completion.lua

local M = {}

local setup_snippet = function(luasnip)
    return {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    }
end

local setup_mappings = function(cmp, luasnip)
    return cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<Tab>"] = cmp.mapping.confirm({ select = true }),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete({}),
        ["<C-l>"] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            end
        end, { "i", "s" }),
        ["<C-h>"] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            end
        end, { "i", "s" }),
    })
end

local function setup_sources()
    -- NOTE: Ordering is important. Completions are loaded accordingly
    return {
        { name = "lazydev", group_index = 0 },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
        { name = "buffer", keyword_length = 5 },
        -- { name = "orgmode" },
        -- { name = "neorg" },
    }
end

local function setup_formatting(lspkind)
    return {
        format = lspkind.cmp_format({
            -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            ellipsis_char = "...",
            maxwidth = {
                -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                -- can also be a function to dynamically calculate max width such as
                -- menu = 50, -- leading text (labelDetails)
                menu = function()
                    return math.floor(0.45 * vim.o.columns)
                end,
                abbr = 50, -- actual suggestion item
            },
            menu = {
                nvim_lsp = "[lsp]",
                buffer = "[buf]",
                luasnip = "[snip]",
                path = "[path]",
            },
            --- @type 'text' | 'text_symbol' | 'symbol_text' | 'symbol'
            mode = "symbol",
            show_labelDetails = true, -- show labelDetails in menu. Disabled by default
            symbol_map = {
                Text = "󰉿",
                Method = "󰆧",
                Function = "󰊕",
                Constructor = "",
                Field = "󰜢",
                Variable = "󰀫",
                Class = "󰠱",
                Interface = "",
                Module = "",
                Property = "󰜢",
                Unit = "󰑭",
                Value = "󰎠",
                Enum = "",
                Keyword = "󰌋",
                Snippet = "",
                Color = "󰏘",
                File = "󰈙",
                Reference = "󰈇",
                Folder = "󰉋",
                EnumMember = "",
                Constant = "󰏿",
                Struct = "󰙅",
                Event = "",
                Operator = "󰆕",
                TypeParameter = "",
                Codeium = "",
            },
        }),
    }
end

local function setup_completion()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")
    luasnip.config.setup({})

    cmp.setup({
        snippet = setup_snippet(luasnip),
        completion = { completeopt = "menu,menuone,preview,noinsert" },
        mapping = setup_mappings(cmp, luasnip),
        sources = setup_sources(),
        formatting = setup_formatting(lspkind),
    })

    cmp.setup.filetype({ "sql" }, {
        sources = {
            { name = "vim-dadbod-completion" },
            { name = "buffer" },
        },
    })
end

local function setup_dependencies()
    return {
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            build = (function()
                if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
                    return
                end
                return "make install_jsregexp"
            end)(),
            dependencies = {
                {
                    "rafamadriz/friendly-snippets",
                    config = function()
                        require("luasnip.loaders.from_vscode").lazy_load()
                        require("luasnip.loaders.from_vscode").lazy_load({
                            paths = { "./snippets" },
                        })
                    end,
                },
            },
        },
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "onsails/lspkind.nvim",
    }
end

M = {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = setup_dependencies(),
    config = function()
        setup_completion()
    end,
}

return M
