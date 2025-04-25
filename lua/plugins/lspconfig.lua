-- lua/plugins/lsp/lspconfig.lua

local function setup_lsp_handlers()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local blink_cmp = require("blink.cmp")

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, blink_cmp.get_lsp_capabilities({}, false))

    local handlers = {
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
                            -- library = vim.api.nvim_get_runtime_file("", true),
                            library = {
                                vim.fn.stdpath("config") .. "/lua",
                                vim.fn.stdpath("data") .. "/site/pack/deps",
                            },
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
    }

    mason_lspconfig.setup_handlers(handlers)
end

---@diagnostic disable-next-line: unused-local
local function setup_lsp_keymaps(event, client)
    local fzflua = require("fzf-lua")
    local buf = event.buf
    local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, {
            noremap = true,
            silent = true,
            buffer = buf,
            desc = desc,
        })
    end

    map("n", "gd", fzflua.lsp_definitions, "goto-definition")
    map("n", "gr", fzflua.lsp_references, "find-references")
    map("n", "gR", fzflua.lsp_references, "find-references")
    map("n", "gI", fzflua.lsp_implementations, "goto-implementation")
    map("n", "gD", fzflua.lsp_declarations, "goto-declaration")
    map("n", "g.", fzflua.lsp_code_actions, "code-action")
    -- map("n", "gd", vim.lsp.buf.definition, "goto-definition")
    -- map("n", "gr", vim.lsp.buf.references, "find-references")
    -- map("n", "gR", vim.lsp.buf.references, "find-references")
    -- map("n", "gI", vim.lsp.buf.implementation, "goto-implementation")
    -- map("n", "gD", vim.lsp.buf.declaration, "goto-declaration")
    -- map("n", "g.", vim.lsp.buf.code_action, "code-action")
    map("n", "gA", vim.lsp.buf.code_action, "code-action")
    map("n", "K", vim.lsp.buf.hover, "hover-documentation")

    map("n", "]d", function()
        vim.diagnostic.jump({ count = 1, float = true })
    end, "next-diagnostic")

    map("n", "[d", function()
        vim.diagnostic.jump({ count = -1, float = true })
    end, "prev-diagnostic")
end

local function on_lsp_attach(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    setup_lsp_keymaps(event, client)

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

local function setup_lsp_config()
    MiniDeps.add({
        source = "neovim/nvim-lspconfig",
        depends = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "saghen/blink.cmp",
            "folke/lazydev.nvim",
            "ibhagwan/fzf-lua",
        },
    })

    require("lazydev").setup()

    setup_lsp_handlers()
    setup_lsp_autocommands()
end

MiniDeps.later(setup_lsp_config)
