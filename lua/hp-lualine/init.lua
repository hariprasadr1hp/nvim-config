-- for details, visit https://github.com/hoob3rt/lualine.nvim

local colors = {
	blue   = '#61afef',
	green  = '#98c379',
	purple = '#c678dd',
	red    = '#aa3300',
	red1   = '#e06c75',
	red2   = '#be5046',
	yellow = '#e5c07b',
	fg     = '#abb2bf',
	bg     = '#243238',
	gray1  = '#5c6370',
	gray2  = '#2c323d',
	gray3  = '#3e4452',
    yellow_green = '#AFFF87',
	dandelion = '#FFE300',
	white = '#FFFFFF',
	fl_green = '#08FF08',
	fl_yellow = '#CCFF02',
	fl_turquoise = '#00FDFF',
	fl_orange = "#FFCF00",
	fl_red = "#FF5555",
	fl_pink = "#FE1493"
}

local velvet = {
	normal = {
		a = {fg = colors.bg, bg = colors.yellow_green, gui = 'bold'},
		b = {fg = colors.yellow_green, bg = colors.bg, gui='bold'},
		c = {fg = colors.yellow_green, bg = colors.bg}
	},
	insert = {
		a = {fg = colors.bg, bg = colors.dandelion, gui = 'bold'},
		b = {fg = colors.dandelion, bg = colors.bg, gui='bold'},
		c = {fg = colors.dandelion, bg = colors.bg}
	},
	visual = {
		a = {fg = colors.bg, bg = colors.red1, gui = 'bold'},
		b = {fg = colors.red1, bg = colors.bg, gui='bold'},
		c = {fg = colors.red1, bg = colors.bg}
	},
	replace = {
		a = {fg = colors.bg, bg = colors.white, gui = 'bold'},
		b = {fg = colors.white, bg = colors.bg, gui='bold'},
		c = {fg = colors.white, bg = colors.bg}
	},
	command = {
		a = {fg = colors.yellow_green, bg = colors.bg, gui = 'bold'},
		b = {fg = colors.bg, bg = colors.yellow_green, gui='bold'},
		c = {fg = colors.bg, bg = colors.yellow_green},
	},
	inactive = {
		a = {fg = colors.gray1, bg = colors.bg, gui = 'bold'},
		b = {fg = colors.gray1, bg = colors.bg},
		c = {fg = colors.gray1, bg = colors.gray2}
	}
}

local function hello()
	return [[hello world]]
end


require'lualine'.setup {
	options = {
		icons_enabled = true,
		padding = 1,
		theme = velvet,
		-- theme = 'gruvbox',
		component_separators = {'', ''},
		section_separators = {'', ''},
		disabled_filetypes = {}
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'filename'},
		lualine_c = {'','branch','data', require'lsp-status'.status},
		lualine_x = {'filetype', 'fileformat', 'encoding'},
		lualine_y = {'progress'},
		lualine_z = {'location'}
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {'filename'},
		lualine_x = {'location'},
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {},
	extensions = {}
}
