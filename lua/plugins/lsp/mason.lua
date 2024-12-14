-- lua/plugins/mason.lua

local M = {}

local function setup_mason_config()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    mason.setup({
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗",
            },
        },
    })

    mason_lspconfig.setup({
        ensure_installed = {
            "ansiblels",
            "arduino_language_server",
            "clangd",
            "emmet_ls",
            "gitlab_ci_ls",
            "graphql",
            "jinja_lsp",
            "lua_ls",
            "pyright",
            "ruff",
            "sqls",
            "svelte",
            "ts_ls",
            "terraformls",
            "tflint",
            "vimls",
            "volar",
        },
    })

    mason_tool_installer.setup({
        ensure_installed = {
            "black", -- python formatter
            "isort", -- python formatter (sorting imports)
            "pylint", -- python linter
            "mypy", -- python linter (type annotations)
            "ruff", -- python formatter/linter
            "eslint_d", -- js/ts linter
            "prettier", -- js/ts formatter
            "biome", -- js/ts formatter
            "stylua", -- lua formatter
            "taplo", -- toml formatter
            "sqlfluff", -- sql linter
            "standardrb", -- ruby formatter
            "yamlfix", -- yaml formatter
        },
    })
end

M = {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = setup_mason_config,
}

return M
