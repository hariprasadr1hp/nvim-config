-- after/indent/sql.lua

-- INDENTATION
-------------------------------------------------------------------
-- insert 2 spaces for a tab
vim.o.tabstop = 2
vim.o.softtabstop = 2

-- change the number of space characters inserted for indentation
vim.o.shiftwidth = 2

-- converts tabs to spaces (if true)
vim.o.expandtab = true

-- auto-indent within brackets (if true)
vim.o.smartindent = true
