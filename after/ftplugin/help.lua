-- after/ftplugin/help.lua

vim.bo.buflisted = true

vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.expandtab = true

vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true

vim.keymap.set("n", "gd", "<C-]>", { noremap = true, silent = true, desc = "goto-help-tag" })
