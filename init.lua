-- init.lua

local config_dir = vim.fn.stdpath("config")

-- vim config
vim.cmd("source " .. config_dir .. "/vimscript/init.vim")

-- lua config
require("config")

vim.notify("sourced `" .. config_dir .. "/init.lua` successfully!", vim.log.levels.INFO)
