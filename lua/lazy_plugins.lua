-- lua/lazy_plugins.lua

local plugins = {

    -----------------------------------------------------------------
    -- THEMES -------------------------------------------------------
    -----------------------------------------------------------------

    "morhetz/gruvbox",
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },

    -----------------------------------------------------------------
    -- LSP ----------------------------------------------------------
    -----------------------------------------------------------------

    {
		'neovim/nvim-lspconfig',
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',

			'j-hui/fidget.nvim', -- Useful status updates for LSP 
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
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{
				"kristijanhusak/vim-dadbod-completion",
				ft = {
					"sql", "mysql", "plsql",
				},
				lazy = true
			},
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
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

	"terrortylor/nvim-comment",

	"machakann/vim-highlightedyank",

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {},
	},

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

		-- config = function()
		-- 	require('gitsigns').setup()
		-- end
	},

    -----------------------------------------------------------------
    -- TREESITTER ---------------------------------------------------
    -----------------------------------------------------------------

	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			pcall(require('nvim-treesitter.install').update { with_sync = true })
		end,

		run = function()
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
            ts_update()
        end,

		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
		},
    },

	"nvim-treesitter/playground",

    -----------------------------------------------------------------
    -- TELESCOPE ----------------------------------------------------
    -----------------------------------------------------------------

	{
		"nvim-telescope/telescope.nvim",
		-- tag="0.1.8",
		branch="0.1.x",
		dependencies = {
			{"nvim-lua/popup.nvim"},
			{"nvim-lua/plenary.nvim"},
		}
	},

	'nvim-telescope/telescope-symbols.nvim',
	"nvim-telescope/telescope-media-files.nvim",

	{
		'nvim-telescope/telescope-fzf-native.nvim',
		build = 'make',
		cond = vim.fn.executable 'make' == 1
	},

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


require("external_plugins/theme")
require("external_plugins/treesitter")
require("external_plugins/lsp")
require("external_plugins/completion")
require("external_plugins/comment")
require("external_plugins/autopairs")
require("external_plugins/devicons")
require("external_plugins/telescope")
require("external_plugins/explorer")
require("external_plugins/git")
require("external_plugins/floaterm")
require("external_plugins/debug")
require("external_plugins/theme")
require("external_plugins/lualine")
require("external_plugins/whichkey")


