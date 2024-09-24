-- lua/external_plugins/notify.lua

local M = {}

local setup_lsp = function()
	return {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
		},
	}
end

local setup_presets = function()
	return {
		bottom_search = false, -- use a classic bottom cmdline for search
		command_palette = false, -- position the cmdline and popupmenu together
		long_message_to_split = false, -- long messages will be sent to a split
		inc_rename = true, -- enables input dialog for inc-rename.nvim
		lsp_doc_border = true, -- add a border to hover docs and signature help
	}
end

local setup_views = function()
	return {
		cmdline_popup = {
			position = {
				row = 15,
				col = "50%",
			},
			size = {
				width = 100,
				height = "auto",
			},
		},
		popupmenu = {
			relative = "editor",
			position = {
				row = 18,
				col = "50%",
			},
			size = {
				width = 100,
				height = 10,
			},
			border = {
				style = "rounded",
				padding = { 0, 1 },
			},
			win_options = {
				winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
			},
		},
	}
end

local setup_cmdline = function()
	return {
		enabled = true,
		view = "cmdline_popup",
		opts = {},
		format = {
			cmdline = { pattern = "^:", icon = "", lang = "vim" },
			search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
			search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
			filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
			python = { pattern = "^:%s*py3? ", icon = "", lang = "python" },
			read_input = { pattern = "^:r ", icon = "", lang = "vim" },
			lua = {
				pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" },
				icon = "",
				lang = "lua",
			},
			help = { pattern = "^:%s*he?l?p?%s+", icon = "󰋖" },
			input = { view = "cmdline_input", icon = "󰥻 " },
		},
	}
end

local setup_routes = function()
	--TODO: reduce notification noise
	return {
		{
			view = "notify",
			filter = { event = "msg_showmode" },
		},
		-- Hide "written" messages
		{
			filter = {
				event = "msg_show",
				kind = "",
				find = "written",
			},
			opts = { skip = true },
		},
	}
end

local setup_noice = function()
	require("noice").setup({
		lsp = setup_lsp(), -- LSP integration and markdown overrides
		presets = setup_presets(), -- Noice presets
		views = setup_views(), -- UI views for cmdline, popup menu
		cmdline = setup_cmdline(), -- Cmdline configuration
		routes = setup_routes(), -- Noice message routing
	})
	-- Add telescope integration with Noice
	require("telescope").load_extension("noice")
end

M = {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {},
	dependencies = {
		"MunifTanjim/nui.nvim",
		-- "rcarriga/nvim-notify", -- Optional: for notification view
	},
	config = function()
		setup_noice()
	end,
}

return M
