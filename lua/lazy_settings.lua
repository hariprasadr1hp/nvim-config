-- lua/lazy_settings.lua

vim.cmd.colorscheme("catppuccin")

vim.g.floaterm_gitcommit = "floaterm"
vim.g.floaterm_autoinsert = 1
vim.g.floaterm_width = 0.99
vim.g.floaterm_height = 0.99
vim.g.floaterm_wintitle = 0
vim.g.floaterm_autoclose = 1
vim.g.floaterm_opener = "edit"
vim.g.floaterm_keymap_toggle = "<Leader>ot"
-- vim.g.floaterm_keymap_toggle = "<F1>"
-- vim.g.floaterm_keymap_next   = "<F2>"
-- vim.g.floaterm_keymap_prev   = "<F3>"
-- vim.g.floaterm_keymap_new    = "<F4>"
-- vim.g.floaterm_title=""

-- custom commands
vim.cmd("command! FZF FloatermNew fzf")
