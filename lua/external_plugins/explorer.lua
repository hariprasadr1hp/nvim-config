-- lua/external_plugins/explorer.lua

-- each of these are documented in `:help nvim-tree.OPTION_NAME`
-- nested options are documented by accessing them with `.` (eg: `:help nvim-tree.view.mappings.list`).

local M = {}

local setup_view = function()
	return {
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
end

local setup_indent_markers = function()
	return {
		enable = true,
		icons = {
			corner = "└ ",
			edge = "│ ",
			none = "  ",
		},
	}
end

local setup_glyphs = function()
	return {
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
end

local setup_icons = function()
	return {
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
		glyphs = setup_glyphs(),
	}
end

local setup_renderer = function()
	return {
		add_trailing = false,
		group_empty = false,
		highlight_clipboard = "all",
		highlight_diagnostics = "icon",
		highlight_git = "icon",
		highlight_hidden = "all",
		highlight_opened_files = "icon",
		highlight_modified = "icon",
		root_folder_modifier = ":~",
		indent_markers = setup_indent_markers(),
		icons = setup_icons(),
		special_files = {
			"Cargo.toml",
			"Makefile",
			"README.md",
			"readme.md",
		},
	}
end

local setup_hijack_directories = function()
	return {
		enable = true,
		auto_open = true,
	}
end

local setup_update_focused_file = function()
	return {
		enable = false,
		update_cwd = false,
		ignore_list = {},
	}
end

local setup_system_open = function()
	return {
		cmd = "",
		args = {},
	}
end

local setup_diagnostics = function()
	return {
		enable = true,
		show_on_dirs = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	}
end

local setup_filters = function()
	return {
		dotfiles = false,
		custom = { "^.git$" },
		exclude = {},
	}
end

local setup_git = function()
	return {
		enable = true,
		ignore = false,
		timeout = 400,
	}
end

local setup_window_picker = function()
	return {
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
end

local setup_actions = function()
	return {
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
			window_picker = setup_window_picker(),
		},
		remove_file = {
			close_window = true,
		},
	}
end

local setup_trash = function()
	return {
		cmd = "trash",
		require_confirm = true,
	}
end

local setup_live_filter = function()
	return {
		prefix = "[FILTER]: ",
		always_show_folders = false,
	}
end

local setup_log = function()
	return {
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
end

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
		view = setup_view(),
		renderer = setup_renderer(),
		hijack_directories = setup_hijack_directories(),
		update_focused_file = setup_update_focused_file(),
		system_open = setup_system_open(),
		diagnostics = setup_diagnostics(),
		filters = setup_filters(),
		git = setup_git(),
		actions = setup_actions(),
		trash = setup_trash(),
		live_filter = setup_live_filter(),
		log = setup_log(),
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
