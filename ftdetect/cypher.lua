-- ftdetect/cypher.lua

vim.filetype.add({
    extension = {
        cypher = "cypher",
    },
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.cypher", "*.cql", "*.cyp" },
    callback = function()
        vim.bo.filetype = "cypher"
    end,
})
