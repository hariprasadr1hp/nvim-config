vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.gleam",
	callback = function()
		vim.bo.filetype = "gleam"
	end,
})
