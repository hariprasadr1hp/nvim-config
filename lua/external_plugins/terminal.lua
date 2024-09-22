-- lua/external_plugins/terminal.lua

-- floaterm, for details, visit https://github.com/voldikss/vim-floaterm

return {
	"voldikss/vim-floaterm",
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				---@type "float" | "horizontal"
				direction = "horizontal",
			})
		end,
	},
}
