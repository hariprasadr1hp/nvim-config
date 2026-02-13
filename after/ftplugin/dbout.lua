-- after/ftplugin/dbout.lua

local keymap_set = require("config.helpers").keymap_set

keymap_set("n", "<leader>;t", "<Plug>(DBUI_ToggleResultLayout)", "toggle-result-layout", { buffer = true })
