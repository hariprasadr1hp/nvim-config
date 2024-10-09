-- lua/plugins/explorer.lua

-- each of these are documented in `:help nvim-tree.OPTION_NAME`
-- nested options are documented by accessing them with `.` (eg: `:help nvim-tree.view.mappings.list`).

local M = {}

local view = {
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
}

local indent_markers = {
	enable = true,
	icons = {
		corner = "└ ",
		edge = "│ ",
		none = "  ",
	},
}

local glyphs = {
	default = "",
	symlink = "",
	folder = {
		arrow_closed = "",
		arrow_open = "",
		default = "",
		open = "",
		empty = "",
		empty_open = "",
		symlink = "",
		symlink_open = "",
	},
	git = {
		unstaged = "✗",
		staged = "✓",
		unmerged = "",
		renamed = "➜",
		untracked = "★",
		deleted = "",
		ignored = "◌",
	},
}

local icons = {
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
	glyphs = glyphs,
}

local renderer = {
	add_trailing = false,
	group_empty = false,
	highlight_clipboard = "all",
	highlight_diagnostics = "icon",
	highlight_git = "icon",
	highlight_hidden = "all",
	highlight_opened_files = "icon",
	highlight_modified = "icon",
	root_folder_modifier = ":~",
	indent_markers = indent_markers,
	icons = icons,
	special_files = {
		"Cargo.toml",
		"Makefile",
		"README.md",
		"readme.md",
	},
}

local hijack_directories = {
	enable = true,
	auto_open = true,
}

local update_focused_file = {
	enable = false,
	update_cwd = false,
	ignore_list = {},
}

local system_open = {
	cmd = "",
	args = {},
}

local diagnostics = {
	enable = true,
	show_on_dirs = true,
	icons = {
		hint = "",
		info = "",
		warning = "",
		error = "",
	},
}

local filters = {
	dotfiles = false,
	custom = { "^.git$" },
	exclude = {},
}

local git = {
	enable = true,
	ignore = false,
	timeout = 400,
}

local window_picker = {
	enable = true,
	chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
	exclude = {
		filetype = {
			"notify",
			"qf",
			"diff",
			"fugitive",
			"fugitiveblame",
		},
		buftype = {
			"nofile",
			"terminal",
			"help",
		},
	},
}

local actions = {
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
		window_picker = window_picker,
	},
	remove_file = {
		close_window = true,
	},
}

local trash = {
	cmd = "trash",
	require_confirm = true,
}

local live_filter = {
	prefix = "[FILTER]: ",
	always_show_folders = false,
}

local log = {
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
}

local setup_config = function()
	return require("nvim-tree").setup({
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
		view = view,
		renderer = renderer,
		hijack_directories = hijack_directories,
		update_focused_file = update_focused_file,
		system_open = system_open,
		diagnostics = diagnostics,
		filters = filters,
		git = git,
		actions = actions,
		trash = trash,
		live_filter = live_filter,
		log = log,
	})
end

M = {
	"kyazdani42/nvim-tree.lua",
	version = "*",
	dependencies = {
		"kyazdani42/nvim-web-devicons", -- optional, for file icons
	},
	config = function()
		setup_config()
	end,
}

return M
