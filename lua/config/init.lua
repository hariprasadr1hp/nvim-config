-- lua/config/init.lua

require("config.settings")

require("config.lazy_bootstrap")
require("lazy_plugins")
require("lazy_settings")

require("config.helpers")
require("config.commands")
require("config.keybindings")
require("config.neovide")
