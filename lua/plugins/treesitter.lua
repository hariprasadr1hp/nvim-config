-- lua/plugins/treesitter.lua

local M = {}

local ensure_installed = {
	"arduino",
	"awk",
	"bash",
	"c",
	"cpp",
	"css",
	"csv",
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
}

local highlight = {
	enable = true,
	additional_vim_regex_highlighting = { "ruby" },
}

local indent = {
	enable = true,
	disable = { "ruby" },
}

local incremental_selection = {
	enable = true,
	keymaps = {
		init_selection = "<leader>lk",
		node_incremental = ".",
		node_decremental = ",",
		scope_incremental = "<c-space>",
	},
}

local setup_treesitter_config = function()
	return {
		ensure_installed = ensure_installed,
		sync_install = false,
		auto_install = true,
		ignore_install = { "org" },
		highlight = highlight,
		indent = indent,
		incremental_selection = incremental_selection,
	}
end

M = {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPre", "BufNewFile" },
		main = "nvim-treesitter.configs",
		opts = setup_treesitter_config(),
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
	},
}

return M

-- TODO: extend selection to neighbouring-node (prev/next)?
-- TODO: extend selection to [COUNT]neighbouring-node (prev/next)?
