-- lua/plugins/trouble.lua

local M = {}

local function setup_config()
	require("trouble").setup({
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	})
end

M = {
	{
		"folke/trouble.nvim",
		lazy = false,
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			setup_config()
		end,
	},
}

return M
