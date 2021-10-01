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
require('hp-treesitter')
require('hp-whichkey')

-- vimscript settings
vim.cmd('source ~/.config/nvim/vimscript/init.vim')
vim.cmd('source ~/.config/nvim/vimscript/keys_xsel.vim')
vim.cmd('source ~/.config/nvim/vimscript/keys_surround.vim')
vim.cmd('source ~/.config/nvim/vimscript/keys_insert.vim')
vim.cmd('source ~/.config/nvim/vimscript/keys_meta.vim')
vim.cmd('source ~/.config/nvim/vimscript/functions.vim')
vim.cmd('source ~/.config/nvim/vimscript/temp.vim')

vim.cmd('source ~/.config/nvim/vimscript/plug-config/completion-nvim.vim')
-- vim.cmd('source ~/.config/nvim/vimscript/plug-config/vim-vsnip.vim')





