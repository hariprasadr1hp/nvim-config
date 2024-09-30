-- lua/external_plugins/oil.lua

local M = {}

local columns = {
	"icon",
	-- "permissions",
	-- "size",
	-- "mtime",
}

local buf_options = {
	buflisted = false,
	bufhidden = "hide",
}

local win_options = {
	wrap = false,
	signcolumn = "no",
	cursorcolumn = false,
	foldcolumn = "0",
	spell = false,
	list = false,
	conceallevel = 3,
	concealcursor = "nvic",
}

local lsp_file_methods = {
	enabled = true,
	timeout_ms = 1000,
	autosave_changes = false,
}

local keymaps = {
	["g?"] = "actions.show_help",
	["<CR>"] = "actions.select",
	["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open in vertical split" },
	["<C-h>"] = { "actions.select", opts = { horizontal = true }, desc = "Open in horizontal split" },
	["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open in new tab" },
	["<C-p>"] = "actions.preview",
	["<C-c>"] = "actions.close",
	["<C-l>"] = "actions.refresh",
	["-"] = "actions.parent",
	["_"] = "actions.open_cwd",
	["`"] = "actions.cd",
	["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to current oil directory" },
	["gs"] = "actions.change_sort",
	["gx"] = "actions.open_external",
	["g."] = "actions.toggle_hidden",
	["g\\"] = "actions.toggle_trash",
}

local view_options = {
	show_hidden = false,
	is_hidden_file = function(name, _)
		return vim.startswith(name, ".")
	end,
	is_always_hidden = function(_, _)
		return false
	end,
	natural_order = true,
	case_insensitive = false,
	sort = {
		{ "type", "asc" },
		{ "name", "asc" },
	},
}

local git = {
	add = function(_)
		return false
	end,
	mv = function(_, _)
		return false
	end,
	rm = function(_)
		return false
	end,
}

local float = {
	padding = 2,
	max_width = 0,
	max_height = 0,
	border = "rounded",
	win_options = { winblend = 0 },
	preview_split = "auto",
	override = function(conf)
		return conf
	end,
}

local preview = {
	max_width = 0.9,
	min_width = { 40, 0.4 },
	width = nil,
	max_height = 0.9,
	min_height = { 5, 0.1 },
	height = nil,
	border = "rounded",
	win_options = { winblend = 0 },
	update_on_cursor_moved = true,
}

local progress = {
	max_width = 0.9,
	min_width = { 40, 0.4 },
	width = nil,
	max_height = { 10, 0.9 },
	min_height = { 5, 0.1 },
	height = nil,
	border = "rounded",
	minimized_border = "none",
	win_options = { winblend = 0 },
}

local ssh = {
	border = "rounded",
}

local keymaps_help = {
	border = "rounded",
}

local setup_oil = function()
	return require("oil").setup({
		default_file_explorer = true,
		columns = columns,
		buf_options = buf_options,
		win_options = win_options,
		delete_to_trash = false,
		skip_confirm_for_simple_edits = false,
		prompt_save_on_select_new_entry = true,
		cleanup_delay_ms = 2000,
		lsp_file_methods = lsp_file_methods,
		constrain_cursor = "editable",
		watch_for_changes = false,
		keymaps = keymaps,
		use_default_keymaps = true,
		view_options = view_options,
		extra_scp_args = {},
		git = git,
		float = float,
		preview = preview,
		progress = progress,
		ssh = ssh,
		keymaps_help = keymaps_help,
	})
end

M = {
	"stevearc/oil.nvim",
	opts = {},
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		setup_oil()
	end,
}

return M
