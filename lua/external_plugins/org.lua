-- lua/external_plugins/org.lua

return {
	{
		"nvim-orgmode/orgmode",
		event = "VeryLazy",
		ft = { "org" },
		config = function()
			require("orgmode").setup({
				org_agenda_files = "~/my/org/agenda/**/*",
				org_default_notes_file = "~/my/org/default.org",
			})
		end,
	},
}
