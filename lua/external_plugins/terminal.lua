-- lua/external_plugins/terminal.lua

local M = {}

local setup_toggleterm = function()
	require("toggleterm").setup({
		---@type "float" | "horizontal"
		direction = "horizontal",
	})
end

M = {
	"voldikss/vim-floaterm", -- Vim-floaterm setup
	{
		"akinsho/toggleterm.nvim", -- Toggleterm setup
		version = "*",
		config = function()
			setup_toggleterm()
		end,
	},
}

return M
