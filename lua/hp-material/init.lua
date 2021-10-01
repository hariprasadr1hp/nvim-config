
--[[
* available themes to choose from:
+ darker
+ lighter
+ oceanic
+ palenight
+ deep ocean
]]--

-- vim.cmd("colorscheme material")

-- vim.g.material_style = "darker"
-- vim.g.material_style = "lighter"
vim.g.material_style = "oceanic"
-- vim.g.material_style = "palenight"
-- vim.g.material_style = "deep ocean"

require('material').setup({

	contrast = true, -- Enable contrast for sidebars, floating windows and popup menus like Nvim-Tree
	borders = false, -- Enable borders between verticaly split windows

	italics = {
		comments = false, -- Enable italic comments
		keywords = false, -- Enable italic keywords
		functions = false, -- Enable italic functions
		strings = false, -- Enable italic strings
		variables = false -- Enable italic variables
	},

	contrast_windows = { -- Specify which windows get the contrasted (darker) background
		"terminal", -- Darker terminal background
		"packer", -- Darker packer background
		"qf" -- Darker qf list background
	},

	text_contrast = {
		lighter = false, -- Enable higher contrast text for lighter style
		darker = false -- Enable higher contrast text for darker style
	},

	disable = {
		background = false, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
		term_colors = false, -- Prevent the theme from setting terminal colors
		eob_lines = false -- Hide the end-of-buffer lines
	},

	custom_highlights = {
		CursorLine = '#0000FF',
		LineNr = '#FFFFFF'
	} -- Overwrite highlights with your own ("https://github.com/marko-cerovac/material.nvim/blob/main/lua/material/theme.lua")
})
