-- lua/external_plugins/treesitter.lua

local M = {}

local setup_ensure_installed = function()
	return {
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
	}
end

local setup_highlight = function()
	return {
		enable = true,
		additional_vim_regex_highlighting = { "ruby" },
	}
end

local setup_indent = function()
	return {
		enable = true,
		disable = { "ruby" },
	}
end

local setup_incremental_selection = function()
	return {
		enable = true,
		keymaps = {
			init_selection = "<space>lk",
			node_incremental = ".",
			node_decremental = ",",
			scope_incremental = "<c-space>",
		},
	}
end

local setup_treesitter_config = function()
	return {
		ensure_installed = setup_ensure_installed(),
		sync_install = false,
		auto_install = true,
		ignore_install = { "org" },
		highlight = setup_highlight(),
		indent = setup_indent(),
		incremental_selection = setup_incremental_selection(),
	}
end

M = {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	main = "nvim-treesitter.configs",
	opts = setup_treesitter_config(),
}

return M

-- TODO: extend selection to neighbouring-node (prev/next)?
-- TODO: extend selection to [COUNT]neighbouring-node (prev/next)?
