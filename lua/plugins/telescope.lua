-- lua/plugins/telescope.lua

local M = {}

local function setup_mappings(actions)
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

-- local setup_defaults = function(actions)
local function setup_defaults(actions)
	return {
		preview = {
			filesize_limit = 0.1, -- MB limit for preview
		},
		---@types "horizontal" | "vertical"
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				height = 0.99,
				preview_cutoff = 120,
				prompt_position = "bottom",
				width = 0.99,
			},
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

local pickers = {
	find_files = {
		find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
	},
}

local function setup_extensions()
	return {
		["ui-select"] = require("telescope.themes").get_dropdown(),
	}
end

local function load_extensions()
	pcall(require("telescope").load_extension, "fzf")
	pcall(require("telescope").load_extension, "ui-select")
end

local function setup_telescope()
	local actions = require("telescope.actions")

	require("telescope").setup({
		defaults = setup_defaults(actions),
		pickers = pickers,
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

-- TODO: 2 or 3 additional telescope functions to show ignored, untracked and hidden files as well
-- TODO exclude `*.lock` files from `:Telescope find_files`
