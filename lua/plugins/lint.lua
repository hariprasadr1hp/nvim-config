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

local function get_sql_linter()
    if vim.env.DBT_PROJECT_DIR then
        local bufname = vim.api.nvim_buf_get_name(0)
        if bufname:find(vim.env.DBT_PROJECT_DIR, 1, true) then
            return { "sqlfluff" }
        end
    end
    return nil
end

local linters_by_ft = {
    ansible = { "ansiblelint" },
    bash = { "shellcheck" },
    gdscript = { "gdtoolkit" },
    javascript = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    json = { "jsonls" },
    jsonc = { "jsonls" },
    markdown = { "markdownlint" },
    -- python = { "ruff", "mypy" },  -- handled by ruff LSP
    ruby = { "standardrb" },
    sql = get_sql_linter,
    svelte = { "eslint_d" },
    terraform = { "tflint" },
    toml = { "taplo" },
    typescript = { "eslint_d" },
    typescriptreact = { "eslint_d" },
}

local function setup_lint_config()
    local lint = require("lint")

    -- Set static linters first
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
                -- For SQL files, dynamically determine linter based on DBT_PROJECT_DIR
                if vim.bo.filetype == "sql" then
                    local linters = get_sql_linter()
                    if linters then
                        lint.try_lint(linters)
                    end
                else
                    pcall(lint.try_lint)
                end
            end,
        })

        vim.keymap.set("n", "<leader>cl", function()
            if vim.bo.filetype == "sql" then
                local linters = get_sql_linter()
                if linters then
                    lint.try_lint(linters)
                end
            else
                lint.try_lint()
            end
        end, { desc = "lint-current-buffer" })
    end, 0)
end

return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = setup_lint_config,
}
