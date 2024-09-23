-- lua/commands.lua

vim.api.nvim_create_user_command("Runme", function()
	require("functions").runme()
end, {})
