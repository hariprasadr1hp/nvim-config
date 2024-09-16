-- lua/external_plugins/explorer.lua

-- each of these are documented in `:help nvim-tree.OPTION_NAME`
-- nested options are documented by accessing them with `.` (eg: `:help nvim-tree.view.mappings.list`).

local config = {
	auto_reload_on_write = true,
	create_in_closed_folder = false,
	disable_netrw = false,
	hijack_cursor = true,
	hijack_netrw = true,
	hijack_unnamed_buffer_when_opening = false,
	sync_root_with_cwd = true,
	open_on_tab = false,
	sort_by = "name",
	update_cwd = false,
	reload_on_bufenter = true,
	respect_buf_cwd = false,

	view = {
		adaptive_size = false,
		width = 30,
		side = "left",
		preserve_window_proportions = false,
		number = false,
		relativenumber = false,
		signcolumn = "yes",

		float = {
			enable = false,
			quit_on_focus_loss = true,
			open_win_config = {
				relative = "editor",
				border = "rounded",
				width = 30,
				height = 30,
				row = 1,
				col = 1,
			},
		},
	},

	renderer = {
		add_trailing = false,
		group_empty = false,
		highlight_clipboard = "all",
		highlight_diagnostics = "icon",
		highlight_git = "icon",
		highlight_hidden = "all",
		highlight_opened_files = "icon",
		highlight_modified = "icon",
		root_folder_modifier = ":~",
		indent_markers = {
			enable = true,
			icons = {
				corner = "└ ",
				edge = "│ ",
				none = "  ",
			},
		},

		icons = {
			webdev_colors = true,
			git_placement = "signcolumn",
			padding = " ",
			symlink_arrow = " ➛ ",
			show = {
				file = true,
				folder = true,
				folder_arrow = false,
				git = true,
			},

			glyphs = {
				default				= "",
				symlink				= "",
				folder = {
					arrow_closed	= "",
					arrow_open		= "",
					default			= "",
					open			= "",
					empty			= "",
					empty_open		= "",
					symlink			= "",
					symlink_open	= "",
				},

				git = {
					unstaged		= "✗",
					staged			= "✓",
					unmerged		= "",
					renamed			= "➜",
					untracked		= "★",
					deleted			= "",
					ignored			= "◌",
				},
			},
		},

		special_files = {
			"Cargo.toml",
			"Makefile",
			"README.md",
			"readme.md"
		},
	},

	hijack_directories = {
		enable = true,
		auto_open = true,
	},

	update_focused_file = {
		enable = false,
		update_cwd = false,
		ignore_list = {},
	},

	system_open = {
		cmd = "",
		args = {},
	},

	diagnostics = {
		enable = true,
		show_on_dirs = true,
		icons = {
			hint		= "",
			info		= "",
			warning		= "",
			error		= "",
		},
	},

	filters = {
		dotfiles = false,
		custom = {"^.git$"},
		exclude = {},
	},

	git = {
		enable = true,
		ignore = false,
		timeout = 400,
	},

	actions = {
		use_system_clipboard = true,
		change_dir = {
			enable = false,
			global = false,
			restrict_above_cwd = true,
		},

		expand_all = {
			max_folder_discovery = 300,
		},

		open_file = {
			quit_on_open = false,
			resize_window = true,
			window_picker = {
				enable = true,
				chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
				exclude = {
					filetype = {
						"notify",
						"qf",
						"diff",
						"fugitive",
						"fugitiveblame"
					},
					buftype = {
						"nofile",
						"terminal",
						"help"
					},
				},
			},
		},

		remove_file = {
			close_window = true,
		},
	},

	trash = {
		cmd = "trash",
		require_confirm = true,
	},

	live_filter = {
		prefix = "[FILTER]: ",
		always_show_folders = false,
	},

	log = {
		enable = false,
		truncate = true,
		types = {
			all = false,
			config = false,
			copy_paste = false,
			diagnostics = false,
			git = false,
			profile = false,
		},
	},

}

-- require 'nvim-tree'.setup (config)


return{
	"kyazdani42/nvim-tree.lua",
	version = "*",
	dependencies = {
	  "kyazdani42/nvim-web-devicons", -- optional, for file icon
	},
	config = config,
}
