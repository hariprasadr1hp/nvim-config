-- lua/external_plugins/treesitter.lua

return {
	{
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",

		-- Sets main module to use for opts
		main = "nvim-treesitter.configs",

		-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"css",
				"diff",
				"dockerfile",
				"gitignore",
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

			-- Autoinstall languages that are not installed
			auto_install = true,

			highlight = {
				enable = true,
				-- Some languages depend on vim"s regex highlighting system (such as Ruby) for indent rules.
				--  If you are experiencing weird indenting issues, add the language to
				--  the list of additional_vim_regex_highlighting and disabled languages for indent.
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
