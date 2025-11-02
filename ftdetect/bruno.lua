-- ftdetect/bruno.lua

vim.filetype.add({
    extension = {
        bruno = "bruno",
    },
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.bru", "*.bruno" },
    callback = function()
        vim.bo.filetype = "bruno"
    end,
})
