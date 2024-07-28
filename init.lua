-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', {noremap = true, silent = true})
vim.g.mapleader = ' '

-- This is also a good place to setup other settings (vim.opt)



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
