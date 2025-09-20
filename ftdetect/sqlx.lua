vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.sqlx",
    callback = function()
        vim.bo.filetype = "sqlx"
    end,
})
