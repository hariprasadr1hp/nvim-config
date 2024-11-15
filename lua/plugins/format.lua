-- lua/plugins/format.lua

local M = {}

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
    return { timeout_ms = 500, lsp_format = "fallback" }
end

local function format_after_save(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
    end

    -- additional logic, if any
    return { lsp_format = "fallback" }
end

local formatters_by_ft = {
    bash = { "beautysh" },
    css = { "prettier", stop_after_first = true },
    gdscript = { "gdtoolkit" },
    graphql = { "prettier", stop_after_first = true },
    html = { "prettier" },
    javascript = { "prettier", stop_after_first = true },
    javascriptreact = { "prettier", stop_after_first = true },
    json = { "prettier", stop_after_first = true },
    lua = { "stylua" },
    markdown = { "prettier" },
    python = { "isort", "black", "ruff" },
    ruby = { "standardrb" },
    rust = { "rustfmt", lsp_format = "fallback" },
    svelte = { "prettier", stop_after_first = true },
    toml = { "taplo" },
    typescript = { "prettier", stop_after_first = true },
    typescriptreact = { "prettier", stop_after_first = true },
    vue = { "prettier", stop_after_first = true },
    yaml = { "yamlfix" },
}

--- @module "conform"
--- @type conform.setupOpts
local opts = {
    formatters_by_ft = formatters_by_ft,
    notify_on_error = false,
    default_format_opts = {
        lsp_format = "fallback",
    },
    format_on_save = format_on_save,
    format_after_save = format_after_save,
}

M = {
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        opts = opts,
    },
}

vim.api.nvim_create_user_command("Format", function(args)
    local range = nil
    if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
        }
    end
    require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true })

vim.api.nvim_create_user_command("FormatDisable", function(args)
    if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
    else
        vim.g.disable_autoformat = true
    end
end, {
    desc = "Disable autoformat-on-save",
    bang = true,
})

vim.api.nvim_create_user_command("FormatEnable", function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
end, {
    desc = "Re-enable autoformat-on-save",
})

return M
