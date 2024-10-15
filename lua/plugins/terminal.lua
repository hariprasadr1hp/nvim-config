-- lua/plugins/terminal.lua

local M = {}

local function setup_toggleterm()
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
