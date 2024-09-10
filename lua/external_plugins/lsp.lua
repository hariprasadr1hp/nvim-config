-- lua/hp-lsp/init.lua

------------------------------------------------------------------------
-- lsp-installer
------------------------------------------------------------------------

require("nvim-lsp-installer").setup({
    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        },
		keymaps = {
			-- Keymap to expand a server in the UI
			toggle_server_expand = "<CR>",

			-- Keymap to install the server under the current cursor position
			install_server = "i",

			-- Keymap to reinstall/update the server under the current cursor position
			update_server = "u",

			-- Keymap to check for new version for the server under the current cursor position
			check_server_version = "c",

			-- Keymap to update all installed servers
			update_all_servers = "U",

			-- Keymap to check which installed servers are outdated
			check_outdated_servers = "C",

			-- Keymap to uninstall a server
			uninstall_server = "X",
		},
    },
})

------------------------------------------------------------------------
-- lsp-setup
------------------------------------------------------------------------

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  -- vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  -- vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  -- vim.keymap.set("n", "<space>wl", function()
  --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, bufopts)
end


-- Use a loop to conveniently call "setup" on multiple servers and
-- map buffer local keybindings when the language server attaches

---------------------------------------------------------
-- servers with minimal setup
---------------------------------------------------------
local servers = {
	"awk_ls",
	"bashls",
	"beancount",
	-- "ccls",
	"clangd",
	"cmake",
	"cssmodules_ls",
	-- "dartls",
	"dockerls",
	"dotls",
	"emmet_ls",
	"eslint",
	-- "hls",
	"julials",
	"ltex",
	"pyright",
	"rust_analyzer",
	-- "solang",
	"sqlls",
	"texlab",
	"ts_ls",
	"vimls",
	"yamlls",
}

for _, lsp in pairs(servers) do
  require("lspconfig")[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

---------------------------------------------------------
-- css
---------------------------------------------------------

require"lspconfig".cssls.setup {
  capabilities = capabilities,
}

---------------------------------------------------------
-- html
---------------------------------------------------------

require"lspconfig".html.setup {
  capabilities = capabilities,
}

---------------------------------------------------------
-- json
---------------------------------------------------------

require"lspconfig".jsonls.setup {
  capabilities = capabilities,
}

---------------------------------------------------------
-- python
---------------------------------------------------------

require("lspconfig").pyright.setup {
	settings = {
		pyright = {
		-- Using Ruff"s import organizer
		disableOrganizeImports = true,
		},
    
		python = {
			analysis = {
				-- Ignore all files for analysis to exclusively use Ruff for linting
				ignore = { "*" },
			},
		},
	},
}

require("lspconfig").ruff.setup {
	trace = "messages",
	init_options = {
		settings = {
			logLevel = "debug",
		},
	},
}

---------------------------------------------------------
---------------------------------------------------------
---------------------------------------------------------
