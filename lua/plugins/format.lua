-- lua/plugins/format.lua

local function format_on_save(bufnr)
    -- Disable autoformat on certain filetypes
    local ignore_filetypes = { "c", "cpp" }
    if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
        return
    end

    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
    end

    -- Disable autoformat for files in a certain path
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if bufname:match("/node_modules/") then
        return
    end

    -- additional logic, if any
    return { timeout_ms = 10000, lsp_format = true }
end

local function format_after_save(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
    end

    -- additional logic, if any
    return { lsp_format = true }
end

local formatters_by_ft = {
    bash = { "shfmt" },
    css = { "prettier", stop_after_first = true },
    gdscript = { "gdtoolkit" },
    graphql = { "prettier", stop_after_first = true },
    html = { "prettier" },
    javascript = { "prettier", stop_after_first = true },
    javascriptreact = { "prettier", stop_after_first = true },
    json = { "prettier", stop_after_first = true },
    lua = { "stylua" },
    markdown = { "prettier" },
    python = { "isort", "black", "ruff_format" },
    ruby = { "standardrb" },
    rust = { "rustfmt", lsp_format = true },
    sh = { "shfmt" },
    sql = { "sqlfluff" },
    svelte = { "prettier", stop_after_first = true },
    toml = { "taplo" },
    typescript = { "prettier", stop_after_first = true },
    typescriptreact = { "prettier", stop_after_first = true },
    vue = { "prettier", stop_after_first = true },
    yaml = { "yamlfix" },
    zsh = { "shfmt" },
}

local formatters = {
    yamlfix = {
        -- https://lyz-code.github.io/yamlfix/
        command = "yaml-fix",
        args = { "--stdin", "--quiet", "--config", vim.fn.expand("~/.config/yamlfix.toml") },
        stdin = true,
    },
}

local function setup_format_config()
    local conform = require("conform")

    ---@module "conform"
    ---@type conform.setupOpts
    local opts = {
        formatters = formatters,
        formatters_by_ft = formatters_by_ft,
        notify_on_error = false,
        default_format_opts = {
            lsp_format = "fallback",
        },
        format_on_save = format_on_save,
        format_after_save = format_after_save,
    }

    conform.setup(opts)

    vim.schedule(function()
        vim.api.nvim_create_user_command("FormatBuffer", function(args)
            local range = nil
            if args.count ~= -1 then
                local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
                range = {
                    start = { args.line1, 0 },
                    ["end"] = { args.line2, end_line:len() },
                }
            end
            conform.format({ async = true, lsp_format = "fallback", range = range })
        end, { range = true })

        vim.api.nvim_create_user_command("FormatDisable", function(args)
            if args.bang then
                -- NOTE: FormatDisable! will disable formatting just for this buffer
                vim.b.disable_autoformat = true
            else
                vim.g.disable_autoformat = true
            end
        end, {
            desc = "disable-autoformat-on-save",
            bang = true,
        })

        vim.api.nvim_create_user_command("FormatEnable", function()
            vim.b.disable_autoformat = false
            vim.g.disable_autoformat = false
        end, {
            desc = "re-enable-autoformat-on-save",
        })

        vim.api.nvim_create_user_command("ListBufferFormatters", function()
            print(vim.inspect(conform.list_formatters(0)))
        end, {
            desc = "active-buffer-formatters",
        })

        vim.keymap.set("n", "<leader>cf", function()
            conform.format({ async = true, lsp_format = "fallback" })
        end, { desc = "format-buffer" })
    end)
end

return {
    "stevearc/conform.nvim",
    event = { "BufWritePre", "BufReadPre" },
    config = setup_format_config,
}
