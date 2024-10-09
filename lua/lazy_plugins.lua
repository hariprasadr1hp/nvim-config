-- lua/lazy_plugins.lua

local plugins = {
	require("plugins/themes/catppuccin"),
	require("plugins/themes/cyberdream"),
	require("plugins/themes/nordic"),
	require("plugins/themes/tokyonight"),

	require("plugins/icons"),
	require("plugins/rocks"),
	require("plugins/autopairs"),
	require("plugins/comment"),
	require("plugins/text_objects"),
	require("plugins/treesitter"),
	require("plugins/telescope"),
	require("plugins/gitsigns"),
	require("plugins/neogit"),
	require("plugins/lsp"),
	require("plugins/codeium"),
	require("plugins/gen"),
	require("plugins/neorg"),
	require("plugins/org"),
	require("plugins/completion"),
	require("plugins/lint"),
	require("plugins/format"),
	require("plugins/terminal"),
	require("plugins/explorer"),
	require("plugins/mini"),
	-- require("plugins/notify"),
	require("plugins/lualine"),
	require("plugins/undo_tree"),
	require("plugins/harpoon"),
	require("plugins/todo_comments"),
	require("plugins/testing"),
	require("plugins/trouble"),
	require("plugins/cloak"),
	require("plugins/repl"),
	require("plugins/zenmode"),
	require("plugins/snapshot"),
	require("plugins/misc"),
	require("plugins/multicursors"),

	-- require("plugins/oil"),
	-- require("plugins/debug"),
	-- require("plugins/headlines"),

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

require("plugins/whichkey")

-- TODO: creating language/extension-specific functionalities
