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
                            library = {
                                "${3rd}/luv/library",
                                vim.api.nvim_get_runtime_file("", true),
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
local function setup_lsp_keymaps(buf)
    local map = require("config.helpers").map
    -- local fzflua = require("fzf-lua")
    -- local buffer = event.buf

    map("n", "<leader>il", ":LspInfo<CR>", "lsp-info")
    map("n", "<leader>lI", ":LspInfo<CR>", "lsp-info")
    map("n", "<leader>lR", ":LspRestart<CR>", "lsp-restart")
end

-- highlight groups
local highlight_augroup = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true })
local detach_augroup = vim.api.nvim_create_augroup("LspDetachCleanup", { clear = true })

local function on_lsp_attach(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if not client then
        return
    end

    local buf = event.buf

    setup_lsp_keymaps(buf)

    if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
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
            buffer = event.buf,
            group = detach_augroup,
            callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = highlight_augroup, buffer = event2.buf })
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
        end, { buffer = event.buf, desc = "toggle-inlay-hints" })
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
    setup_lsp_handlers()
    setup_lsp_autocommands()
end

return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { "saghen/blink.cmp" },
        { "ibhagwan/fzf-lua" },
        { "antosha417/nvim-lsp-file-operations", config = true },
        {
            "folke/lazydev.nvim",
            ft = "lua",
            cmd = "LazyDev",
            keys = {
                { "<leader>ic", "<cmd>LazyDev lsp<CR>", desc = "lsp-client-info" },
            },
            opts = {
                library = {
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },
    },
    config = setup_lsp_config,
}
