-- lua/external_plugins/themes/catppuccin.lua

-- TODO: bright colors for relative numbering

local M = {}

local setup_dim_inactive = function()
	return {
		enabled = false,
		shade = "dark",
		percentage = 0.15,
	}
end

local setup_styles = function()
	return {
		comments = { "italic" },
		conditionals = { "italic" },
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
	}
end

local setup_integrations = function()
	return {
		cmp = true,
		gitsigns = true,
		nvimtree = true,
		treesitter = true,
		notify = false,
		mini = {
			enabled = true,
			indentscope_color = "",
		},
	}
end

local setup_catppuccin_config = function()
	return {
		---@type "auto" | "latte" | "frappe" | "macchiato" | "mocha"
		flavour = "auto",
		background = {
			light = "latte",
			dark = "mocha",
		},
		transparent_background = false,
		show_end_of_buffer = false,
		term_colors = false,
		dim_inactive = setup_dim_inactive(),
		no_italic = false,
		no_bold = false,
		no_underline = false,
		styles = setup_styles(),
		color_overrides = {},
		custom_highlights = {},
		default_integrations = true,
		integrations = setup_integrations(),
	}
end

local setup_catppuccin = function()
	require("catppuccin").setup(setup_catppuccin_config())

	-- setup must be called before loading the colorscheme
	vim.cmd.colorscheme("catppuccin")
end

M = {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		setup_catppuccin()
	end,
}

return M
