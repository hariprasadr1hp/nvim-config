-- lua/plugins/headlines.lua

-- TODO: enable only for org mode
-- TODO: disable line-highlighting for headlines

local M = {}

local setup_org_query = function()
	return vim.treesitter.query.parse(
		"org",
		[[
			(headline (stars) @headline)

			(
				(expr) @dash
				(#match? @dash "^-----+$")
			)

			(block
				name: (expr) @_name
				(#match? @_name "(SRC|src)")
			) @codeblock

			(paragraph . (expr) @quote
				(#eq? @quote ">")
			)
		]]
	)
end

local setup_bullet_highlights = function()
	return {
		"@org.headline.level1",
		"@org.headline.level2",
		"@org.headline.level3",
		"@org.headline.level4",
		"@org.headline.level5",
		"@org.headline.level6",
		"@org.headline.level7",
		"@org.headline.level8",
	}
end

local setup_org_config = function()
	return {
		query = setup_org_query(),
		headline_highlights = { "Headline" },
		bullet_highlights = setup_bullet_highlights(),
		bullets = { "◉", "○", "✸", "✿" },
		codeblock_highlight = "CodeBlock",
		dash_highlight = "Dash",
		dash_string = "-",
		quote_highlight = "Quote",
		quote_string = "┃",
		fat_headlines = true,
		fat_headline_upper_string = "▄",
		fat_headline_lower_string = "▀",
	}
end

local setup_headlines = function()
	require("headlines").setup({
		org = setup_org_config(),
	})
end

M = {
	"lukas-reineke/headlines.nvim",
	dependencies = "nvim-treesitter/nvim-treesitter",
	config = function()
		setup_headlines()
	end,
}

return M
