-- lua/plugins/gitsigns.lua

local M = {}

local signs = {
	add = { text = "+" },
	change = { text = "~" },
	delete = { text = "_" },
	topdelete = { text = "‾" },
	changedelete = { text = "~" },
	untracked = { text = "┆" },
}

local blame_opts = {
	virt_text = true,
	---@type "eol" | "overlay" | "right_align"
	virt_text_pos = "eol",
	delay = 1000,
	ignore_whitespace = false,
	virt_text_priority = 100,
}

local preview_config = {
	border = "single",
	style = "minimal",
	relative = "cursor",
	row = 0,
	col = 1,
}

local setup_on_attach = function()
	return function(bufnr)
		local gitsigns = require("gitsigns")

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map("n", "]h", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]h", bang = true })
			else
				gitsigns.nav_hunk("next")
			end
		end, { desc = "next-git-hunk" })

		map("n", "[h", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[h", bang = true })
			else
				gitsigns.nav_hunk("prev")
			end
		end, { desc = "prev-git-hunk" })
	end
end

local setup_gitsigns_config = function()
	return {
		signs = signs,
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
		current_line_blame_opts = blame_opts,
		current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
		sign_priority = 6,
		update_debounce = 100,
		status_formatter = nil, -- Use default
		max_file_length = 40000, -- Disable if file is longer than this
		preview_config = preview_config,
		on_attach = setup_on_attach(),
	}
end

M = {
	"lewis6991/gitsigns.nvim",
	opts = setup_gitsigns_config(),
}

return M
