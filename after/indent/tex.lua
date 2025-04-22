-- after/indent/tex.lua

-- INDENTATION
-------------------------------------------------------------------
-- insert 4 spaces for a tab
vim.o.tabstop = 4
vim.o.softtabstop = 4

-- change the number of space characters inserted for indentation
vim.o.shiftwidth = 4

-- converts tabs to spaces (if true)
vim.o.expandtab = true

-- auto-indent within brackets (if true)
vim.o.smartindent = true
