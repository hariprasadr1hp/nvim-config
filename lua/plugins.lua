local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end


return require('packer').startup(
	function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	-- Themes
    use {'hariprasadr1hp/onedark.nvim', branch='warmer'}
    use 'morhetz/gruvbox'
	use 'marko-cerovac/material.nvim'

	-- Status Line and Bufferline
	use {'hoob3rt/lualine.nvim',
		requires = {'kyazdani42/nvim-web-devicons', opt = true}
	}
	use {"romgrk/barbar.nvim", opt = true}

	-- lsp
	use "neovim/nvim-lspconfig"
	use "glepnir/lspsaga.nvim"
	use "kabouzeid/nvim-lspinstall"
	use "nvim-lua/lsp-status.nvim"
	-- use 'onsails/lspkind-nvim'
	-- use 'kosayoda/nvim-lightbulb'
	-- use 'mfussenegger/nvim-jdtls'

	-- Autocomplete
	use {"hrsh7th/nvim-compe", opt = true, event="InsertEnter", }
	use "hrsh7th/vim-vsnip"
	use "hrsh7th/vim-vsnip-integ"
	-- use "rafamadriz/friendly-snippets"
	-- use 'mattn/emmet-vim'

	-- Treesitter
	-- treesitter
	use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
	use {"windwp/nvim-ts-autotag", opt = true}
	use 'nvim-treesitter/playground'

	-- Telescope
	use {
		'nvim-telescope/telescope.nvim',
		requires = {
			{'nvim-lua/popup.nvim'},
			{'nvim-lua/plenary.nvim'}
		}
	}
	use 'nvim-telescope/telescope-media-files.nvim'

	-- Autopairs
	use "windwp/nvim-autopairs"

	-- git gigns
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

	-- Registers
	-- use 'gennaro-tedesco/nvim-peekup'

	-- Navigation
	-- use 'phaazon/hop.nvim'

	-- Icons
    use 'kyazdani42/nvim-web-devicons'
    -- use 'ryanoasis/vim-devicons'

	-- Explorer
	--use 'kyazdani42/nvim-tree.lua'

	-- Commenting code
	use 'terrortylor/nvim-comment'

	-- floating terminal
	use 'voldikss/vim-floaterm'
	use 'akinsho/toggleterm.nvim'

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

    -- -- Text Navigation
	-- use 'unblevable/quick-scope'

    -- -- zen mode
    -- use 'junegunn/goyo.vim'

    -- -- Interactive code
    -- use 'metakirby5/codi.vim'
	if packer_bootstrap then
		require('packer').sync()
	end

end)
