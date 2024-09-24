-- lua/external_plugins/code_snap.lua

local M = {}

local setup_options = function()
	return {
		-- Optional: Uncomment if you want to set a custom save path
		-- save_path = "~/Pictures/nvim_snap/",
		has_breadcrumbs = true,
		breadcrumbs_separator = " 󰶻 ",
		-- Optional: Uncomment if you want to set a background theme
		-- bg_theme = "bamboo",
		bg_padding = 0,
		has_line_number = true,
		-- Optional: Uncomment if you want to set a watermark
		-- watermark = "hariprasadr1hp",
	}
end

M = {
	"mistricky/codesnap.nvim",
	build = "make",
	opts = setup_options(),
}

return M
