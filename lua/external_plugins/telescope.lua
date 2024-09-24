-- lua/external_plugins/telescope.lua

local M = {}

local setup_mappings = function(actions)
	return {
		i = {
			["<c-enter>"] = "to_fuzzy_refine",
			["<esc>"] = actions.close,
			["<C-u>"] = false,
			-- Uncomment for cycling through previewers
			-- ["<C-s>"] = actions.cycle_previewers_next,
			-- ["<C-a>"] = actions.cycle_previewers_prev,
		},
	}
end

local setup_defaults = function(actions)
	return {
		preview = {
			filesize_limit = 0.1, -- MB limit for preview
		},
		mappings = setup_mappings(actions),
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--trim", -- trim lines to remove extra whitespaces
		},
	}
end

local setup_pickers = function()
	return {
		find_files = {
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
		},
	}
end

local setup_extensions = function()
	return {
		["ui-select"] = require("telescope.themes").get_dropdown(),
	}
end

local load_extensions = function()
	pcall(require("telescope").load_extension, "fzf")
	pcall(require("telescope").load_extension, "ui-select")
end

local setup_telescope = function()
	local actions = require("telescope.actions")

	require("telescope").setup({
		defaults = setup_defaults(actions),
		pickers = setup_pickers(),
		extensions = setup_extensions(),
	})

	load_extensions()
end

M = {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		setup_telescope()
	end,
}

return M
