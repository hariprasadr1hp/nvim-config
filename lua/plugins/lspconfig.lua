-- lua/plugins/lspconfig.lua

local mason_opts = {
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
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
    if vim.fn.has("nvim-0.11") == 1 then
        return client:supports_method(method, bufnr)
    else
        return client.supports_method(method, { bufnr = bufnr })
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

    local keymap_set = require("config.helpers").keymap_set
    -- keymap_set("n", "<leader>oM", ":Mason<CR>", "Mason")

    buf_keymap_set("n", "<leader>il", ":LspInfo<CR>", current_buffer, "lsp-info")
    buf_keymap_set("n", "<leader>lI", ":LspInfo<CR>", current_buffer, "lsp-info")
    buf_keymap_set("n", "<leader>lR", ":LspRestart<CR>", current_buffer, "lsp-restart")

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

    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("hp-lsp-attach", { clear = true }),
        callback = setup_lsp_autocmds,
    })

    local capabilities = blink_cmp.get_lsp_capabilities()

    local servers = {
        ansiblels = {},
        arduino_language_server = {},
        clangd = {},
        cypher_ls = {},
        gitlab_ci_ls = {},
        jinja_lsp = {},
        julials = {},
        sqls = {},
        ts_ls = {},
        terraformls = {
            filetypes = { "terraform", "tf" },
        },
        tflint = {},
        vimls = {},

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

        lua_ls = {
            settings = {
                Lua = {
                    completion = { callSnippet = "Replace" },
                    diagnostics = { disable = { "missing-fields" } },
                },
            },
        },

        pyright = {
            cmd = { "pyright-langserver", "--stdio" },
            filetypes = { "python", "ipynb" },
            settings = {
                pyright = { disableOrganizeImports = true },
                python = { analysis = { ignore = { "*" } } },
            },
        },

        ruff = {
            filetypes = { "python", "ipynb" },
            init_options = {
                settings = {
                    trace = "messages",
                    init_options = {
                        settings = { logLevel = "debug" },
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

        -- turtle_languageserver = {
        --     cmd = "turtle_languageserver",
        --     filetypes = { "turtle", "ttl" },
        -- },

        yamlls = {
            filetypes = { "yaml", "yml" },
            settings = {
                yaml = {
                    schemas = {
                        kubernetes = "k8s-*.yaml",
                        ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/**/*.{yml,yaml}",
                        ["https://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
                        ["https://json.schemastore.org/circleciconfig"] = ".circleci/**/*.{yml,yaml}",
                        ["https://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
                        ["https://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
                        ["https://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
                        ["https://json.schemastore.org/github-workflow"] = ".github/workflows/*",
                        ["https://json.schemastore.org/mkdocs-1.6"] = "mkdocs.{yml,yaml}",
                        ["https://raw.githubusercontent.com/dbt-labs/dbt-jsonschema/main/schemas/latest/dbt_yml_files-latest.json"] = {
                            "/**/*.yml",
                            "!profiles.yml",
                            "!dbt_project.yml",
                            "!packages.yml",
                            "!selectors.yml",
                            "!profile_template.yml",
                            "!package-lock.yml",
                        },
                        ["https://raw.githubusercontent.com/dbt-labs/dbt-jsonschema/main/schemas/latest/dbt_project-latest.json"] = "dbt_project.yml",
                        ["https://raw.githubusercontent.com/dbt-labs/dbt-jsonschema/main/schemas/latest/selectors-latest.json"] = "selectors.yml",
                        ["https://raw.githubusercontent.com/dbt-labs/dbt-jsonschema/main/schemas/latest/packages-latest.json"] = "packages.yml",
                    },
                },
            },
        },
    }

    local tools = {
        "black",
        "isort",
        "mypy",
        "ruff",
        "pylint",
        "shfmt",
        "shellcheck",
        "biome",
        "eslint_d",
        "prettier",
        "stylua",
        "taplo",
        "sqlfluff",
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
                lspconfig[server_name].setup(server)
            end,
        },
    })
end

return {
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "williamboman/mason.nvim",
                keys = {
                    { "<leader>oT", "<cmd>Mason<CR>", desc = "tools-mason" },
                },
                opts = mason_opts,
            },
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            { "j-hui/fidget.nvim", opts = {} },
            "saghen/blink.cmp",
        },
        config = setup_lsp_config,
    },
}
