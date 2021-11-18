local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'


if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
end

--- Check if a file or directory exists in this path
local function require_plugin(plugin)
    local plugin_prefix = fn.stdpath("data") .. "/site/pack/packer/opt/"

    local plugin_path = plugin_prefix .. plugin .. "/"
    --	print('test '..plugin_path)
    local ok, err, code = os.rename(plugin_path, plugin_path)
    if not ok then
        if code == 13 then
            -- Permission denied, but it exists
            return true
        end
    end
    --	print(ok, err, code)
    if ok then
        vim.cmd("packadd " .. plugin)
    end
    return ok, err, code
end

vim.cmd "autocmd BufWritePost plugins.lua PackerCompile" -- Auto compile when there are changes in plugins.lua


return require('packer').startup(
	function()
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
	use "nvim-lua/completion-nvim"
	use "nvim-lua/lsp-status.nvim"
	-- use 'onsails/lspkind-nvim'
	-- use 'kosayoda/nvim-lightbulb'
	-- use 'mfussenegger/nvim-jdtls'

	-- Autocomplete
	-- use {"hrsh7th/nvim-compe", opt = true, event="InsertEnter", }
	use "hrsh7th/vim-vsnip"
	use "hrsh7th/vim-vsnip-integ"
	-- use "rafamadriz/friendly-snippets"
	-- use 'mattn/emmet-vim'

	-- Treesitter
	use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
	use {"windwp/nvim-ts-autotag", opt = true}
	-- use 'nvim-treesitter/nvim-treesitter-refactor'
	use 'nvim-treesitter/playground'
	-- use 'p00f/nvim-ts-rainbow'
	-- use {'lukas-reineke/indent-blankline.nvim', branch = 'lua'}

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

	-- floating terminal
	use 'voldikss/vim-floaterm'

    -- -- Text Navigation
	-- use 'unblevable/quick-scope'

    -- -- zen mode
    -- use 'junegunn/goyo.vim'

    -- -- Interactive code
    -- use 'metakirby5/codi.vim'

end)
