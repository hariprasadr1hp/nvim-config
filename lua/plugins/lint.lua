-- lua/plugins/lint.lua

local function disable_default_linters(lint)
    lint.linters_by_ft["clojure"] = nil
    lint.linters_by_ft["dockerfile"] = nil
    lint.linters_by_ft["inko"] = nil
    lint.linters_by_ft["janet"] = nil
    lint.linters_by_ft["json"] = nil
    lint.linters_by_ft["markdown"] = nil
    lint.linters_by_ft["rst"] = nil
    lint.linters_by_ft["ruby"] = nil
    lint.linters_by_ft["terraform"] = nil
    lint.linters_by_ft["text"] = nil
    return lint
end

local linters_by_ft = {
    bash = { "shellcheck" },
    gdscript = { "gdtoolkit" },
    javascript = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    json = { "eslint_d" },
    markdown = { "markdownlint" },
    python = { "pylint" },
    ruby = { "standardrb" },
    sql = { "sqlfluff" },
    svelte = { "eslint_d" },
    terraform = { "tflint" },
    typescript = { "eslint_d" },
    typescriptreact = { "eslint_d" },
}

local linters = {
    sqlfluff = {
        args = {
            "lint",
            "--format=json",
            -- note: users will have to replace the --dialect argument accordingly
            "--dialect=postgres",
        },
    },
}

local function setup_lint_config(lint)
    lint.linters_by_ft = linters_by_ft
    lint.linters = linters
    disable_default_linters(lint)
    return lint
end

local setup_lint = function()
    MiniDeps.add({ source = "mfussenegger/nvim-lint" })

    local lint = require("lint")
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
        pattern = "*",
        callback = function()
            setup_lint_config(lint)
        end,
    })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
            setup_lint_config(lint)
        end,
    })

    vim.api.nvim_create_user_command("LintFile", function()
        setup_lint_config(lint)
    end, { desc = "Trigger linting on the current file" })
end

MiniDeps.later(setup_lint)

-- local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
--     group = lint_augroup,
--     callback = function()
--         require("lint").try_lint()
--     end,
-- })
