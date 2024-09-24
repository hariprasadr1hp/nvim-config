-- lua/external_plugins/gitsigns.lua

local M = {}

local setup_signs = function()
	return {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	}
end

local setup_blame_opts = function()
	return {
		virt_text = true,
		---@type "eol" | "overlay" | "right_align"
		virt_text_pos = "eol",
		delay = 1000,
		ignore_whitespace = false,
		virt_text_priority = 100,
	}
end

local setup_preview_config = function()
	return {
		border = "single",
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	}
end

local setup_on_attach = function()
	return function(bufnr)
		local gitsigns = require("gitsigns")

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map("n", "]c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gitsigns.nav_hunk("next")
			end
		end, { desc = "Jump to next git [c]hange" })

		map("n", "[c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gitsigns.nav_hunk("prev")
			end
		end, { desc = "Jump to previous git [c]hange" })
	end
end

local setup_gitsigns_config = function()
	return {
		signs = setup_signs(),
		signcolumn = true,
		numhl = false,
		linehl = false,
		word_diff = false,
		watch_gitdir = {
			follow_files = true,
		},
		auto_attach = true,
		attach_to_untracked = false,
		current_line_blame = false,
		current_line_blame_opts = setup_blame_opts(),
		current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
		sign_priority = 6,
		update_debounce = 100,
		status_formatter = nil, -- Use default
		max_file_length = 40000, -- Disable if file is longer than this
		preview_config = setup_preview_config(),
		on_attach = setup_on_attach(),
	}
end

M = {
	"lewis6991/gitsigns.nvim",
	opts = setup_gitsigns_config(),
}

return M
