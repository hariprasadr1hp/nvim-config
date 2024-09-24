-- lua/external_plugins/testing.lua

local M = {}

local setup_rust_adapter = function()
	return require("neotest-rust")({
		args = { "--no-capture" },
	})
end

local setup_python_adapter = function()
	return require("neotest-python")({
		runner = "pytest", -- Using pytest as the test runner
		-- Uncomment and modify the below configurations if needed
		-- python = ".venv/bin/python", -- Custom Python path for the runner
		-- args = { "--log-level", "DEBUG" }, -- Command line arguments for the runner
		-- dap = { justMyCode = false }, -- Extra arguments for nvim-dap configuration
		-- is_test_file = function(file_path) end, -- Define logic for identifying test files
		-- pytest_discover_instances = true, -- Discover test instances in parametrized files
	})
end

local setup_bash_adapter = function()
	return require("neotest-bash")
end

local setup_haskell_adapter = function()
	return require("neotest-haskell")
end

local setup_neotest = function()
	---@diagnostic disable-next-line: missing-fields
	require("neotest").setup({
		adapters = {
			setup_rust_adapter(),
			setup_python_adapter(),
			setup_bash_adapter(),
			setup_haskell_adapter(),
			require("neotest-plenary"),
		},
	})
end

M = {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"marilari88/neotest-vitest",
		"nvim-neotest/neotest-plenary",
		"nvim-neotest/nvim-nio",
		"rouge8/neotest-rust",
		"nvim-neotest/neotest-python",
		"rcasia/neotest-bash",
		"mrcjkb/neotest-haskell",
	},
	config = function()
		setup_neotest()
	end,
}

return M
