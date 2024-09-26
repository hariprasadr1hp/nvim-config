-- lua/external_plugins/cloak.lua

local M = {}

local patterns = {
	{
		file_pattern = { ".env*", "dev.vars" },
		cloak_pattern = "=.+",
		replace = nil, -- Keeps the first character by default
	},
}

local setup_cloak_config = function()
	return require("cloak").setup({
		enabled = true,
		cloak_character = "*",
		highlight_group = "Comment",
		cloak_length = nil, -- Use a number to hide the actual length of the value.
		try_all_patterns = true,
		cloak_telescope = true,
		cloak_on_leave = false,
		patterns = patterns,
	})
end

M = {
	"laytan/cloak.nvim",
	config = function()
		setup_cloak_config()
	end,
}

return M
