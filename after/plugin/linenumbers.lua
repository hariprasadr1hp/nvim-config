-- after/plugin/linenumbers.lua

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		vim.api.nvim_set_hl(0, "LineNr", { fg = "#e06c75" }) -- kinda red
		vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#98c379" }) -- yellowish green
		vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#71b951" }) -- kinda green
	end,
})
