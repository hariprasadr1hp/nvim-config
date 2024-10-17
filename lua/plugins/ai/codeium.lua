-- lua/plugins/ai/codeium.lua

local M = {}

M = {
	{
		"Exafunction/codeium.vim",
		event = "BufEnter",
	},
}

vim.g.codeium_enabled = true
vim.g.codeium_manual = true

vim.keymap.set("i", "<C-g>", function()
	return vim.fn["codeium#Accept"]()
end, { expr = true, silent = true })

vim.keymap.set("i", "<C-l>", function()
	return vim.fn["codeium#AcceptNextWord"]()
end, { expr = true, silent = true })

vim.keymap.set("i", "<C-j>", function()
	return vim.fn["codeium#AcceptNextLine"]()
end, { expr = true, silent = true })

vim.keymap.set("i", "<c-;>", function()
	return vim.fn["codeium#CycleOrComplete"]()
end, { expr = true, silent = true })

vim.keymap.set("i", "<c-,>", function()
	return vim.fn["codeium#CycleCompletions"](-1)
end, { expr = true, silent = true })

vim.keymap.set("i", "<c-x>", function()
	return vim.fn["codeium#Clear"]()
end, { expr = true, silent = true })

vim.g.codeium_filetypes = {
	bash = false,
	typescript = true,
}

vim.g.codeium_workspace_root_hints =
	{ ".bzr", ".git", ".hg", ".svn", "_FOSSIL_", "package.json", "Makefile", "pyproject.toml" }

return M
