-- lua/plugins/git/neogit.lua

local M = {}

M = {
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			"ibhagwan/fzf-lua", -- optional
		},
		config = true,
	},
}

return M
