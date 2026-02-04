-- after/ftplugin/nix.lua

-- INDENTATION
-------------------------------------------------------------------
-- insert n spaces for a tab
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2

-- change the number of space characters inserted for indentation
vim.opt_local.shiftwidth = 2

-- converts tabs to spaces (if true)
vim.opt_local.expandtab = true

-- auto-indent within brackets (if true)
vim.opt_local.smartindent = true
