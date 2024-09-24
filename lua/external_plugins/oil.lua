-- lua/external_plugins/oil.lua

local M = {}

local setup_columns = function()
	return {
		"icon",
		-- "permissions",
		-- "size",
		-- "mtime",
	}
end

local setup_buf_options = function()
	return {
		buflisted = false,
		bufhidden = "hide",
	}
end

local setup_win_options = function()
	return {
		wrap = false,
		signcolumn = "no",
		cursorcolumn = false,
		foldcolumn = "0",
		spell = false,
		list = false,
		conceallevel = 3,
		concealcursor = "nvic",
	}
end

local setup_lsp_file_methods = function()
	return {
		enabled = true,
		timeout_ms = 1000,
		autosave_changes = false,
	}
end

local setup_keymaps = function()
	return {
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
end

local setup_view_options = function()
	return {
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
end

local setup_git = function()
	return {
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
end

local setup_float = function()
	return {
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
end

local setup_preview = function()
	return {
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
end

local setup_progress = function()
	return {
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
end

local setup_ssh = function()
	return {
		border = "rounded",
	}
end

local setup_keymaps_help = function()
	return {
		border = "rounded",
	}
end

local setup_oil = function()
	require("oil").setup({
		default_file_explorer = true,
		columns = setup_columns(),
		buf_options = setup_buf_options(),
		win_options = setup_win_options(),
		delete_to_trash = false,
		skip_confirm_for_simple_edits = false,
		prompt_save_on_select_new_entry = true,
		cleanup_delay_ms = 2000,
		lsp_file_methods = setup_lsp_file_methods(),
		constrain_cursor = "editable",
		watch_for_changes = false,
		keymaps = setup_keymaps(),
		use_default_keymaps = true,
		view_options = setup_view_options(),
		extra_scp_args = {},
		git = setup_git(),
		float = setup_float(),
		preview = setup_preview(),
		progress = setup_progress(),
		ssh = setup_ssh(),
		keymaps_help = setup_keymaps_help(),
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
