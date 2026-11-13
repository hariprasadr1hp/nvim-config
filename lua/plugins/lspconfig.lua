-- lua/plugins/lspconfig.lua
--
-- Neovim >= 0.11 native LSP setup:
--   * server configs are registered via `vim.lsp.config()` and merged on top of
--     the defaults shipped by nvim-lspconfig (`lsp/<name>.lua`)
--   * mason-lspconfig (v2) only installs/enables servers via `vim.lsp.enable()`
--   * blink.cmp injects its completion capabilities through `vim.lsp.config("*")`
local mason_opts = {

    ui = {
        icons = {
            package_installed = " ",
            package_pending = " ",
            package_uninstalled = " ",
        },
    },
}

local function buf_keymap_set(mode, lhs, rhs, buf, desc)
    vim.keymap.set(mode, lhs, rhs, { silent = true, buffer = buf, desc = desc })
end

-------------------------------------------------------------------------------
-- Rename: auto-save buffers touched by `textDocument/rename`
-------------------------------------------------------------------------------

local lsp_rename_autosave_enabled = true

---@param edit lsp.WorkspaceEdit
local function workspace_edit_uris(edit)
    local uris = {}

    for uri in pairs(edit.changes or {}) do
        uris[uri] = true
    end

    for _, change in ipairs(edit.documentChanges or {}) do
        if change.textDocument and change.textDocument.uri then
            uris[change.textDocument.uri] = true
        end
    end

    return uris
end

---@param edit lsp.WorkspaceEdit
local function save_rename_touched_buffers(edit)
    for uri in pairs(workspace_edit_uris(edit)) do
        local bufnr = vim.uri_to_bufnr(uri)

        if vim.api.nvim_buf_is_loaded(bufnr) and vim.bo[bufnr].modified then
            vim.api.nvim_buf_call(bufnr, function()
                vim.cmd("silent noautocmd write")
            end)
        end
    end
end

-- `vim.lsp.buf.rename()` dispatches its response to `vim.lsp.handlers["textDocument/rename"]`
local function setup_lsp_rename_autosave_handler()
    local method = "textDocument/rename"
    local original_handler = vim.lsp.handlers[method]

    vim.lsp.handlers[method] = function(err, result, ctx, config)
        if original_handler then
            original_handler(err, result, ctx, config)
        end

        if err or not result or not lsp_rename_autosave_enabled then
            return
        end

        vim.schedule(function()
            save_rename_touched_buffers(result)
        end)
    end
end

-------------------------------------------------------------------------------
-- LspAttach / LspDetach
-------------------------------------------------------------------------------

local highlight_group = vim.api.nvim_create_augroup("hp-lsp-highlight", { clear = true })

---@param event vim.api.keyset.create_autocmd.callback_args
local function on_lsp_attach(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then
        return
    end

    local bufnr = event.buf

    buf_keymap_set("n", "<leader>il", "<cmd>checkhealth vim.lsp<cr>", bufnr, "lsp-info")
    buf_keymap_set("n", "<leader>lr", vim.lsp.buf.rename, bufnr, "lsp-rename")

    -- Document Highlight
    if client:supports_method("textDocument/documentHighlight", bufnr) then
        -- avoid stacking duplicate autocmds when several clients attach to the same buffer
        vim.api.nvim_clear_autocmds({ group = highlight_group, buffer = bufnr })

        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = bufnr,
            group = highlight_group,
            callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = bufnr,
            group = highlight_group,
            callback = vim.lsp.buf.clear_references,
        })
    end

    -- Inlay Hints
    if client:supports_method("textDocument/inlayHint", bufnr) then
        if client.name == "rust_analyzer" then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end

        buf_keymap_set("n", "<leader>lH", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
        end, bufnr, "inlay hints")
    end
end

---@param event vim.api.keyset.create_autocmd.callback_args
local function on_lsp_detach(event)
    local bufnr = event.buf

    -- keep highlight autocmds if another attached client still provides it
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
        if client.id ~= event.data.client_id and client:supports_method("textDocument/documentHighlight", bufnr) then
            return
        end
    end

    vim.lsp.util.buf_clear_references(bufnr)
    vim.api.nvim_clear_autocmds({ group = highlight_group, buffer = bufnr })
end

-------------------------------------------------------------------------------
-- Servers
-------------------------------------------------------------------------------

-- Each entry is merged (`vim.lsp.config`) on top of nvim-lspconfig's defaults.
-- NOTE: list values (e.g. `filetypes`) replace the default list; avoid overriding
-- `on_attach` / `on_init` where nvim-lspconfig already defines them.
local function get_servers()
    local schemastore = require("schemastore")

    return {
        arduino_language_server = {},
        clangd = {},
        cypher_ls = {},
        gitlab_ci_ls = {},
        jinja_lsp = {},
        julials = {},
        sqls = {},
        svelte = {},
        texlab = {},
        tflint = {},
        turtle_ls = {},
        vimls = {},
        vue_ls = {},

        ansiblels = {
            cmd = { "ansible-language-server", "--stdio" },
        },

        awk_ls = {
            handlers = {
                ["workspace/workspaceFolders"] = function()
                    return {
                        {
                            uri = vim.uri_from_fname(vim.fn.getcwd()),
                            name = "current_dir",
                        },
                    }
                end,
            },
        },

        bashls = {
            filetypes = { "bash", "sh" },
        },

        emmet_ls = {
            filetypes = {
                "html",
                "typescriptreact",
                "javascriptreact",
                "css",
                "sass",
                "scss",
                "less",
                "svelte",
            },
        },

        graphql = {
            filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
        },

        jsonls = {
            init_options = {
                provideFormatter = true,
            },
            filetypes = { "json", "jsonc", "jsonld", "json5" },
            settings = {
                json = {
                    format = { enable = true },
                    validate = { enable = true },
                    schemas = schemastore.json.schemas({
                        ignore = {
                            ".eslintrc",
                            "package.json",
                        },
                    }),
                },
            },
        },

        lua_ls = {
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                    },
                    completion = {
                        callSnippet = "Replace",
                    },
                    diagnostics = {
                        disable = {
                            "trailing-space",
                        },
                        globals = { "vim", "hs", "pandoc" },
                        neededFileStatus = {
                            ["codestyle-check"] = "Any",
                        },
                    },
                    type = {
                        castNumberToInteger = true,
                        weakUnionCheck = false,
                        weakNilCheck = false,
                    },
                    -- `$VIMRUNTIME` & plugin libraries are injected by lazydev.nvim
                    workspace = {
                        library = {
                            vim.fn.expand("~/.hammerspoon/Spoons/EmmyLua.spoon/annotations"),
                            "/Applications/Hammerspoon.app/Contents/Resources/extensions/hs/",
                        },
                    },
                    telemetry = {
                        enable = false,
                    },
                },
            },
        },

        nil_ls = {
            settings = {
                ["nil"] = {
                    formatting = {
                        command = { "nixfmt" },
                    },
                },
            },
        },

        pyright = {
            filetypes = { "python", "ipynb" },
            handlers = {
                -- silence pyright's progress spam
                ["$/progress"] = function() end,
            },
            settings = {
                pyright = {
                    disableOrganizeImports = true,
                },
                python = {
                    analysis = {
                        ignore = { "*" },
                        useLibraryCodeForTypes = true,
                        diagnosticMode = "openFilesOnly",
                    },
                },
            },
        },

        ruff = {
            filetypes = { "python", "ipynb" },
            -- Disable hover in Ruff in favor of Pyright
            on_init = function(client)
                client.server_capabilities.hoverProvider = false
            end,
            init_options = {
                settings = {
                    configurationPreference = "filesystemFirst",
                    configuration = {
                        format = {
                            ["quote-style"] = "double",
                        },
                    },
                    logFile = "~/.local/state/ruff.log",
                    logLevel = "debug",
                },
            },
        },

        rust_analyzer = {
            settings = {
                ["rust-analyzer"] = {
                    imports = {
                        granularity = {
                            group = "module",
                        },
                        prefix = "self",
                    },
                    cargo = {
                        buildScripts = {
                            enable = true,
                        },
                    },
                    procMacro = {
                        enable = true,
                    },
                },
            },
        },

        taplo = {
            root_markers = { ".taplo.toml", "taplo.toml", ".git" },
        },

        -- TypeScript + Vue (hybrid mode): `vue_ls` handles template/style and
        -- forwards TS requests to `ts_ls`, which loads `@vue/typescript-plugin`
        ts_ls = {
            init_options = {
                plugins = {
                    {
                        name = "@vue/typescript-plugin",
                        location = vim.fn.stdpath("data")
                            .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
                        languages = { "vue" },
                        configNamespace = "typescript",
                    },
                },
            },
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
        },

        ts_query_ls = {
            root_markers = { ".tsqueryrc.json", "queries", ".git" },
        },

        terraformls = {
            filetypes = { "terraform", "terraform-vars" },
            root_markers = { ".terraform" },
        },

        yamlls = {
            settings = {
                redhat = { telemetry = { enabled = false } },
                yaml = {
                    schemaStore = {
                        enable = false,
                        url = "",
                    },
                    format = { enable = true },
                    schemas = schemastore.yaml.schemas(),
                },
            },
        },
    }
end

-- non-LSP mason packages (formatters, linters, debug adapters)
local tools = {
    "ansible-lint",
    "biome",
    "black",
    "codelldb",
    "eslint_d",
    "firefox-debug-adapter",
    "gdtoolkit",
    "isort",
    "mypy",
    "prettier",
    "pylint",
    "ruff",
    "shellcheck",
    "shfmt",
    "sleek",
    "sqlfluff",
    "stylua",
    "taplo",
    "tex-fmt",
    "yamlfix",
}

-- mason packages that also ship an LSP mode, but are only used as tools
local lsp_auto_enable_exclude = { "biome", "stylua" }

-- servers unknown to mason-lspconfig's mappings: lspconfig name -> mason package
-- (these also need an explicit `vim.lsp.enable()`, since mason-lspconfig won't)
local unmapped_servers = {
    turtle_ls = "turtle-language-server",
}

-- drop neovim's built-in `gr*` LSP keymaps (`grn`, `gra`, `grr`, `gri`, `grt`, `grx`, ...)
-- so that the custom `gr` (references) mapping fires without waiting on `timeoutlen`
local function drop_default_gr_keymaps()
    for _, mode in ipairs({ "n", "x" }) do
        for _, map in ipairs(vim.api.nvim_get_keymap(mode)) do
            if map.lhs:match("^gr.") then
                pcall(vim.keymap.del, mode, map.lhs)
            end
        end
    end
end

local function setup_lsp_config()
    drop_default_gr_keymaps()
    setup_lsp_rename_autosave_handler()

    local group = vim.api.nvim_create_augroup("hp-lsp-attach", { clear = true })

    vim.api.nvim_create_autocmd("LspAttach", {
        group = group,
        callback = on_lsp_attach,
    })

    vim.api.nvim_create_autocmd("LspDetach", {
        group = group,
        callback = on_lsp_detach,
    })

    local servers = get_servers()

    for name, config in pairs(servers) do
        vim.lsp.config(name, config)
    end

    local ensure_installed = vim.tbl_map(function(name)
        return unmapped_servers[name] or name
    end, vim.tbl_keys(servers))
    vim.list_extend(ensure_installed, tools)

    require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

    -- calls `vim.lsp.enable()` for every installed server
    require("mason-lspconfig").setup({
        automatic_enable = {
            exclude = lsp_auto_enable_exclude,
        },
    })

    vim.lsp.enable(vim.tbl_keys(unmapped_servers))
end

return {
    {
        "folke/lazydev.nvim",
        ft = "lua",
        dependencies = {
            {
                "DrKJeff16/wezterm-types",
                version = false,
            },
        },
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                { path = "wezterm-types", mods = { "wezterm" } },
            },
        },
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "mason-org/mason.nvim",
                keys = {
                    { "<leader>oT", "<cmd>Mason<cr>", desc = "tools-mason" },
                },
                opts = mason_opts,
            },
            "mason-org/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            "saghen/blink.cmp",
            { "b0o/schemastore.nvim", lazy = true, version = false },
            { "j-hui/fidget.nvim" },
        },
        config = setup_lsp_config,
    },
}
