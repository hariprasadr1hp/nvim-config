-- lua/plugins/debug.lua

local M = {}

local function setup_mason_dap()
	require("mason-nvim-dap").setup({
		automatic_installation = true,
		handlers = {}, -- Add specific handlers if needed
		ensure_installed = {
			"delve", -- Golang debugger, add other debuggers here
		},
	})
end

local setup_dap_ui = function(dap, dapui)
	dapui.setup({
		icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
		controls = {
			icons = {
				pause = "⏸",
				play = "▶",
				step_into = "⏎",
				step_over = "⏭",
				step_out = "⏮",
				step_back = "b",
				run_last = "▶▶",
				terminate = "⏹",
				disconnect = "⏏",
			},
		},
	})
end

local setup_dap_event_listeners = function(dap, dapui)
	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close()
	end
end

local function setup_dap_go()
	require("dap-go").setup({
		delve = {
			detached = vim.fn.has("win32") == 0, -- Delve setup for Windows
		},
	})
end

local function setup_dap()
	local dap = require("dap")
	local dapui = require("dapui")

	-- Setup Mason integration with nvim-dap
	setup_mason_dap()

	-- Setup Dap UI
	setup_dap_ui(dap, dapui)

	-- Setup Dap Go for Golang-specific debugging
	setup_dap_go()

	-- Set up event listeners for Dap UI
	setup_dap_event_listeners(dap, dapui)

	-- Read config from `launch.json`, if available
	require("dap.ext.vscode").load_launchjs(nil, {})
end

local setup_keys = function(_, keys)
	local dap = require("dap")
	local dapui = require("dapui")

	local mappings = {
		{ "<F1>", dap.step_into, desc = "Debug: Step Into" },
		{ "<F2>", dap.step_over, desc = "Debug: Step Over" },
		{ "<F3>", dap.step_out, desc = "Debug: Step Out" },
		{ "<F5>", dap.continue, desc = "Debug: Start/Continue" },
		{ "<F7>", dapui.toggle, desc = "Debug: See last session result." },
	}

	-- Merge custom keys with default keys
	return vim.list_extend(mappings, keys)
end

M = {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
		"leoluz/nvim-dap-go",
	},
	config = setup_dap,
	keys = setup_keys,
}

vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })

return M
