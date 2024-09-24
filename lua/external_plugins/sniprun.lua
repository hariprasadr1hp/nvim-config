-- lua/external_plugins/sniprun.lua

local M = {}

local setup_interpreter_options = function()
	return {
		GFM_original = {
			use_on_filetypes = { "markdown.pandoc" },
		},
		Python3_original = {
			---@type "long" | "short" | "auto"
			error_truncate = "auto",
			interpreter = "python3.12",
		},
		Rust_original = {
			compiler = "rustc",
		},
		OrgMode_original = {
			default_filetype = "bash",
		},
		Cpp_original = {
			compiler = "clang --debug",
		},
	}
end

local setup_display_options = function()
	return {
		terminal_scrollback = vim.o.scrollback,
		terminal_line_number = false,
		terminal_signcolumn = false,
		terminal_position = "vertical",
		terminal_width = 45,
		terminal_height = 20,
		notification_timeout = 5,
	}
end

local setup_colors = function()
	return {
		SniprunVirtualTextOk = { bg = "#66eeff", fg = "#000000", ctermbg = "Cyan", ctermfg = "Black" },
		SniprunFloatingWinOk = { fg = "#66eeff", ctermfg = "Cyan" },
		SniprunVirtualTextErr = { bg = "#881515", fg = "#000000", ctermbg = "DarkRed", ctermfg = "Black" },
		SniprunFloatingWinErr = { fg = "#881515", ctermfg = "DarkRed", bold = true },
	}
end

local setup_sniprun_config = function()
	return require("sniprun").setup({
		selected_interpreters = {},
		repl_enable = { "Python3_original" },
		repl_disable = {},
		interpreter_options = setup_interpreter_options(),
		display = { "Classic", "VirtualTextOk" },
		live_display = { "VirtualTextOk" },
		display_options = setup_display_options(),
		show_no_output = { "Classic", "TempFloatingWindow" },
		snipruncolors = setup_colors(),
		live_mode_toggle = "off",
		ansi_escape = true,
		inline_messages = false,
		borders = "single",
	})
end

local setup_sniprun = function()
	setup_sniprun_config()
end

M = {
	"michaelb/sniprun",
	branch = "master",
	build = "sh install.sh",
	config = function()
		setup_sniprun()
	end,
}

return M
