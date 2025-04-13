-- lua/plugins/lint.lua

local M = {}

local function disable_default_linters()
    local lint = require("lint")
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

local function setup_lint_config()
    local lint = require("lint")
    lint.linters_by_ft = linters_by_ft
    disable_default_linters()

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
            lint.try_lint()
        end,
    })
end

local opts = {
    linters = {
        sqlfluff = {
            args = {
                "lint",
                "--format=json",
                -- note: users will have to replace the --dialect argument accordingly
                "--dialect=postgres",
            },
        },
    },
}

M = {
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        opts = opts,
        config = setup_lint_config,
    },
}

vim.api.nvim_create_user_command("LintFile", function()
    require("lint").try_lint()
end, {
    desc = "Trigger linting on the current file",
})

return M

-- TODO: virtual text for lines with more than 1 diagnostic
-- show foo (+n more), instead of polluting the screen real estate
