-- after/ftplugin/sql.lua

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

-- KEYMAPS
-------------------------------------------------------------------
local keymap_set = require("config.helpers").keymap_set

keymap_set("n", "<leader>;r", "<Plug>(DBUI_ExecuteQuery)", "dbui-run-query", { buffer = true })
keymap_set("x", "<leader>;r", "<Plug>(DBUI_ExecuteQuery)", "dbui-run-select-query", { buffer = true })
keymap_set("n", "<leader>;s", "<Plug>(DBUI_SaveQuery)", "dbui-save-query", { buffer = true })
-- TODO: edit-bind-parameters?

keymap_set("n", ",m", "<Plug>(DBUI_ExecuteQuery)", "dbui-run-query", { buffer = true })
keymap_set("x", ",m", "<Plug>(DBUI_ExecuteQuery)", "dbui-run-select-query", { buffer = true })
