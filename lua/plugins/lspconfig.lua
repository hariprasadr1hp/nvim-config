-- lua/plugins/lsp/lspconfig.lua

local setup_lsp_handlers = function()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local blink_cmp = require("blink.cmp")

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, blink_cmp.get_lsp_capabilities({}, false))
    -- capabilities = vim.tbl_deep_extend("force", capabilities, MiniCompletion.get_lsp_capabilities())

    -- vim.lsp.config("*", {capabilities = MiniCompletion.get_lsp_capabilities()})

    --  Add any additional override configuration in the following tables. Available keys are:
    --  - cmd (table): Override the default command used to start the server
    --  - filetypes (table): Override the default list of associated filetypes for the server
    --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
    --  - settings (table): Override the default settings passed when initializing the server.
    --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/

    mason_lspconfig.setup_handlers({
        -- default handler for installed servers
        function(server_name)
            lspconfig[server_name].setup({
                capabilities = capabilities,
            })
        end,

        ["emmet_ls"] = function()
            lspconfig["emmet_ls"].setup({
                capabilities = capabilities,
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
            })
        end,

        ["graphql"] = function()
            lspconfig["graphql"].setup({
                capabilities = capabilities,
                filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
            })
        end,

        ["lua_ls"] = function()
            lspconfig["lua_ls"].setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            version = "LuaJIT",
                        },
                        diagnostics = {
                            globals = { "vim" },
                            disable = {},
                        },
                        workspace = {
                            checkThirdParty = false,
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                        completion = {
                            callSnippet = "Replace",
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            })
        end,

        ["pyright"] = function()
            lspconfig["pyright"].setup({
                {
                    capabilities = capabilities,
                    cmd = { "pyright-langserver", "--stdio" },
                    filetypes = { "python", "ipynb" },
                    settings = {
                        pyright = {
                            disableOrganizeImports = true, -- using Ruff
                        },
                        python = {
                            analysis = {
                                -- autoImportCompletions = true,
                                -- autoSearchPaths = true,
                                -- diagnosticMode = "workspace",
                                -- useLibraryCodeForTypes = true,
                                -- typeCheckingMode = "basic",
                                -- logLevel = "Information",
                                ignore = { "*" },
                            },
                        },
                    },
                },
            })
        end,

        ["ruff"] = function()
            lspconfig["ruff"].setup({
                capabilities = capabilities,
                filetypes = { "python", "ipynb" },
                init_options = {
                    settings = {
                        trace = "messages",
                        init_options = {
                            settings = {
                                logLevel = "debug",
                            },
                        },
                    },
                },
            })
        end,

        ["svelte"] = function()
            lspconfig["svelte"].setup({
                capabilities = capabilities,
                ---@diagnostic disable-next-line: unused-local
                on_attach = function(client, _bufnr)
                    vim.api.nvim_create_autocmd("BufWritePost", {
                        pattern = { "*.js", "*.ts" },
                        callback = function(ctx)
                            -- Here use ctx.match instead of ctx.file
                            client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
                        end,
                    })
                end,
            })
        end,
    })
end

local setup_lsp_mappings = function(event)
    local map = function(keys, func, desc, mode)
        mode = mode or "n"
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
    end

    map("gd", require("telescope.builtin").lsp_definitions, "definition")
    map("gr", require("telescope.builtin").lsp_references, "references")
    map("gR", require("telescope.builtin").lsp_references, "references")
    map("gI", require("telescope.builtin").lsp_implementations, "implementation")
    map("gD", vim.lsp.buf.declaration, "declaration")
    map("gA", vim.lsp.buf.code_action, "code-action")
    map("g.", vim.lsp.buf.code_action, "code-action")
    map("K", vim.lsp.buf.hover, "show-definition")
    map("]d", function()
        vim.diagnostic.jump({ count = 1, float = true })
    end, "next-diagnostic")
    map("[d", function()
        vim.diagnostic.jump({ count = -1, float = true })
    end, "prev-diagnostic")
end

local function on_lsp_attach(event)
    local opts = { buffer = event.buf, silent = true }
    setup_lsp_mappings(event)

    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client == nil then
        return
    end

    if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
        local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
            callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
            end,
        })
    end

    local inlay_hint = vim.lsp.protocol.Methods.textDocument_inlayHint or ""

    if inlay_hint == "" then
        return
    end

    if client:supports_method(inlay_hint) then
        vim.keymap.set("n", "<leader>lH", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
        end, { buffer = event.buf, desc = "[T]oggle Inlay [H]ints" })
    end

    if client.name == "ruff" then
        -- Disable hover in favor of Pyright
        client.server_capabilities.hoverProvider = false
    end
end

local function setup_lsp_autocommands()
    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(event)
            on_lsp_attach(event)
        end,
    })
end

local setup_lsp_config = function()
    MiniDeps.add({
        source = "neovim/nvim-lspconfig",
        depends = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "saghen/blink.cmp",
        },
    })

    setup_lsp_autocommands()
    setup_lsp_handlers()
end

MiniDeps.now(setup_lsp_config)
