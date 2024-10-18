-- after/plugin/resize_window.lua

-- to resize window interactively, rather than pressing `<C-w>>/<` everytime
-- `:WindowResizeModeEnter` to enter the mode
-- once entered, h/j/k/l or arrow keys to resize interactively
-- `q` to quit mode

local function exit_window_resize_mode()
	vim.api.nvim_echo({ { "-- window-resize-mode succesfully exited!", "InfoMsg" } }, false, {})

	vim.api.nvim_buf_del_keymap(0, "n", "h")
	vim.api.nvim_buf_del_keymap(0, "n", "l")
	vim.api.nvim_buf_del_keymap(0, "n", "j")
	vim.api.nvim_buf_del_keymap(0, "n", "k")
	vim.api.nvim_buf_del_keymap(0, "n", "<up>")
	vim.api.nvim_buf_del_keymap(0, "n", "<down>")
	vim.api.nvim_buf_del_keymap(0, "n", "<left>")
	vim.api.nvim_buf_del_keymap(0, "n", "<right>")
	vim.api.nvim_buf_del_keymap(0, "n", "q")
end

local function enter_window_resize_mode()
	vim.api.nvim_echo(
		{ { "-- window-resize-mode: Use h/j/k/l or arrows to resize, q to exit --", "WarningMsg" } },
		false,
		{}
	)

	vim.api.nvim_buf_set_keymap(0, "n", "h", ":vertical resize +1<CR>", { noremap = true, silent = true })
	vim.api.nvim_buf_set_keymap(0, "n", "k", ":resize +1<CR>", { noremap = true, silent = true })
	vim.api.nvim_buf_set_keymap(0, "n", "j", ":resize -1<CR>", { noremap = true, silent = true })
	vim.api.nvim_buf_set_keymap(0, "n", "l", ":vertical resize -1<CR>", { noremap = true, silent = true })
	vim.api.nvim_buf_set_keymap(0, "n", "q", ":WindowResizeModeExit<CR>", { noremap = true, silent = true })
	vim.api.nvim_buf_set_keymap(0, "n", "<up>", ":resize +1<CR>", { noremap = true, silent = true })
	vim.api.nvim_buf_set_keymap(0, "n", "<down>", ":resize -1<CR>", { noremap = true, silent = true })
	vim.api.nvim_buf_set_keymap(0, "n", "<right>", ":vertical resize +1<CR>", { noremap = true, silent = true })
	vim.api.nvim_buf_set_keymap(0, "n", "<left>", ":vertical resize -1<CR>", { noremap = true, silent = true })
end

vim.api.nvim_create_user_command("WindowResizeModeEnter", enter_window_resize_mode, {})
vim.api.nvim_create_user_command("WindowResizeModeExit", exit_window_resize_mode, {})
