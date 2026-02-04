-- after/ftplugin/mermaid.lua

vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = true
vim.opt_local.wrap = true
vim.opt_local.linebreak = true

-- local open_cmd = vim.fn.has("mac") == 1 and "open" or "xdg-open"
--
-- vim.keymap.set("n", "<leader>mp", function()
--     local file = vim.fn.expand("%")
--     local out = vim.fn.expand("%:r") .. ".svg"
--     vim.cmd(("!mmdc -i %s -o %s && %s %s"):format(file, out, open_cmd, out))
-- end, { buffer = true, desc = "Preview Mermaid Diagram" })
