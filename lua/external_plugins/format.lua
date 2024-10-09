-- lua/external_plugins/format.lua

local M = {}

local function format_on_save(bufnr)
	local disable_filetypes = {
		c = true,
		cpp = true,
	}

	local lsp_format_opt = disable_filetypes[vim.bo[bufnr].filetype] and "never" or "fallback"

	return {
		timeout_ms = 500,
		lsp_format = lsp_format_opt,
	}
end

local formatters_by_ft = {
	lua = { "stylua" },
	-- Can run multiple formatters sequentially
	python = { "isort", "black" },
	-- Customize format options
	rust = { "rustfmt", lsp_format = "fallback" },
	-- First available formatter
	javascript = { "prettierd", "prettier", stop_after_first = true },
	json = { "prettierd", "prettier", stop_after_first = true },
}

local opts = {
	notify_on_error = false,
	format_on_save = format_on_save,
	formatters_by_ft = formatters_by_ft,
}

M = {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = opts,
	},
}

vim.api.nvim_create_user_command("Format", function(args)
	local range = nil
	if args.count ~= -1 then
		local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
		range = {
			start = { args.line1, 0 },
			["end"] = { args.line2, end_line:len() },
		}
	end
	require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true })

return M

-- TODO: an option to save file without applying code-formatting
