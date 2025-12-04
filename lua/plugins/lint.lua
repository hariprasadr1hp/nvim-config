-- lua/plugins/lint.lua

local disable_linters_for_ft = {
    "clojure",
    "dockerfile",
    "inko",
    "janet",
    "json",
    "markdown",
    "rst",
    "ruby",
    "terraform",
    "text",
}

local linters_by_ft = {
    bash = { "shellcheck" },
    gdscript = { "gdtoolkit" },
    javascript = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    json = { "jsonls" },
    jsonc = { "jsonls" },
    markdown = { "markdownlint" },
    python = { "ruff" },
    ruby = { "standardrb" },
    sql = { "sqlfluff" },
    svelte = { "eslint_d" },
    terraform = { "tflint" },
    toml = { "taplo" },
    typescript = { "eslint_d" },
    typescriptreact = { "eslint_d" },
}

local function setup_lint_config()
    local lint = require("lint")

    lint.linters_by_ft = linters_by_ft

    if lint.linters.sqlfluff then
        lint.linters.sqlfluff.args = {
            "lint",
            "--format=json",
            "--dialect=bigquery",
        }
        lint.linters.sqlfluff.stdin = false
    end

    for _, ft in ipairs(disable_linters_for_ft) do
        lint.linters_by_ft[ft] = nil
    end

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
