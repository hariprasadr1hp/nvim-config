-- lua/plugins/mini.lua

local M = {}

local function setup_mini_plugin() end

M = { {
	"echasnovski/mini.nvim",
	version = "*",
	config = function()
		setup_mini_plugin()
	end,
} }

return M
