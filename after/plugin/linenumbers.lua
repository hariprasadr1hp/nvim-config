-- after/plugin/linenumbers.lua

local colors = {
	red = "#e06c75",
	yellowish_green = "#98c379",
	green = "#71b951",
	yellow = "#e5c07b",
	blue = "#0987ff",
}

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		vim.api.nvim_set_hl(0, "LineNr", { fg = colors.red })
		vim.api.nvim_set_hl(0, "LineNrAbove", { fg = colors.yellowish_green })
		vim.api.nvim_set_hl(0, "LineNrBelow", { fg = colors.green })
	end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
	pattern = "*",
	callback = function()
		local mode = vim.fn.mode()
		if mode == "n" then
			vim.api.nvim_set_hl(0, "LineNr", { fg = colors.red })
			vim.api.nvim_set_hl(0, "LineNrAbove", { fg = colors.yellowish_green })
			vim.api.nvim_set_hl(0, "LineNrBelow", { fg = colors.green })
		elseif mode == "i" then
			vim.api.nvim_set_hl(0, "LineNr", { fg = colors.red })
			vim.api.nvim_set_hl(0, "LineNrAbove", { fg = colors.yellow })
			vim.api.nvim_set_hl(0, "LineNrBelow", { fg = colors.yellow })
		elseif mode == "v" or "V" then
			vim.api.nvim_set_hl(0, "LineNr", { fg = colors.yellowish_green })
			vim.api.nvim_set_hl(0, "LineNrAbove", { fg = colors.red })
			vim.api.nvim_set_hl(0, "LineNrBelow", { fg = colors.red })
		else
			vim.api.nvim_set_hl(0, "LineNr", { fg = colors.red })
			vim.api.nvim_set_hl(0, "LineNrAbove", { fg = colors.yellowish_green })
			vim.api.nvim_set_hl(0, "LineNrBelow", { fg = colors.green })
		end
	end,
})

vim.api.nvim_create_autocmd("RecordingEnter", {
	pattern = "*",
	callback = function()
		vim.api.nvim_set_hl(0, "LineNr", { fg = colors.blue })
		vim.api.nvim_set_hl(0, "LineNrAbove", { fg = colors.blue })
		vim.api.nvim_set_hl(0, "LineNrBelow", { fg = colors.blue })
	end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
	pattern = "*",
	callback = function()
		vim.api.nvim_set_hl(0, "LineNr", { fg = colors.red })
		vim.api.nvim_set_hl(0, "LineNrAbove", { fg = colors.yellowish_green })
		vim.api.nvim_set_hl(0, "LineNrBelow", { fg = colors.green })
	end,
})
