vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.blend",
	callback = function()
		vim.bo.filetype = "blend"
	end,
})
