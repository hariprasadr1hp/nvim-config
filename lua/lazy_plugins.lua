-- lua/lazy_plugins.lua

local plugins = {
	require("external_plugins/autopairs"),
	require("external_plugins/gitsigns"),
	require("external_plugins/treesitter"),
	require("external_plugins/telescope"),
	require("external_plugins/lsp"),
	require("external_plugins/conform"),
	require("external_plugins/completion"),
	require("external_plugins/lint"),
	require("external_plugins/explorer"),
	require("external_plugins/theme"),
	require("external_plugins/terminal"),
	require("external_plugins/org"),
	require("external_plugins/notify"),
	require("external_plugins/trouble"),
	require("external_plugins/todo"),
	-- require("external_plugins/noice"),
	require("external_plugins/zenmode"),

	-- require("external_plugins/debug"),

	-----------------------------------------------------------------
	-----------------------------------------------------------------

	{
		"hoob3rt/lualine.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons", opt = true },
	},

	"terrortylor/nvim-comment",
	"machakann/vim-highlightedyank",

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
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
require("external_plugins/comment")
require("external_plugins/lualine")
