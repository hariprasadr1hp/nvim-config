-- lua/plugins/undo_tree.lua

local M = {}

local setup_options = function()
	return {
		extensions = {
			undo = {
				side_by_side = true,
				layout_strategy = "vertical",
				layout_config = {
					preview_height = 0.8,
				},
			},
		},
	}
end

local setup_telescope = function(opts)
	require("telescope").setup(opts)
	require("telescope").load_extension("undo")
end

M = {
	"debugloop/telescope-undo.nvim",
	dependencies = {
		{
			"nvim-telescope/telescope.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
		},
	},
	keys = {
		{ "<leader>zu", "<cmd>Telescope undo<cr>", desc = "undo history" },
	},
	opts = setup_options(),
	config = function(_, opts)
		setup_telescope(opts)
	end,
}

return M
