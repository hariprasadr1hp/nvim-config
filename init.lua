-- lua settings
require('settings')
require('plugins')
require('keybindings')
require('functions')

-- lua plugins
require('hp-autopairs')
require('hp-comment')
require('hp-completion')
require('hp-floaterm')
require('hp-galaxyline')
require('hp-lsp')
require('hp-material')
require('hp-onedark')
require('hp-telescope')
require('hp-treesitter')
require('hp-whichkey')

-- vimscript settings
vim.cmd('source ~/.config/nvim/vimscript/init.vim')
vim.cmd('source ~/.config/nvim/vimscript/functions.vim')
vim.cmd('source ~/.config/nvim/vimscript/temp.vim')

vim.cmd('source ~/.config/nvim/vimscript/plug-config/completion-nvim.vim')
-- vim.cmd('source ~/.config/nvim/vimscript/plug-config/vim-vsnip.vim')





