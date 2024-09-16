-- lua/external_plugins/trouble.lua

return {
	{
		"folke/trouble.nvim",
		lazy = false,
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	},
}
