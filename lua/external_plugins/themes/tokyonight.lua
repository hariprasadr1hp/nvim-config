-- lua/external_plugins/themes/tokyonight.lua

local M = {}

local setup_colors = function(transparent)
	return {
		bg = "#011628",
		bg_dark = "#011423",
		bg_highlight = "#143652",
		bg_search = "#0A64AC",
		bg_visual = "#275378",
		fg = "#CBE0F0",
		fg_dark = "#B4D0E9",
		fg_gutter = "#627E97",
		border = "#547998",
		transparent = transparent,
	}
end

local apply_custom_colors = function(custom_colors, colors, transparent)
	custom_colors.bg = colors.bg
	custom_colors.bg_dark = transparent and custom_colors.none or colors.bg_dark
	custom_colors.bg_float = transparent and custom_colors.none or colors.bg_dark
	custom_colors.bg_highlight = colors.bg_highlight
	custom_colors.bg_popup = colors.bg_dark
	custom_colors.bg_search = colors.bg_search
	custom_colors.bg_sidebar = transparent and custom_colors.none or colors.bg_dark
	custom_colors.bg_statusline = transparent and custom_colors.none or colors.bg_dark
	custom_colors.bg_visual = colors.bg_visual
	custom_colors.border = colors.border
	custom_colors.fg = colors.fg
	custom_colors.fg_dark = colors.fg_dark
	custom_colors.fg_float = colors.fg
	custom_colors.fg_gutter = colors.fg_gutter
	custom_colors.fg_sidebar = colors.fg_dark
end

local setup_tokyonight = function()
	local transparent = false

	local colors = setup_colors(transparent)

	require("tokyonight").setup({
		style = "night",
		transparent = transparent,
		styles = {
			sidebars = transparent and "transparent" or "dark",
			floats = transparent and "transparent" or "dark",
		},
		on_colors = function(custom_colors)
			apply_custom_colors(custom_colors, colors, transparent)
		end,
	})

	vim.cmd("colorscheme tokyonight")
end

M = {
	"folke/tokyonight.nvim",
	priority = 1000,
	config = function()
		setup_tokyonight()
	end,
}

return M
