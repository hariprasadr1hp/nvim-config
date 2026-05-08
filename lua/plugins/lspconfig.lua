-- lua/plugins/lspconfig.lua

local mason_opts = {
    ui = {
        icons = {
            package_installed = " ",
            package_pending = " ",
            package_uninstalled = " ",
        },
    },
}

local function buf_keymap_set(mode, lhs, rhs, buf, desc, key_opts)
    local opts = vim.tbl_extend("force", {
        noremap = true,
        silent = true,
        buffer = buf,
        desc = desc or (type(rhs) == "string" and rhs or nil),
    }, key_opts or {})

    vim.keymap.set(mode, lhs, rhs, opts)
end

local function client_supports_method(client, method, bufnr)
    return client:supports_method(method, bufnr)
end

local lsp_rename_autosave_enabled = true

local function modified_buffers()
    local bufs = {}

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].modified then
            bufs[buf] = true
        end
    end

    return bufs
end

local function lsp_rename_with_autosave()
    local clients = vim.lsp.get_clients({
        bufnr = 0,
        method = vim.lsp.protocol.Methods.textDocument_rename,
    })

    if vim.tbl_isempty(clients) then
        vim.notify("No LSP client supports rename in this buffer", vim.log.levels.WARN)
        return
    end

    local before = modified_buffers()

    vim.lsp.buf.rename(nil, {
        on_rename = function()
            if not lsp_rename_autosave_enabled then
                return
            end

            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].modified and not before[buf] then
                    vim.api.nvim_buf_call(buf, function()
                        vim.cmd("silent noautocmd write")
                    end)
                end
            end
        end,
    })
end

local function workspace_edit_uris(edit)
    local uris = {}

    if edit.changes then
        for uri in pairs(edit.changes) do
            uris[uri] = true
        end
    end

    if edit.documentChanges then
        for _, change in ipairs(edit.documentChanges) do
            if change.textDocument and change.textDocument.uri then
                uris[change.textDocument.uri] = true
            end
        end
    end

    return uris
end

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

local function setup_lsp_rename_autosave_handler()
    local method = vim.lsp.protocol.Methods.textDocument_rename
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

local function setup_lsp_autocmds(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then
        return
    end

    local current_buffer = event.buf

    -- Disable hover in Ruff in favor of Pyright
    if client.name == "ruff" then
        client.server_capabilities.hoverProvider = false
    end

    buf_keymap_set("n", "<leader>il", ":LspInfo<cr>", current_buffer, "lsp-info")
    buf_keymap_set("n", "<leader>lr", lsp_rename_with_autosave, current_buffer, "lsp-rename")

    -- Document Highlight
    if client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, current_buffer) then
        local highlight_group = vim.api.nvim_create_augroup("hp-lsp-highlight", { clear = false })

        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = current_buffer,
            group = highlight_group,
            callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = current_buffer,
            group = highlight_group,
            callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("hp-lsp-detach", { clear = true }),
            callback = function(ev)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = highlight_group, buffer = ev.buf })
            end,
        })
    end

    -- Inlay Hints
    if client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, current_buffer) then
        buf_keymap_set("n", "<leader>lH", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = current_buffer }))
        end, current_buffer, "inlay hints")
    end
end

local function setup_lsp_config()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")
    local blink_cmp = require("blink.cmp")
    local schemastore = require("schemastore")

    setup_lsp_rename_autosave_handler()

    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
            local client = vim.lsp.get_client_by_id(ev.data.client_id)
            if client and client.name == "pyright" then
                client.handlers = client.handlers or {}
                client.handlers["$/progress"] = function() end
            end
        end,
    })

    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("hp-lsp-attach", { clear = true }),
        callback = setup_lsp_autocmds,
    })

    local capabilities = blink_cmp.get_lsp_capabilities()
    local lsp_flags = {
        allow_incremental_sync = true,
        debounce_text_changes = 150,
    }

    local servers = {
        arduino_language_server = {},
        clangd = {},
        cypher_ls = {},
        gitlab_ci_ls = {},
        gdtoolkit = {},
        jinja_lsp = {},
        julials = {},
        sqls = {},
        texlab = {},
        ts_ls = {},
        tflint = {},
        vimls = {},

        ansiblels = {
            cmd = { "ansible-language-server", "--stdio" },
        },

        awk_ls = {
            cmd = { "awk-language-server" },
            filetypes = { "awk" },
            handlers = {
                ["workspace/workspaceFolders"] = function()
                    return {
                        {
                            uri = "file://" .. vim.fn.getcwd(),
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
                        extra = {
                            {
                                name = "http-client.env.json",
                                fileMatch = { "http-client.env.json" },
                                description = "The environment variables required for the HTTP client",
                                url = "https://raw.githubusercontent.com/mistweaverco/kulala.nvim/main/schemas/http-client.env.schema.json",
                            },
                            {
                                name = "http-client.private.env.json",
                                fileMatch = { "http-client.private.env.json" },
                                description = "he private environment variables required for the HTTP client",
                                url = "https://raw.githubusercontent.com/mistweaverco/kulala.nvim/refs/heads/main/schemas/http-client.private.env.schema.json",
                            },
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
                        globals = { "vim", "hs", "require", "io", "table", "string", "pandoc" },
                        neededFileStatus = {
                            ["codestyle-check"] = "Any",
                        },
                    },
                    type = {
                        castNumberToInteger = true,
                        weakUnionCheck = false,
                        weakNilCheck = false,
                    },
                    workspace = {
                        library = {
                            vim.fn.expand("$VIMRUNTIME/lua"),
                            vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
                            vim.fn.expand("~/.hammerspoon/Spoons/EmmyLua.spoon/annotations"),
                            vim.fn.expand("/Applications/Hammerspoon.app/Contents/Resources/extensions/hs/"),
                        },
                    },
                    telemetry = {
                        enable = false,
                    },
                },
            },
        },

        nil_ls = {
            filetypes = { "nix" },
            settings = {
                ["nil"] = {
                    formatting = {
                        command = { "nixfmt" },
                    },
                },
            },
        },

        pyright = {
            cmd = { "pyright-langserver", "--stdio" },
            filetypes = { "python", "ipynb" },
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
            init_options = {
                settings = {
                    configurationPreference = "filesystemFirst",
                    configuration = {
                        format = {
                            ["quote-style"] = "single",
                        },
                    },
                    logFile = "~/.local/state/ruff.log",
                    logLevel = "debug",
                },
            },
        },

        rust_analyzer = {
            on_attach = function(_, bufnr)
                vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            end,
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

        svelte = {
            on_attach = function(client)
                vim.api.nvim_create_autocmd("BufWritePost", {
                    pattern = { "*.js", "*.ts" },
                    callback = function(ctx)
                        client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
                    end,
                })
            end,
        },

        ["turtle-language-server"] = {
            cmd = { "turtle-language-server", "--stdio" },
            filetypes = { "turtle", "ttl" },
        },

        taplo = {
            cmd = { "taplo", "lsp", "stdio" },
            filetypes = { "toml" },
            root_markers = { ".taplo.toml", "taplo.toml", ".git" },
        },

        ts_query_ls = {
            cmd = { "ts_query_ls" },
            filetypes = { "query" },
            root_dir = vim.fs.root(0, { ".tsqueryrc.json", "queries" }),
            settings = {
                parser_install_directories = {
                    vim.fn.stdpath("data") .. "/site/parser/",
                },
            },
        },

        terraformls = {
            filetypes = { "terraform", "tf", "terraform-vars" },
            root_markers = { ".terraform" },
        },

        yamlls = {
            filetypes = { "yaml", "yml" },
            settings = {
                redhat = { telemetry = { enabled = false } },
                yaml = {
                    schemaStore = {
                        enable = false,
                        url = "",
                    },
                    { format = { enable = true } },
                    schemas = vim.tbl_extend("force", schemastore.yaml.schemas(), {}),
                },
            },
        },
    }

    local tools = {
        "ansible-lint",
        "biome",
        "black",
        "codelldb",
        "eslint_d",
        "firefox-debug-adapter",
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

    local ensure_installed = vim.tbl_keys(servers)
    vim.list_extend(ensure_installed, tools)

    mason_tool_installer.setup({ ensure_installed = ensure_installed })

    mason_lspconfig.setup({
        ensure_installed = {},
        automatic_installation = false,
        handlers = {
            function(server_name)
                local server = servers[server_name] or {}
                server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                server.flags = lsp_flags
                lspconfig[server_name].setup(server)
            end,
        },
    })

    vim.lsp.enable("tsqueryls")
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
                "williamboman/mason.nvim",
                keys = {
                    { "<leader>oT", "<cmd>Mason<cr>", desc = "tools-mason" },
                },
                opts = mason_opts,
            },
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            "saghen/blink.cmp",
            { "b0o/schemastore.nvim", lazy = true, version = false },
            { "j-hui/fidget.nvim" },
        },
        config = setup_lsp_config,
    },
}
