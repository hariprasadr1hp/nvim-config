-- lua/plugins/lualine.lua

local M = {}

local colors = {
	blue = "#61afef",
	green = "#98c379",
	purple = "#c678dd",
	red = "#aa3300",
	red1 = "#e06c75",
	red2 = "#be5046",
	yellow = "#e5c07b",
	fg = "#abb2bf",
	bg = "#243238",
	gray1 = "#5c6370",
	gray2 = "#2c323d",
	gray3 = "#3e4452",
	yellow_green = "#afff87",
	dandelion = "#ffe300",
	white = "#ffffff",
	fl_green = "#08ff08",
	fl_yellow = "#ccff02",
	fl_turquoise = "#00fdff",
	fl_orange = "#ffcf00",
	fl_red = "#ff5555",
	fl_pink = "#fe1493",
}

local function setup_velvet_theme()
	return {
		normal = {
			a = { fg = colors.bg, bg = colors.yellow_green, gui = "bold" },
			b = { fg = colors.yellow_green, bg = colors.bg, gui = "bold" },
			c = { fg = colors.yellow_green, bg = colors.bg },
		},
		insert = {
			a = { fg = colors.bg, bg = colors.dandelion, gui = "bold" },
			b = { fg = colors.dandelion, bg = colors.bg, gui = "bold" },
			c = { fg = colors.dandelion, bg = colors.bg },
		},
		visual = {
			a = { fg = colors.bg, bg = colors.red1, gui = "bold" },
			b = { fg = colors.red1, bg = colors.bg, gui = "bold" },
			c = { fg = colors.red1, bg = colors.bg },
		},
		replace = {
			a = { fg = colors.bg, bg = colors.white, gui = "bold" },
			b = { fg = colors.white, bg = colors.bg, gui = "bold" },
			c = { fg = colors.white, bg = colors.bg },
		},
		command = {
			a = { fg = colors.yellow_green, bg = colors.bg, gui = "bold" },
			b = { fg = colors.bg, bg = colors.yellow_green, gui = "bold" },
			c = { fg = colors.bg, bg = colors.yellow_green },
		},
		terminal = {
			a = { fg = colors.bg, bg = colors.purple, gui = "bold" },
			b = { fg = colors.purple, bg = colors.bg, gui = "bold" },
			c = { fg = colors.purple, bg = colors.bg },
		},
		inactive = {
			a = { fg = colors.gray1, bg = colors.bg, gui = "bold" },
			b = { fg = colors.gray1, bg = colors.bg },
			c = { fg = colors.gray1, bg = colors.gray2 },
		},
	}
end

local function setup_sections()
	return {
		lualine_a = { "mode" },

		lualine_b = {
			"branch",
			{
				"filename",
				file_status = true, -- Displays file status (readonly status, modified status)
				newfile_status = false, -- Display new file status (new file means no write after created)
				path = 1, -- 0: Just the filename
				-- 1: Relative path
				-- 2: Absolute path
				-- 3: Absolute path, with tilde as the home directory
				-- 4: Filename and parent dir, with tilde as the home directory

				shorting_target = 40, -- Shortens path to leave 40 spaces in the window
				-- for other components. (terrible name, any suggestions?)
				symbols = {
					modified = "🖋️", -- Text to show when the file is modified.
					readonly = "🔒", -- Text to show when the file is non-modifiable or readonly.
					unnamed = "🤖", -- Text to show for unnamed buffers.
					newfile = "🌱", -- Text to show for newly created file before first write
				},
				---@diagnostic disable-next-line: unused-local
				on_click = function(clicks, button, modifiers)
					if clicks >= 1 and button == "l" then
						vim.cmd("Telescope find_files")
					end
				end,
			},
			"data",
		},

		lualine_c = {
			{
				"aerial",
				sep = "  ",
				depth = 2,
				dense = false,
				dense_sep = ".",
				colored = true,
				---@diagnostic disable-next-line: unused-local
				on_click = function(clicks, button, modifiers)
					if clicks >= 1 and button == "l" then
						vim.cmd("Telescope aerial")
					end
				end,
			},
		},

		lualine_x = {
			{
				"diagnostics",
				sources = { "nvim_lsp" },
				symbols = { error = " ", warn = " ", info = " " },
				colored = true,
				update_in_insert = false,
				always_visible = false,
				---@diagnostic disable-next-line: unused-local
				on_click = function(clicks, button, modifiers)
					if clicks >= 1 and button == "l" then
						vim.cmd("FzfLua diagnostics_document")
					end
				end,
			},
		},

		lualine_y = {
			{
				"filetype",
				---@diagnostic disable-next-line: unused-local
				on_click = function(clicks, button, modifiers)
					if clicks >= 1 and button == "l" then
						vim.cmd("Telescope filetypes")
					end
				end,
			},
			"fileformat",
			"encoding",
		},

		lualine_z = { "filesize", "progress", "location" },
	}
end

local function setup_inactive_sections()
	return {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	}
end

local function setup_lualine()
	local velvet = setup_velvet_theme()

	local lualine = require("lualine")
	lualine.setup({
		options = {
			icons_enabled = true,
			padding = 1,
			theme = velvet,
			component_separators = { "", "" },
			section_separators = { "", "" },
			disabled_filetypes = {
				statusline = {},
				winbar = {},
			},
			ignore_focus = {},
			always_divide_middle = true,
			globalstatus = false,
			refresh = {
				statusline = 1000,
				tabline = 1000,
				winbar = 1000,
			},
		},
		sections = setup_sections(),
		inactive_sections = setup_inactive_sections(),
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = {
			"nvim-tree",
			"nvim-dap-ui",
			"toggleterm",
		},
	})
end

M = {
	"hoob3rt/lualine.nvim",
	dependencies = {
		{ "kyazdani42/nvim-web-devicons", opt = true },
		{ "folke/noice.nvim" },
	},
	config = function()
		setup_lualine()
	end,
}

return M

-- TODO: lualine: refer the following links to upgrade the status info
-- https://github.com/folke/noice.nvim/wiki/Configuration-Recipes#show-recording-messages
