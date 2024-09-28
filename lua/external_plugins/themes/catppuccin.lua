-- lua/external_plugins/themes/catppuccin.lua

-- TODO: bright colors for relative numbering

local M = {}

local dim_inactive = {
	enabled = true,
	shade = "light",
	percentage = 0.5,
}

local styles = {
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

local integrations = {
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

local catppuccin_config = {
	---@type "auto" | "latte" | "frappe" | "macchiato" | "mocha"
	flavour = "auto",
	background = {
		light = "latte",
		dark = "mocha",
	},
	transparent_background = false,
	show_end_of_buffer = false,
	term_colors = false,
	dim_inactive = dim_inactive,
	no_italic = false,
	no_bold = false,
	no_underline = false,
	styles = styles,
	color_overrides = {},
	custom_highlights = {},
	default_integrations = true,
	integrations = integrations,
}

local setup_catppuccin = function()
	require("catppuccin").setup(catppuccin_config)

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
