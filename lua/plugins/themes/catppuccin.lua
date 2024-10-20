-- lua/plugins/themes/catppuccin.lua

local M = {}

local dim_inactive = {
	enabled = true,
	shade = "light",
	percentage = 0.5,
}

local colors = {
	rosewater = "#f5e0dc",
	flamingo = "#f2cdcd",
	pink = "#f5c2e7",
	mauve = "#cba6f7",
	red = "#f38ba8",
	maroon = "#eba0ac",
	peach = "#fab387",
	yellow = "#f9e2af",
	green = "#a6e3a1",
	teal = "#94e2d5",
	sky = "#89dceb",
	sapphire = "#74c7ec",
	blue = "#89b4fa",
	lavender = "#b4befe",
	text = "#cdd6f4",
	subtext1 = "#bac2de",
	subtext0 = "#a6adc8",
	overlay2 = "#9399b2",
	overlay1 = "#7f849c",
	overlay0 = "#6c7086",
	surface2 = "#585b70",
	surface1 = "#45475a",
	surface0 = "#313244",
	base = "#1e1e2e",
	mantle = "#181825",
	crust = "#11111b",
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
	highlight_overrides = {
		all = {
			CursorLineNr = { fg = colors.pink, style = { "bold" } },
		},
	},
	color_overrides = {
		mocha = colors,
	},
	custom_highlights = {},
	default_integrations = true,
	integrations = integrations,
}

local function setup_catppuccin()
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
