vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.jinja",
	callback = function()
		vim.bo.filetype = "jinja"
	end,
})
