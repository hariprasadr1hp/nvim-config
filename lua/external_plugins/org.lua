-- lua/external_plugins/org.lua

-- refer https://github.com/nvim-orgmode/orgmode/blob/master/DOCS.md

return {
	{
		"nvim-orgmode/orgmode",
		event = "VeryLazy",
		ft = { "org" },
		config = function()
			local org = require("orgmode")

			org.setup_ts_grammar()
			org.setup({
				---@type "showeverything" | "overview" | "content"
				org_startup_folded = "showeverything",
				org_agenda_files = "~/my/org/agenda/**/*",
				org_default_notes_file = "~/my/org/default.org",
			})
		end,
	},
}
