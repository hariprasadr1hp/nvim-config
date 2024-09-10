local plugins = {

    -----------------------------------------------------------------
    -- THEMES -------------------------------------------------------
    -----------------------------------------------------------------

    "morhetz/gruvbox",

    -----------------------------------------------------------------
    -- LSP ----------------------------------------------------------
    -----------------------------------------------------------------

	{
		"williamboman/nvim-lsp-installer",
		{
			"neovim/nvim-lspconfig",
			config = function()
				require("nvim-lsp-installer").setup {}
				local lspconfig = require("lspconfig")
			end
		}
	},

	"nvim-lua/lsp-status.nvim",

    -----------------------------------------------------------------
    -- COMPLETION ---------------------------------------------------
    -----------------------------------------------------------------

	"hrsh7th/nvim-cmp", -- Autocompletion plugin
	"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
	"saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
	"L3MON4D3/LuaSnip", -- Snippets plugin

    -----------------------------------------------------------------
    -- LANGUAGES ----------------------------------------------------
    -----------------------------------------------------------------

    -- SQL ----------------------------------------------------------

	{
		'kristijanhusak/vim-dadbod-ui',
		dependencies = {
			{ 'tpope/vim-dadbod', lazy = true },
			{ 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
		},
		cmd = {
			'DBUI',
			'DBUIToggle',
			'DBUIAddConnection',
			'DBUIFindBuffer',
		},
		init = function()
			vim.g.db_ui_use_nerd_fonts = 1
		end,
	},

    -----------------------------------------------------------------
    -- NOTES --------------------------------------------------------
    -----------------------------------------------------------------

    -- ORG MODE -----------------------------------------------------

	{
		'nvim-orgmode/orgmode',
		event = 'VeryLazy',
		ft = { 'org' },
		config = function()
			require('orgmode').setup({
				org_agenda_files = '~/my/org/agenda/**/*',
				org_default_notes_file = '~/my/org/default.org',
			})
		end,
	},

    -----------------------------------------------------------------
    -- SNIPPETS -----------------------------------------------------
    -----------------------------------------------------------------

	"rafamadriz/friendly-snippets",

    -----------------------------------------------------------------
    -- MISC ---------------------------------------------------------
    -----------------------------------------------------------------

	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.ai").setup { n_lines = 500 }
			require("mini.surround").setup()
			local statusline = require "mini.statusline"
			statusline.setup { use_icons = vim.g.have_nerd_font }
			statusline.section_location = function()
				return "%2l:%-2v"
			end
		end,
	},
	
    -----------------------------------------------------------------
    -- GUI ----------------------------------------------------------
    -----------------------------------------------------------------

    "kyazdani42/nvim-web-devicons",

	-- {"romgrk/barbar.nvim", opt = true}, -- tabs(windows) in neovim
	
	{
		"hoob3rt/lualine.nvim",
		dependencies = {"kyazdani42/nvim-web-devicons", opt = true}
	},

	"windwp/nvim-autopairs",

	"machakann/vim-highlightedyank",


	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				background_colour = "#000000",
				enabled = false,
			})
		end
	},

    -----------------------------------------------------------------
    -- GIT ----------------------------------------------------------
    -----------------------------------------------------------------

	{
		"lewis6991/gitsigns.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim"
		},
		config = function()
			require('gitsigns').setup()
		end
	},

    -----------------------------------------------------------------
    -- TREESITTER ---------------------------------------------------
    -----------------------------------------------------------------

	{
		"nvim-treesitter/nvim-treesitter",
        run = function()
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
            ts_update()
        end,
    },

	"nvim-treesitter/playground",

    -----------------------------------------------------------------
    -- TELESCOPE ----------------------------------------------------
    -----------------------------------------------------------------

	{
		"nvim-telescope/telescope.nvim",
		tag="0.1.8",
		dependencies = {
			{"nvim-lua/popup.nvim"},
			{"nvim-lua/plenary.nvim"},
			{"nvim-telescope/telescope-fzf-native.nvim"},
		}
	},
	
	"nvim-telescope/telescope-media-files.nvim",


    -----------------------------------------------------------------
    -- EXPLORER -----------------------------------------------------
    -----------------------------------------------------------------

	{
		"kyazdani42/nvim-tree.lua",
		version = "*",
		dependencies = {
		  "kyazdani42/nvim-web-devicons", -- optional, for file icon
		},
	},

	"terrortylor/nvim-comment",

    -----------------------------------------------------------------
    -- TERMINAL -----------------------------------------------------
    -----------------------------------------------------------------

	"voldikss/vim-floaterm",
	{"akinsho/toggleterm.nvim", version = '*', config = true},

    -----------------------------------------------------------------
    -- DEBUGGING ----------------------------------------------------
    -----------------------------------------------------------------

	"mfussenegger/nvim-dap",
	"mfussenegger/nvim-dap-python",

	{
		"phaazon/hop.nvim",
		as = "hop",
		config = function()
			require"hop".setup{}
		end
	},

    -----------------------------------------------------------------
    -- KEYMAPS ------------------------------------------------------
    -----------------------------------------------------------------

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
}


-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------


local ui = {
	-- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
		cmd		= '⌘',
		config	= '🛠',
		event	= '📅',
		ft		= '📂',
		init	= '⚙',
		keys	= '🗝',
		plugin	= '🔌',
		runtime = '💻',
		require = '🌙',
		source	= '📄',
		start	= '🚀',
		task	= '📌',
		lazy	= '💤 ',
    },
}


local opts = {
	ui = ui
}


require("lazy").setup(
	plugins,
	opts
)


-- lua plugin settings
require("external_plugins/autopairs")
require("external_plugins/comment")
require("external_plugins/completion")
require("external_plugins/debug")
require("external_plugins/devicons")
require("external_plugins/explorer")
require("external_plugins/floaterm")
require("external_plugins/git")
require("external_plugins/lsp")
require("external_plugins/lualine")
require("external_plugins/telescope")
require("external_plugins/theme")
require("external_plugins/treesitter")
require("external_plugins/whichkey")
-- require("hp-plugins/word_count")

