-- lua settings
require('settings')
require('plugins')
require('keybindings')
require('functions')
require('temp')

-- lua plugins
require('hp-autopairs')
require('hp-comment')
require('hp-completion')
require('hp-devicons')
require('hp-floaterm')
require('hp-git')
require('hp-lsp')
require('hp-lualine')
require('hp-material')
require('hp-onedark')
require('hp-telescope')
require('hp-theme')
require('hp-treesitter')
require('hp-whichkey')

-- vimscript settings
vim.cmd('source ~/.config/nvim/vimscript/init.vim')



-- local a = require('hp-theme')
