-- lua/external_plugins/todo.lua

local M = {}

local keywords = {
	FIX = {
		icon = " ",
		color = "error",
		alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "FIX" },
	},
	TODO = { icon = " ", color = "info" },
	HACK = { icon = " ", color = "warning" },
	WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
	PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
	NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
	TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
}

local gui_style = {
	fg = "NONE",
	bg = "BOLD",
}

local highlight = {
	multiline = true,
	multiline_pattern = "^.",
	multiline_context = 10,
	before = "",
	keyword = "wide",
	after = "fg",
	pattern = [[.*<(KEYWORDS)\s*:]],
	comments_only = true,
	max_line_len = 400,
	exclude = {},
}

local colors = {
	error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
	warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
	info = { "DiagnosticInfo", "#2563EB" },
	hint = { "DiagnosticHint", "#10B981" },
	default = { "Identifier", "#7C3AED" },
	test = { "Identifier", "#FF00FF" },
}

local search = {
	command = "rg",
	args = {
		"--color=never",
		"--no-heading",
		"--with-filename",
		"--line-number",
		"--column",
	},
	pattern = [[\b(KEYWORDS):]], -- ripgrep regex pattern
}

local setup_keymaps = function()
	vim.keymap.set("n", "]t", function()
		require("todo-comments").jump_next()
	end, { desc = "Next todo comment" })

	vim.keymap.set("n", "[t", function()
		require("todo-comments").jump_prev()
	end, { desc = "Previous todo comment" })
end

local setup_todo_comments = function()
	require("todo-comments").setup({
		signs = true,
		sign_priority = 8,
		keywords = keywords,
		gui_style = gui_style,
		merge_keywords = true,
		highlight = highlight,
		colors = colors,
		search = search,
	})

	-- Set keymaps for navigating between TODO comments
	setup_keymaps()
end

M = {
	"folke/todo-comments.nvim",
	dependencies = "nvim-lua/plenary.nvim",
	config = function()
		setup_todo_comments()
	end,
}

return M

-- FIX: `:TodoFzfLua` error
