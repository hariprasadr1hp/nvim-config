-- lua/commands.lua

vim.api.nvim_create_user_command("Runme", function()
	require("functions").runme()
end, {})

vim.api.nvim_create_user_command("FilePath", function()
	print(vim.fn.expand("%:p"))
end, {})

vim.api.nvim_create_user_command("FileName", function()
	print(vim.fn.expand("%:t"))
end, {})

vim.api.nvim_create_user_command("FileNameWihoutExt", function()
	print(vim.fn.expand("%:t:r"))
end, {})

vim.api.nvim_create_user_command("FileExt", function()
	print(vim.fn.expand("%:e"))
end, {})

vim.api.nvim_create_user_command("ReadFilePath", function()
	-- Get the current file path
	local filepath = vim.fn.expand("%:p")

	-- Get the current cursor position (row and column)
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))

	-- Insert the file path at the cursor position
	vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { filepath })
end, {})
