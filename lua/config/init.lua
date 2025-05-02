-- lua/config/init.lua

require("config.settings")

require("config.variables")
require("config.helpers")
require("config.functions")
require("config.commands")
require("config.keybindings")
require("config.neovide")

-- lazy.nvim required
require("config.bootstrap")
require("plugins")
