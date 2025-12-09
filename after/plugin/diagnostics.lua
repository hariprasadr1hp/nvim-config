-- after/plugin/diagnostics.lua

vim.diagnostic.config({
    severity_sort = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
            -- [vim.diagnostic.severity.ERROR] = "󰅚 ",
            -- [vim.diagnostic.severity.WARN] = "󰀪 ",
            -- [vim.diagnostic.severity.INFO] = "󰋽 ",
            -- [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
    },
    underline = true,
    update_in_insert = false,
    virtual_text = {
        severity = {
            min = vim.diagnostic.severity.WARN,
            max = vim.diagnostic.severity.ERROR,
        },
        spacing = 4,
        source = "if_many",
        prefix = "●",
    },
})
