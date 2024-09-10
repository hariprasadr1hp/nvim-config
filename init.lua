-- NETRW
-------------------------------------------------------------------
-- disable netrw at the very start
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- LEADER KEYS
-------------------------------------------------------------------
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', {noremap = true, silent = true})
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- lazy plugin manager
require('lazy_bootstrap')
require('lazy_settings')

-- lua settings
require('settings')
require('keybindings')
require('functions')
require('ollama')
require('neovide')
require('temp')

-- vimscript settings
vim.cmd('source ~/.config/nvim/vimscript/init.vim')
