-- lua/plugins/completion.lua

local M = {}

local function setup_dependencies()
	return {
		{
			"L3MON4D3/LuaSnip",
			build = (function()
				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
					return
				end
				return "make install_jsregexp"
			end)(),
			dependencies = {
				{
					"rafamadriz/friendly-snippets",
					config = function()
						require("luasnip.loaders.from_vscode").lazy_load()
						require("luasnip.loaders.from_vscode").lazy_load({
							paths = { "./snippets" },
						})
					end,
				},
			},
		},
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
	}
end

local setup_snippet = function(luasnip)
	return {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	}
end

local setup_mappings = function(cmp, luasnip)
	return cmp.mapping.preset.insert({
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<Tab>"] = cmp.mapping.confirm({ select = true }),
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete({}),
		["<C-l>"] = cmp.mapping(function()
			if luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			end
		end, { "i", "s" }),
		["<C-h>"] = cmp.mapping(function()
			if luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			end
		end, { "i", "s" }),
	})
end

local function setup_sources()
	return {
		{ name = "lazydev", group_index = 0 },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "path" },
		{ name = "orgmode" },
		{ name = "neorg" },
	}
end

local function setup_formatting()
	return {
		format = require("lspkind").cmp_format({
			mode = "symbol",
			maxwidth = 50,
			ellipsis_char = "...",
			-- symbol_map = { Codeium = "" },
		}),
	}
end

local function setup_cmp()
	local cmp = require("cmp")
	local luasnip = require("luasnip")
	luasnip.config.setup({})

	cmp.setup({
		snippet = setup_snippet(luasnip),
		completion = { completeopt = "menu,menuone,noinsert" },
		mapping = setup_mappings(cmp, luasnip),
		sources = setup_sources(),
		-- formatting = setup_formatting(),
	})
end

M = {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = setup_dependencies(),
	config = function()
		setup_cmp()
	end,
}

return M
