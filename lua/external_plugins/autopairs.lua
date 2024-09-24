-- lua/external_plugins/autopairs.lua

local M = {}

local setup_cmp_autopairs = function()
	local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	local cmp = require("cmp")
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

local setup_autopairs = function()
	local autopairs = require("nvim-autopairs")
	autopairs.setup({})

	-- Setup for nvim-cmp integration
	setup_cmp_autopairs()
end

M = {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	dependencies = { "hrsh7th/nvim-cmp" }, -- Optional dependency
	config = function()
		setup_autopairs()
	end,
}

return M
