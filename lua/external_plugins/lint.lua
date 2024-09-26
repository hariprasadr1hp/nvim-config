-- lua/external_plugins/lint.lua

local M = {}

local disable_default_linters = function()
	local lint = require("lint")
	lint.linters_by_ft["clojure"] = nil
	lint.linters_by_ft["dockerfile"] = nil
	lint.linters_by_ft["inko"] = nil
	lint.linters_by_ft["janet"] = nil
	lint.linters_by_ft["json"] = nil
	lint.linters_by_ft["markdown"] = nil
	lint.linters_by_ft["rst"] = nil
	lint.linters_by_ft["ruby"] = nil
	lint.linters_by_ft["terraform"] = nil
	lint.linters_by_ft["text"] = nil
end

local linters_by_ft = {
	javascript = { "eslint_d" },
	javascriptreact = { "eslint_d" },
	markdown = { "markdownlint" },
	python = { "pylint" },
	svelte = { "eslint_d" },
	terraform = { "tflint" },
	typescript = { "eslint_d" },
	typescriptreact = { "eslint_d" },
}

local setup_lint = function()
	local lint = require("lint")
	lint.linters_by_ft = linters_by_ft
	disable_default_linters()
end

local setup_autocmd = function()
	local lint = require("lint")
	local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

	vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
		group = lint_augroup,
		callback = function()
			lint.try_lint()
		end,
	})
end

M = {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		setup_lint()
		setup_autocmd()
	end,
}

return M
