-- lua/lazy_plugins.lua

local plugins = {
	require("external_plugins/themes/catppuccin"),
	require("external_plugins/themes/cyberdream"),
	require("external_plugins/themes/nordic"),
	require("external_plugins/themes/tokyonight"),

	require("external_plugins/autopairs"),
	require("external_plugins/comment"),
	require("external_plugins/gitsigns"),
	require("external_plugins/treesitter"),
	require("external_plugins/text_objects"),
	require("external_plugins/telescope"),
	require("external_plugins/lsp"),
	require("external_plugins/formatting"),
	require("external_plugins/completion"),
	require("external_plugins/linting"),
	require("external_plugins/explorer"),
	require("external_plugins/lualine"),
	require("external_plugins/misc"),
	require("external_plugins/notify"),
	require("external_plugins/terminal"),
	require("external_plugins/todo"),
	require("external_plugins/org"),
	require("external_plugins/trouble"),
	require("external_plugins/undo_tree"),
	require("external_plugins/zenmode"),
	require("external_plugins/codesnap"),
	require("external_plugins/testing"),
	require("external_plugins/cloak"),
	require("external_plugins/sniprun"),

	-- require("external_plugins/oil"),
	-- require("external_plugins/harpoon"),
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
