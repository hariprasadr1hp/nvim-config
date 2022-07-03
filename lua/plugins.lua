local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end


return require('packer').startup(
	function(use)
	-- Packer can manage itself
	use "wbthomason/packer.nvim"

	-- themes
    use {'hariprasadr1hp/onedark.nvim', branch='warmer'}
    use 'morhetz/gruvbox'
	use 'marko-cerovac/material.nvim'

	-- tabs(windows) in neovim
	use {"romgrk/barbar.nvim", opt = true}

	-- lsp
	use {
		"williamboman/nvim-lsp-installer",
		{
			"neovim/nvim-lspconfig",
			config = function()
				require("nvim-lsp-installer").setup {}
				local lspconfig = require("lspconfig")
				lspconfig.sumneko_lua.setup {}
			end
		}
	}

	use "nvim-lua/lsp-status.nvim"

	-- autocomplete
	use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
	use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
	use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
	use 'L3MON4D3/LuaSnip' -- Snippets plugin

	-- Snippets
	use "rafamadriz/friendly-snippets"

	-- icons
    use 'kyazdani42/nvim-web-devicons'

	-- status line and bufferline
	use {'hoob3rt/lualine.nvim',
		requires = {'kyazdani42/nvim-web-devicons', opt = true}
	}

	-- treesitter
	use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
	use {"windwp/nvim-ts-autotag", opt = true}
	use 'nvim-treesitter/playground'

	-- telescope
	use {
		'nvim-telescope/telescope.nvim',
		requires = {
			{'nvim-lua/popup.nvim'},
			{'nvim-lua/plenary.nvim'}
		}
	}
	use 'nvim-telescope/telescope-media-files.nvim'

	-- autopairs
	use "windwp/nvim-autopairs"

	-- git signs
	use {
		'lewis6991/gitsigns.nvim',
		requires = {
			'nvim-lua/plenary.nvim'
		},
		config = function()
		require('gitsigns').setup()
	  end
	}

	-- highlighted-yank
	use 'machakann/vim-highlightedyank'

	-- explorer
	use {
		'kyazdani42/nvim-tree.lua',
		requires = {
		  'kyazdani42/nvim-web-devicons', -- optional, for file icon
		},
		tag = 'nightly' -- optional, updated every week. (see issue #1193)
	}

	-- commenting code
	use 'terrortylor/nvim-comment'

	-- floating terminal
	use 'voldikss/vim-floaterm'
	use {"akinsho/toggleterm.nvim", tag = 'v1.*', config = function()
	  require("toggleterm").setup()
	end}

	-- debug
	use 'mfussenegger/nvim-dap'
	use 'mfussenegger/nvim-dap-python'

	-- hop
	use {
		'phaazon/hop.nvim',
		as = 'hop',
		config = function()
			require'hop'.setup{}
		end
	}

	-- which-key
	use 'folke/which-key.nvim'
	-- use 'liuchengxu/vim-which-key'

	if packer_bootstrap then
		require('packer').sync()
	end

end)
