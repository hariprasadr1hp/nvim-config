-- lua/external_plugins/treesitter.lua

return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",

		-- Sets main module to use for opts
		main = "nvim-treesitter.configs",

		-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
		opts = {
			ensure_installed = {
				"arduino",
				"awk",
				"bash",
				"c",
				"cpp",
				"css",
				"diff",
				"dockerfile",
				"gitignore",
				"graphql",
				"haskell",
				"html",
				"javascript",
				"json",
				"kdl",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"org",
				"python",
				"query",
				"regex",
				"rust",
				"sql",
				"terraform",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			},

			sync_install = false,
			auto_install = true,
			-- ignore_install = {},

			highlight = {
				enable = true,
				additional_vim_regex_highlighting = { "ruby" },
			},

			indent = {
				enable = true,
				disable = { "ruby" },
			},

			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<c-space>",
					node_incremental = "<c-space>",
					-- scope_incremental = "<c-s>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		},
	},

	"nvim-treesitter/playground",
}
