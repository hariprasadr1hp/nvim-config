-- lua/external_plugins/neorg.lua

local M = {}

local setup_neorg_config = function()
	return require("neorg").setup({
		load = {
			["core.defaults"] = {},
			["core.completion"] = {
				config = {
					engine = "nvim-cmp",
				},
			},
			["core.integrations.nvim-cmp"] = {},
			["core.dirman"] = {
				config = {
					workspaces = {
						notes = "~/my/neorg/notes",
					},
				},
			},
			["core.concealer"] = {
				config = {
					icon_preset = "varied",
				},
			},
		},
	})
end

M = {
	{
		"nvim-neorg/neorg",
		lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
		version = "*", -- Pin Neorg to the latest stable release
		opts = {
			-- luarocks_build_args = {
			-- 	"--with-lua-include=/usr/include",
			-- },
		},
		config = function()
			setup_neorg_config()
		end,
	},
}

return M
