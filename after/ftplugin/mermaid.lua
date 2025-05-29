-- after/ftplugin/mermaid.lua

local v = vim.opt_local

v.tabstop = 2
v.shiftwidth = 2
v.expandtab = true
v.wrap = true
v.linebreak = true

-- local open_cmd = vim.fn.has("mac") == 1 and "open" or "xdg-open"
--
-- vim.keymap.set("n", "<leader>mp", function()
--     local file = vim.fn.expand("%")
--     local out = vim.fn.expand("%:r") .. ".svg"
--     vim.cmd(("!mmdc -i %s -o %s && %s %s"):format(file, out, open_cmd, out))
-- end, { buffer = true, desc = "Preview Mermaid Diagram" })
