-- lua/config/init.lua

require("config.settings")

require("config.helpers")
require("config.functions")
require("config.commands")
require("config.keybindings")
require("config.neovide")

-- mini.deps required
require("config.bootstrap")
require("plugins")
