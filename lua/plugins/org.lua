-- lua/plugins/org.lua

-- refer https://github.com/nvim-orgmode/orgmode/blob/master/DOCS.md

local M = {}

local function setup_orgmode_config()
	return {
		org_startup_folded = "showeverything", -- Options: "showeverything", "overview", "content"
		org_agenda_files = "~/my/org/agenda/**/*", -- Path to agenda files
		org_default_notes_file = "~/my/org/default.org", -- Default file for notes
	}
end

local function setup_orgmode()
	local org = require("orgmode")
	org.setup(setup_orgmode_config())
end

M = {
	"nvim-orgmode/orgmode",
	event = "VeryLazy",
	ft = { "org" },
	config = function()
		setup_orgmode()
	end,
}

return M
