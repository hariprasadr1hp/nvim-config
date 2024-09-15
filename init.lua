-- init.lua

require("settings")

require("lazy_bootstrap")
require("lazy_plugins")

require("keybindings")
require("functions")
require("ollama")
require("neovide")
require("temp")

vim.cmd("source ~/.config/nvim/vimscript/init.vim")

