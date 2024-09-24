-- lua/external_plugins/harpoon.lua

local M = {}

local setup_harpoon = function()
	local harpoon = require("harpoon")
	harpoon:setup()
end

local toggle_telescope = function(harpoon_files)
	local conf = require("telescope.config").values
	local file_paths = {}

	for _, item in ipairs(harpoon_files.items) do
		table.insert(file_paths, item.value)
	end

	require("telescope.pickers")
		.new({}, {
			prompt_title = "Harpoon",
			finder = require("telescope.finders").new_table({
				results = file_paths,
			}),
			previewer = conf.file_previewer({}),
			sorter = conf.generic_sorter({}),
		})
		:find()
end

local setup_keymaps = function()
	local harpoon = require("harpoon")

	-- Add files to Harpoon list
	vim.keymap.set("n", "<leader>hla", function()
		harpoon:list():add()
	end, { desc = "harpoon-add" })

	-- Toggle Harpoon quick menu
	vim.keymap.set("n", "<leader>oh", function()
		harpoon.ui:toggle_quick_menu(harpoon:list())
	end, { desc = "toggle-harpoon" })

	-- Select specific files from Harpoon list
	vim.keymap.set("n", "<leader>1", function()
		harpoon:list():select(1)
	end, { desc = "harpoon-1" })

	vim.keymap.set("n", "<leader>2", function()
		harpoon:list():select(2)
	end, { desc = "harpoon-2" })

	vim.keymap.set("n", "<leader>3", function()
		harpoon:list():select(3)
	end, { desc = "harpoon-3" })

	vim.keymap.set("n", "<leader>4", function()
		harpoon:list():select(4)
	end, { desc = "harpoon-4" })

	vim.keymap.set("n", "<leader>5", function()
		harpoon:list():select(5)
	end, { desc = "harpoon-5" })

	-- Toggle previous & next buffers stored in Harpoon list
	vim.keymap.set("n", "<leader>hlp", function()
		harpoon:list():prev()
	end, { desc = "harpoon-prev" })
	vim.keymap.set("n", "<leader>hln", function()
		harpoon:list():next()
	end, { desc = "harpoon-next" })

	-- Toggle Harpoon list with Telescope
	vim.keymap.set("n", "<leader>hlo", function()
		toggle_telescope(harpoon:list())
	end, { desc = "harpoon-telescope" })
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
