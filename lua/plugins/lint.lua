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

local function setup_lint_config()
    local lint = require("lint")
    lint.linters_by_ft = linters_by_ft
    lint.linters = linters
    disable_default_linters(lint)

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.defer_fn(function()
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = lint_augroup,
            callback = function()
                pcall(lint.try_lint)
            end,
        })

        vim.keymap.set("n", "<leader>cl", function()
          lint.try_lint()
        end, { desc = "lint-current-buffer" })
    end, 0)
end

return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = setup_lint_config,
}
