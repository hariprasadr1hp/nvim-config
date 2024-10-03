vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.bend",
	callback = function()
		vim.bo.filetype = "bend"
	end,
})
