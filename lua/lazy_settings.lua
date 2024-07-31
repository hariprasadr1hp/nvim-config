local plugins = {
	-- themes
    -- {"hariprasadr1hp/onedark.nvim", branch="warmer"},
    "morhetz/gruvbox",
	"marko-cerovac/material.nvim",

	-- tabs(windows) in neovim
	{"romgrk/barbar.nvim", opt = true},

	-- lsp
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

	-- autocomplete
	"hrsh7th/nvim-cmp", -- Autocompletion plugin
	"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
	"saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
	"L3MON4D3/LuaSnip", -- Snippets plugin

	-- Snippets
	"rafamadriz/friendly-snippets",

	-- mini
	{ -- Collection of various small independent plugins/modules
		'echasnovski/mini.nvim',
		config = function()
		  -- Better Around/Inside textobjects
		  --
		  -- Examples:
		  --  - va)  - [V]isually select [A]round [)]paren
		  --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
		  --  - ci'  - [C]hange [I]nside [']quote
		  require('mini.ai').setup { n_lines = 500 }

		  -- Add/delete/replace surroundings (brackets, quotes, etc.)
		  --
		  -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		  -- - sd'   - [S]urround [D]elete [']quotes
		  -- - sr)'  - [S]urround [R]eplace [)] [']
		  require('mini.surround').setup()

		  -- Simple and easy statusline.
		  --  You could remove this setup call if you don't like it,
		  --  and try some other statusline plugin
		  local statusline = require 'mini.statusline'
		  -- set use_icons to true if you have a Nerd Font
		  statusline.setup { use_icons = vim.g.have_nerd_font }

		  -- You can configure sections in the statusline by overriding their
		  -- default behavior. For example, here we set the section for
		  -- cursor location to LINE:COLUMN
		  ---@diagnostic disable-next-line: duplicate-set-field
		  statusline.section_location = function()
			return '%2l:%-2v'
		  end

		  -- ... and there is more!
		  --  Check out: https://github.com/echasnovski/mini.nvim
		end,
	  },
	

	-- icons
    "kyazdani42/nvim-web-devicons",

	-- status line and bufferline
	{"hoob3rt/lualine.nvim",
		dependencies = {"kyazdani42/nvim-web-devicons", opt = true}
	},

	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
        run = function()
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
            ts_update()
        end,
    },
	"nvim-treesitter/playground",

	-- telescope
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

	-- autopairs
	"windwp/nvim-autopairs",

	-- git signs
	{
		"lewis6991/gitsigns.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim"
		},
		config = function()
			require('gitsigns').setup()
		end
	},

	-- highlighted-yank
	"machakann/vim-highlightedyank",

	-- explorer
	{
		"kyazdani42/nvim-tree.lua",
		version = "*",
		dependencies = {
		  "kyazdani42/nvim-web-devicons", -- optional, for file icon
		},
	},

	-- commenting code
	"terrortylor/nvim-comment",

	-- floating terminal
	"voldikss/vim-floaterm",
	{"akinsho/toggleterm.nvim", version = '*', config = true},

	-- debug
	"mfussenegger/nvim-dap",
	"mfussenegger/nvim-dap-python",

	-- hop
	{
		"phaazon/hop.nvim",
		as = "hop",
		config = function()
			require"hop".setup{}
		end
	},


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



local ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
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
require('external_plugins/autopairs')
require('external_plugins/comment')
require('external_plugins/completion')
require('external_plugins/debug')
require('external_plugins/devicons')
require('external_plugins/explorer')
require('external_plugins/floaterm')
require('external_plugins/git')
require('external_plugins/lsp')
require('external_plugins/lualine')
require('external_plugins/material')
require('external_plugins/telescope')
require('external_plugins/theme')
require('external_plugins/treesitter')
require('external_plugins/whichkey')
-- require('hp-onedark')
-- require('hp-utils')

