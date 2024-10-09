-- lua/plugins/testing.lua

local M = {}

local setup_rust_adapter = function()
	return require("neotest-rust")({
		args = { "--no-capture" },
		dap_adapter = "lldb",
	})
end

local setup_python_adapter = function()
	return require("neotest-python")({
		-- Extra arguments for nvim-dap configuration
		-- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
		dap = { justMyCode = false },

		-- Command line arguments for runner
		-- Can also be a function to return dynamic values
		args = { "--log-level", "DEBUG" },

		-- Runner to use. Will use pytest if available by default.
		-- Can be a function to return dynamic value.
		runner = "pytest",

		-- Custom python path for the runner.
		-- Can be a string or a list of strings.
		-- Can also be a function to return dynamic value.
		-- If not provided, the path will be inferred by checking for
		-- virtual envs in the local directory and for Pipenev/Poetry configs
		-- python = ".venv/bin/python",

		-- Returns if a given file path is a test file.
		-- NB: This function is called a lot so don't perform any heavy tasks within it.
		---@diagnostic disable-next-line: unused-local
		-- is_test_file = function(file_path)
		-- ...
		-- end,
		-- !!EXPERIMENTAL!! Enable shelling out to `pytest` to discover test
		-- instances for files containing a parametrize mark (default: false)
		pytest_discover_instances = true,
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
