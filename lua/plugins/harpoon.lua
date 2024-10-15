-- lua/plugins/harpoon.lua

local M = {}

local function setup_harpoon()
	local harpoon = require("harpoon")
	harpoon:setup()
end

local function setup_keymaps()
	local harpoon_list = require("harpoon"):list()

	-- Toggle previous & next buffers stored in Harpoon list
	vim.keymap.set("n", "[n", function()
		harpoon_list:prev()
	end, { desc = "prev-harpoon" })
	vim.keymap.set("n", "]n", function()
		harpoon_list:next()
	end, { desc = "next-harpoon" })
end

M = {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		setup_harpoon()
		setup_keymaps()
	end,
}

return M
