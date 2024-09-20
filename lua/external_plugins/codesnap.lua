-- lua/external_plugins/code_snap.lua

return {
	{
		"mistricky/codesnap.nvim",
		build = "make",
		opts = {
			-- save_path = "~/Pictures/nvim_snap/",
			has_breadcrumbs = true,
			breadcrumbs_separator = " 󰶻 ",
			-- bg_theme = "bamboo",
			bg_padding = 0,
			has_line_number = true,
			-- watermark = "hariprasadr1hp",
		},
	},
}
