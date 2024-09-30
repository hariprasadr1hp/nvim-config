-- lua/lazy_plugins.lua

local plugins = {
	require("external_plugins/themes/catppuccin"),
	require("external_plugins/themes/cyberdream"),
	require("external_plugins/themes/nordic"),
	require("external_plugins/themes/tokyonight"),

	require("external_plugins/icons"),
	require("external_plugins/rocks"),
	require("external_plugins/autopairs"),
	require("external_plugins/comment"),
	require("external_plugins/text_objects"),
	require("external_plugins/treesitter"),
	require("external_plugins/telescope"),
	require("external_plugins/gitsigns"),
	require("external_plugins/neogit"),
	require("external_plugins/lsp"),
	require("external_plugins/codeium"),
	require("external_plugins/gen"),
	require("external_plugins/neorg"),
	require("external_plugins/org"),
	require("external_plugins/completion"),
	require("external_plugins/lint"),
	require("external_plugins/format"),
	require("external_plugins/terminal"),
	require("external_plugins/explorer"),
	require("external_plugins/mini"),
	-- require("external_plugins/notify"),
	require("external_plugins/lualine"),
	require("external_plugins/undo_tree"),
	require("external_plugins/harpoon"),
	require("external_plugins/todo_comments"),
	require("external_plugins/testing"),
	require("external_plugins/trouble"),
	require("external_plugins/cloak"),
	require("external_plugins/repl"),
	require("external_plugins/zenmode"),
	require("external_plugins/snapshot"),
	require("external_plugins/misc"),

	-- require("external_plugins/oil"),
	-- require("external_plugins/debug"),
	-- require("external_plugins/headlines"),

	-----------------------------------------------------------------
	-----------------------------------------------------------------

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
		end,
		opts = {},
	},
}

-----------------------------------------------------------------------
-----------------------------------------------------------------------

local ui = {
	-- If you are using a Nerd Font: set icons to an empty table which will use the
	-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
	icons = vim.g.have_nerd_font and {} or {
		cmd = "⌘",
		config = "🛠",
		event = "📅",
		ft = "📂",
		init = "⚙",
		keys = "🗝",
		plugin = "🔌",
		runtime = "💻",
		require = "🌙",
		source = "📄",
		start = "🚀",
		task = "📌",
		lazy = "💤 ",
	},
}

local opts = {
	ui = ui,
}

require("lazy").setup(plugins, opts)

require("external_plugins/whichkey")

-- TODO: creating language/extension-specific functionalities
