-- after/ftplugin/oil.lua

vim.keymap.set("n", "<leader>oi", ":quit<cr>", { noremap = true, silent = true, desc = "goto-help-tag", buffer = 0 })
vim.keymap.set("n", "q", ":quit<cr>", { noremap = true, silent = true, desc = "goto-help-tag", buffer = 0 })
