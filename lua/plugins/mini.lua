-- lua/plugins/mini.lua

local M = {}

local setup_mini_plugin = function() end

M = { {
	"echasnovski/mini.nvim",
	version = "*",
	config = function()
		setup_mini_plugin()
	end,
} }

return M
