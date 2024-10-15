-- lua/plugins/autopairs.lua

local M = {}

local function setup_cmp_autopairs()
	local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	local cmp = require("cmp")
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

local function setup_autopairs()
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
