-- init.lua

require("settings")

require("lazy_bootstrap")
require("lazy_plugins")
require("lazy_settings")

require("helpers")
require("commands")
require("keybindings")
require("neovide")

vim.cmd("source ~/.config/nvim/vimscript/init.vim")
