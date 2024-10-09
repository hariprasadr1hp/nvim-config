-- lua/plugins/lsp.lua

local M = {}

local setup_lsp_servers = function(util)
	return {
		clangd = {},
		gopls = {},
		ts_ls = {},

		pyright = {
			cmd = { "pyright-langserver", "--stdio" },
			filetypes = { "python" },
			settings = {
				python = {
					analysis = {
						autoImportCompletions = true,
						autoSearchPaths = true,
						diagnosticMode = "workspace",
						useLibraryCodeForTypes = true,
						typeCheckingMode = "basic",
						logLevel = "Information",
					},
				},
			},
		},

		rust_analyzer = {
			cmd = { "rust-analyzer" },
			filetypes = { "rust" },
			root_dir = function(fname)
				local cargo_crate_dir = util.root_pattern("Cargo.toml")(fname)
				local cmd = "cargo metadata --no-deps --format-version 1"
				if cargo_crate_dir ~= nil then
					cmd = cmd .. " --manifest-path " .. util.path.join(cargo_crate_dir, "Cargo.toml")
				end
				local cargo_metadata = vim.fn.system(cmd)
				local cargo_workspace_dir = nil
				if vim.v.shell_error == 0 then
					cargo_workspace_dir = vim.fn.json_decode(cargo_metadata)["workspace_root"]
				end
				return cargo_workspace_dir
					or cargo_crate_dir
					or util.root_pattern("rust-project.json")(fname)
					or util.find_git_ancestor(fname)
			end,
			settings = {
				["rust-analyzer"] = {},
			},
		},

		lua_ls = {
			settings = {
				Lua = {
					completion = {
						callSnippet = "Replace",
					},
				},
			},
		},
	}
end

local function setup_lsp_mappings(event)
	local map = function(keys, func, desc, mode)
		mode = mode or "n"
		vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
	end

	map("gd", require("telescope.builtin").lsp_definitions, "definition")
	map("gr", require("telescope.builtin").lsp_references, "references")
	map("gI", require("telescope.builtin").lsp_implementations, "implementation")
	map("gD", vim.lsp.buf.declaration, "declaration")
	map("gA", vim.lsp.buf.code_action, "code-action")
	map("g.", vim.lsp.buf.code_action, "code-action")
end

local function setup_lsp_autocommands(event)
	local client = vim.lsp.get_client_by_id(event.data.client_id)
	if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
		local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			buffer = event.buf,
			group = highlight_augroup,
			callback = vim.lsp.buf.document_highlight,
		})

		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
			buffer = event.buf,
			group = highlight_augroup,
			callback = vim.lsp.buf.clear_references,
		})

		vim.api.nvim_create_autocmd("LspDetach", {
			group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
			callback = function(event2)
				vim.lsp.buf.clear_references()
				vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
			end,
		})
	end
end

local function setup_inlay_hints(event)
	local client = vim.lsp.get_client_by_id(event.data.client_id)
	if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
		vim.keymap.set("n", "<leader>lH", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
		end, { buffer = event.buf, desc = "[T]oggle Inlay [H]ints" })
	end
end

local function on_lsp_attach(event)
	setup_lsp_mappings(event)
	setup_lsp_autocommands(event)
	setup_inlay_hints(event)
end

local function setup_mason_and_tools()
	require("mason").setup({
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	})

	local util = require("lspconfig").util
	local lsp_servers = setup_lsp_servers(util)

	local ensure_installed = vim.tbl_keys(lsp_servers or {})
	vim.list_extend(ensure_installed, {
		"black", -- python formatter
		"isort", -- python formatter (sorting imports)
		"pylint", -- python linter
		"eslint_d", -- js/ts linter
		"prettier", -- js/ts formatter
		"stylua", -- lua formatter
	})

	require("mason-tool-installer").setup({
		ensure_installed = ensure_installed,
	})

	require("mason-lspconfig").setup({
		handlers = {
			function(server_name)
				local server = lsp_servers[server_name] or {}
				server.capabilities = vim.tbl_deep_extend(
					"force",
					{},
					require("cmp_nvim_lsp").default_capabilities(),
					server.capabilities or {}
				)
				require("lspconfig")[server_name].setup(server)
			end,
		},
	})
end

local lazydev_plugin = {
	"folke/lazydev.nvim",
	ft = "lua",
	opts = {
		library = {
			{ path = "luvit-meta/library", words = { "vim%.uv" } },
		},
	},
}

local luvit_meta_plugin = {
	"Bilal2453/luvit-meta",
	lazy = true,
}

local nvim_lspconfig_plugin = {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", config = true },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = on_lsp_attach,
		})

		setup_mason_and_tools()
	end,
}

M = {
	lazydev_plugin,
	luvit_meta_plugin,
	nvim_lspconfig_plugin,
}

return M
