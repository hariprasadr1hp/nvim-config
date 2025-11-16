-- ftdetect/turtle.lua

vim.filetype.add({
    extension = {
        turtle = "turtle",
    },
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.ttl", "*.turtle" },
    callback = function()
        vim.bo.filetype = "turtle"
    end,
})
