-- lua/external_plugins/sniprun.lua

return {
	"michaelb/sniprun",
	branch = "master",

	build = "sh install.sh",
	-- do 'sh install.sh 1' if you want to force compile locally
	-- (instead of fetching a binary from the github release). Requires Rust >= 1.65

	config = function()
		require("sniprun").setup({
			--# use those instead of the default for the current filetype
			selected_interpreters = {},

			--# enable REPL-like behavior for the given interpreters
			repl_enable = {
				"Python3_original",
			},

			--# disable REPL-like behavior for the given interpreters
			repl_disable = {},

			--# interpreter-specific options, see doc / :SnipInfo <name>
			interpreter_options = {

				--# use the interpreter name as key
				GFM_original = {
					--# the 'use_on_filetypes' configuration key is
					use_on_filetypes = { "markdown.pandoc" },
					--# available for every interpreter
				},

				Python3_original = {
					-- NOTE: `pip install klepto` required
					--# Truncate runtime errormsg
					---@type "long" | "short" | "auto"
					error_truncate = "auto",
					--# the hint is available for every interpreter
					--# but may not be always respected
					interpreter = "python3.12",
				},

				Rust_original = {
					compiler = "rustc",
				},

				OrgMode_original = {
					default_filetype = "bash", -- default filetype/language name
				},

				Cpp_original = {
					compiler = "clang --debug",
				},
			},

			--# you can combo different display modes as desired and with the 'Ok' or 'Err' suffix
			--# to filter only sucessful runs (or errored-out runs respectively)
			display = {
				"Classic", --# display results in the command-line  area
				"VirtualTextOk", --# display ok results as virtual text (multiline is shortened)
				-- "VirtualText",             --# display results as virtual text
				-- "TempFloatingWindow",      --# display results in a floating window
				-- "LongTempFloatingWindow",  --# same as above, but only long results. To use with VirtualText[Ok/Err]
				-- "Terminal",                --# display results in a vertical split
				-- "TerminalWithCode",        --# display results and code history in a vertical split
				-- "NvimNotify",              --# display with the nvim-notify plugin
				-- "Api"                      --# return output to a programming interface
			},

			live_display = { "VirtualTextOk" }, --# display mode used in live_mode

			display_options = {
				--# change terminal display scrollback lines
				terminal_scrollback = vim.o.scrollback,

				--# whether show line number in terminal window
				terminal_line_number = false,

				--# whether show signcolumn in terminal window
				terminal_signcolumn = false,

				--# or "horizontal", to open as horizontal split instead of vertical split
				terminal_position = "vertical",

				--# change the terminal display option width (if vertical)
				terminal_width = 45,

				--# change the terminal display option height (if horizontal)
				terminal_height = 20,

				--# timeout for nvim_notify output
				notification_timeout = 5,
			},

			--# You can use the same keys to customize whether a sniprun producing
			--# no output should display nothing or '(no output)'
			show_no_output = {
				"Classic",
				--# implies LongTempFloatingWindow, which has no effect on its own
				"TempFloatingWindow",
			},

			--# customize highlight groups (setting this overrides colorscheme)
			--# any parameters of nvim_set_hl() can be passed as-is
			snipruncolors = {
				SniprunVirtualTextOk = { bg = "#66eeff", fg = "#000000", ctermbg = "Cyan", ctermfg = "Black" },
				SniprunFloatingWinOk = { fg = "#66eeff", ctermfg = "Cyan" },
				SniprunVirtualTextErr = { bg = "#881515", fg = "#000000", ctermbg = "DarkRed", ctermfg = "Black" },
				SniprunFloatingWinErr = { fg = "#881515", ctermfg = "DarkRed", bold = true },
			},

			--# live mode toggle, see Usage - Running for more info
			live_mode_toggle = "off",

			--# miscellaneous compatibility/adjustement settings
			--# Remove ANSI escapes (usually color) from outputs
			ansi_escape = true,

			--# boolean toggle for a one-line way to display output
			inline_messages = false,

			--# to workaround sniprun not being able to display anything
			--# display borders around floating windows
			---@type "none" | "single" | "double" | "shadow"
			borders = "single",
		})
	end,
}
