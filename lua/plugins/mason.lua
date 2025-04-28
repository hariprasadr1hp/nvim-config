-- lua/plugins/mason.lua

local mason_opts = {
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    },
}

local mason_lspconfig_opts = {
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
}

local mason_tool_installer_opts = {
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
}

local function setup_mason()
    require("mason").setup(mason_opts)
    require("mason-lspconfig").setup(mason_lspconfig_opts)
    require("mason-tool-installer").setup(mason_tool_installer_opts)

    local map = require("config.helpers").map
    map("n", "<leader>oM", ":Mason<CR>", "mason-window")
end

return {
    "williamboman/mason.nvim",
    dependencies = {
        { "williamboman/mason-lspconfig.nvim" },
        { "WhoIsSethDaniel/mason-tool-installer.nvim" },
    },
    config = setup_mason,
}
