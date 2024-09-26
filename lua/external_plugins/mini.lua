-- lua/external_plugins/mini.lua

local M = {}

local mappings = {
	-- Main textobject prefixes
	around = "a",
	inside = "i",

	-- Next/last variants
	around_next = "an",
	inside_next = "in",
	around_last = "al",
	inside_last = "il",

	-- Move cursor to corresponding edge of `a` textobject
	goto_left = "g[",
	goto_right = "g]",
}

local setup_mini_plugin = function()
	require("mini.ai").setup({
		mappings = mappings,
		custom_textobjects = nil,
		-- Search within 50 lines above and below
		n_lines = 50,
		---@type "cover" | "cover_or_next" | "next"
		search_method = "cover_or_next",
	})
end

M = { {
	"echasnovski/mini.nvim",
	version = "*",
	config = function()
		setup_mini_plugin()
	end,
} }

return M
