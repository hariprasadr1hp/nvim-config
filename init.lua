-- NETRW
-------------------------------------------------------------------
-- disable netrw at the very start
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- LEADER KEYS
-------------------------------------------------------------------
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', {noremap = true, silent = true})
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- lazy plugin manager
require('lazy_bootstrap')
require('lazy_plugins')

-- lua settings
require('settings')
require('keybindings')
require('functions')
require('ollama')
require('temp')

-- lua plugins
require('hp-autopairs')
require('hp-comment')
require('hp-completion')
require('hp-debug')
require('hp-devicons')
require('hp-explorer')
require('hp-floaterm')
require('hp-git')
require('hp-lsp')
require('hp-lualine')
require('hp-material')
-- require('hp-onedark')
require('hp-telescope')
require('hp-theme')
require('hp-treesitter')
require('hp-whichkey')

-- vimscript settings
vim.cmd('source ~/.config/nvim/vimscript/init.vim')



-- local a = require('hp-theme')
