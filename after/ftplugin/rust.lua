-- after/ftplugin/rust.lua

local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set("n", "g.", function()
    vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
end, { silent = true, buffer = bufnr })

vim.keymap.set("n", "K", function()
    vim.cmd.RustLsp({ "hover", "actions" })
end, { silent = true, buffer = bufnr })
