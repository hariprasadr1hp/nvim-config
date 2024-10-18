-- after/plugin/resize_window.lua

local function exit_window_resize_mode()
	-- print("window-resize-mode exited...")
	vim.api.nvim_echo({ { "-- window-resize-mode succesfully exited!", "InfoMsg" } }, false, {})

	vim.api.nvim_buf_del_keymap(0, "n", "h")
	vim.api.nvim_buf_del_keymap(0, "n", "l")
	vim.api.nvim_buf_del_keymap(0, "n", "j")
	vim.api.nvim_buf_del_keymap(0, "n", "k")
	vim.api.nvim_buf_del_keymap(0, "n", "<esc>")
	vim.api.nvim_buf_del_keymap(0, "n", "<up>")
	vim.api.nvim_buf_del_keymap(0, "n", "<down>")
	vim.api.nvim_buf_del_keymap(0, "n", "<left>")
	vim.api.nvim_buf_del_keymap(0, "n", "<right>")
	vim.api.nvim_buf_del_keymap(0, "n", "q")
end

local function enter_window_resize_mode()
	vim.api.nvim_echo(
		{ { "-- window-resize-mode: Use h/j/k/l or arrows to resize, Esc/q to exit --", "WarningMsg" } },
		false,
		{}
	)

	vim.api.nvim_buf_set_keymap(0, "n", "h", ":vertical resize +5<CR>", { noremap = true, silent = true })
	vim.api.nvim_buf_set_keymap(0, "n", "k", ":resize +5<CR>", { noremap = true, silent = true })
	vim.api.nvim_buf_set_keymap(0, "n", "j", ":resize -5<CR>", { noremap = true, silent = true })
	vim.api.nvim_buf_set_keymap(0, "n", "l", ":vertical resize -5<CR>", { noremap = true, silent = true })
	vim.api.nvim_buf_set_keymap(0, "n", "q", ":WindowResizeModeExit<CR>", { noremap = true, silent = true })
	vim.api.nvim_buf_set_keymap(0, "n", "<esc>", "WindowResizeModeExit<CR>", { noremap = true, silent = true })
	vim.api.nvim_buf_set_keymap(0, "n", "<up>", ":resize +5<CR>", { noremap = true, silent = true })
	vim.api.nvim_buf_set_keymap(0, "n", "<down>", ":resize -5<CR>", { noremap = true, silent = true })
	vim.api.nvim_buf_set_keymap(0, "n", "<right>", ":vertical resize +5<CR>", { noremap = true, silent = true })
	vim.api.nvim_buf_set_keymap(0, "n", "<left>", ":vertical resize -5<CR>", { noremap = true, silent = true })
end

vim.api.nvim_create_user_command("WindowResizeModeEnter", enter_window_resize_mode, {})
vim.api.nvim_create_user_command("WindowResizeModeExit", exit_window_resize_mode, {})
