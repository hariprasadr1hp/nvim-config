-- after/ftplugin/tex.lua

-- INDENTATION
-------------------------------------------------------------------
-- insert n spaces for a tab
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4

-- change the number of space characters inserted for indentation
vim.opt_local.shiftwidth = 4

-- converts tabs to spaces (if true)
vim.opt_local.expandtab = true

-- auto-indent within brackets (if true)
vim.opt_local.smartindent = true
