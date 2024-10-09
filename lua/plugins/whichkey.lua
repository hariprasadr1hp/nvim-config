-- lua/plugins/whichkey.lua

local telescope_builtins = require("telescope.builtin")
local conform = require("conform")
local harpoon_list = require("harpoon"):list()

local key_mappings = {
	--- NORMAL MODE
	{
		mode = "n",
		{ "<C-`>", "<cmd>ToggleTerm<CR>", desc = "toggle-term", nowait = false, remap = false },
		{ "<C-.><C-.>", "<cmd>NvimTreeToggle<CR>", desc = "toggle-term", nowait = false, remap = false },

		{
			",1",
			function()
				harpoon_list:select(1)
			end,
			desc = "harpoon-1",
			nowait = false,
			remap = false,
		},

		{
			",2",
			function()
				harpoon_list:select(2)
			end,
			desc = "harpoon-2",
			nowait = false,
			remap = false,
		},

		{
			",3",
			function()
				harpoon_list:select(3)
			end,
			desc = "harpoon-3",
			nowait = false,
			remap = false,
		},

		{
			",4",
			function()
				harpoon_list:select(4)
			end,
			desc = "harpoon-4",
			nowait = false,
			remap = false,
		},

		{
			",5",
			function()
				harpoon_list:select(5)
			end,
			desc = "harpoon-5",
			nowait = false,
			remap = false,
		},

		{ ",p", group = "swap-prev", nowait = false, remap = false },
		{ ",n", group = "swap-next", nowait = false, remap = false },

		{ "<leader>,", ":Telescope find_files<CR>", desc = "files", nowait = false, remap = false },
		{ "<leader>.", ":Telescope find_files<CR>", desc = "files", nowait = false, remap = false },
		{ "<leader>/", ":CommentToggle<CR>", desc = "comment", nowait = false, remap = false },

		{ "<leader>0", "0", desc = "0", nowait = false, remap = false },
		{ "<leader>6", "^", desc = "^", nowait = false, remap = false },
		{ "<leader>9", "$", desc = "$", nowait = false, remap = false },

		{ "<leader>1", "<cmd>1tabnext<CR>", desc = "tab-1", nowait = false, remap = false },
		{ "<leader>2", "<cmd>2tabnext<CR>", desc = "tab-2", nowait = false, remap = false },
		{ "<leader>3", "<cmd>3tabnext<CR>", desc = "tab-3", nowait = false, remap = false },
		{ "<leader>4", "<cmd>4tabnext<CR>", desc = "tab-4", nowait = false, remap = false },
		{ "<leader>5", "<cmd>5tabnext<CR>", desc = "tab-5", nowait = false, remap = false },

		-- [A]CTION ----------------
		{ "<leader>a", group = "action", nowait = false, remap = false },
		{ "<leader>ac", desc = "+copy", nowait = false, remap = false },
		{ "<leader>av", desc = "+paste", nowait = false, remap = false },
		{ "<leader>ax", desc = "+cut", nowait = false, remap = false },

		-- [B]UFFER ----------------
		{ "<leader>b", group = "buffer", nowait = false, remap = false },
		{ "<leader>bB", "<cmd>Telescope buffers<CR>", desc = "fzf-buffer", nowait = false, remap = false },
		{ "<leader>bd", "<cmd>bp | bd #<CR>", desc = "kill-buffer", nowait = false, remap = false },
		{ "<leader>bf", "<cmd>bfirst<CR>", desc = "first-buffer", nowait = false, remap = false },
		{ "<leader>bk", "<cmd>bp | bd #<CR>", desc = "kill-buffer", nowait = false, remap = false },
		{ "<leader>bK", "<cmd>%bd | enew <CR>", desc = "kill-all-buffers", nowait = false, remap = false },
		{ "<leader>bl", "<cmd>blast<CR>", desc = "last-buffer", nowait = false, remap = false },
		{ "<leader>bn", "<cmd>bnext<CR>", desc = "next-buffer", nowait = false, remap = false },
		{ "<leader>bO", "<cmd>%bd | e#<CR>", desc = "kill-other-buffers", nowait = false, remap = false },
		{ "<leader>bp", "<cmd>bprevious<CR>", desc = "previous-buffer", nowait = false, remap = false },
		{ "<leader>bt", "<C-^>", desc = "toggle-buffer", nowait = false, remap = false },
		{ "<leader>bz", "<cmd>Telescope buffers<CR>", desc = "fzf-buffer", nowait = false, remap = false },

		-- [C]ODE -------------------
		{ "<leader>c", group = "code", nowait = false, remap = false },

		{
			"<leader>ca",
			vim.lsp.buf.code_action,
			desc = "action",
			nowait = false,
			remap = false,
		},

		{
			"<leader>cf",
			function()
				conform.format({ async = true, lsp_format = "fallback" })
			end,
			desc = "format",
			nowait = false,
			remap = false,
		},

		{ "<leader>cF", "<cmd>Telescope filetypes<CR>", desc = "filetype", nowait = false, remap = false },
		{
			"<leader>cS",
			"<cmd>Telescope lsp_workspace_symbols<CR>",
			desc = "workspace-symbols",
			nowait = false,
			remap = false,
		},
		{ "<leader>cT", "<cmd>! ctags -R *<CR>", desc = "ctags", nowait = false, remap = false },
		{ "<leader>cm", "<cmd>FloatermNew --autoclose=0 make<CR>", desc = "make all", nowait = false, remap = false },
		{
			"<leader>cs",
			"<cmd>Telescope lsp_document_symbols<CR>",
			desc = "document-symbols",
			nowait = false,
			remap = false,
		},

		-- [D]EBUG ------------------
		{ "<leader>d", group = "debug", nowait = false, remap = false },
		{ "<leader>db", "<cmd>DapToggleBreakpoint<CR>", desc = "toggle-Breakpoint", nowait = false, remap = false },
		{ "<leader>dc", "<cmd>DapContinue<CR>", desc = "continue", nowait = false, remap = false },
		{ "<leader>di", "<cmd>DapStepInto<CR>", desc = "step-into", nowait = false, remap = false },
		{ "<leader>do", "<cmd>DapStepOver<CR>", desc = "step-over", nowait = false, remap = false },
		{
			"<leader>dm",
			"<cmd>FloatermNew --autoclose=0 make debug<CR>",
			desc = "make debug",
			nowait = false,
			remap = false,
		},
		{ "<leader>dr", "<cmd>DapToggleRepl<CR>", desc = "open-repl", nowait = false, remap = false },

		-- [E]VAL / [E]DIT -------
		{ "<leader>e", group = "edit/eval", nowait = false, remap = false },
		{ "<leader>el", "<cmd>luafile %<CR>", desc = "luafile", nowait = false, remap = false },
		{ "<leader>ep", "<cmd>Runme<CR>", desc = "program", nowait = false, remap = false },
		{ "<leader>ev", "<cmd>source %<CR>", desc = "source %", nowait = false, remap = false },

		-- [F]ILE -------------------
		{ "<leader>f", group = "file", nowait = false, remap = false },
		{ "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "files", nowait = false, remap = false },
		{
			"<leader>fi",
			"<cmd>e $HOME/.config/nvim/init.lua<CR>",
			desc = "init.lua",
			nowait = false,
			remap = false,
		},
		{
			"<leader>fI",
			"<cmd>e $HOME/.config/nvim/vimscript/init.vim<CR>",
			desc = "init.vim",
			nowait = false,
			remap = false,
		},
		{
			"<leader>fk",
			"<cmd>e $HOME/.config/nvim/lua/plugins/whichkey.lua<CR>",
			desc = "which-key",
			nowait = false,
			remap = false,
		},
		{
			"<leader>fl",
			"<cmd>e $HOME/.config/nvim/lua/plugins/lsp.lua<CR>",
			desc = "lsp",
			nowait = false,
			remap = false,
		},
		{
			"<leader>fp",
			function()
				telescope_builtins.find_files({ cwd = "~/.config/nvim/" })
			end,
			desc = "private-config",
			nowait = false,
			remap = false,
		},
		{
			"<leader>fP",
			"<cmd>e $HOME/.config/nvim/lua/lazy_plugins.lua<CR>",
			desc = "plugins-config",
			nowait = false,
			remap = false,
		},
		{
			"<leader>fq",
			"<cmd>e $HOME/.config/wezterm/wezterm.lua<CR>",
			desc = "wezterm-config",
			nowait = false,
			remap = false,
		},
		{ "<leader>fr", "<cmd>e<CR>", desc = "reload-file", nowait = false, remap = false },
		{ "<leader>fs", "<cmd>update<CR>", desc = "save-file", nowait = false, remap = false },
		{
			"<leader>fS",
			"<cmd>e $HOME/.config/nvim/lua/settings.lua<CR>",
			desc = "settings.lua",
			nowait = false,
			remap = false,
		},
		{
			"<leader>ft",
			"<cmd>e $HOME/.config/nvim/vimscript/temp.vim<CR>",
			desc = "temp.vim",
			nowait = false,
			remap = false,
		},
		{
			"<leader>fT",
			"<cmd>e $HOME/.config/nvim/lua/temp.lua<CR>",
			desc = "temp.lua",
			nowait = false,
			remap = false,
		},
		{
			"<leader>fx",
			"<cmd>! rm -f $HOME/.local/share/nvim/swap/*<CR>",
			desc = "delete-swap-files",
			nowait = false,
			remap = false,
		},
		{
			"<leader>fX",
			"<cmd>! rm -f $HOME/.config/nvim/undodir/*<CR>",
			desc = "delete-undo-files",
			nowait = false,
			remap = false,
		},
		{
			"<leader>fw",
			"<cmd>e $HOME/.config/nvim/lua/plugins/whichkey.lua<CR>",
			desc = "whichkey-config",
			nowait = false,
			remap = false,
		},
		{
			"<leader>fz",
			"<cmd>e /Users/hari/.config/zellij/config.kdl<CR>",
			desc = "zellij-config",
			nowait = false,
			remap = false,
		},

		-- [G]IT --------------------
		{ "<leader>g", group = "git", nowait = false, remap = false },
		{ "<leader>gB", "<cmd>Gitsigns blame<CR>", desc = "BLAME", nowait = false, remap = false },
		{ "<leader>gC", "<cmd>Telescope git_bcommits<CR>", desc = "bcommits", nowait = false, remap = false },
		{ "<leader>gS", "<cmd>Telescope git_stash<CR>", desc = "stash", nowait = false, remap = false },
		{ "<leader>gb", "<cmd>Gitsigns blame_line<CR>", desc = "blame-line", nowait = false, remap = false },
		{ "<leader>gB", "<cmd>Gitsigns blame<CR>", desc = "blame-file", nowait = false, remap = false },
		{ "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits", nowait = false, remap = false },
		{ "<leader>gf", "<cmd>Telescope git_files<CR>", desc = "git-files", nowait = false, remap = false },
		{ "<leader>gg", "<cmd>Gitsigns preview_hunk_inline<CR>", desc = "preview-hunk", nowait = false, remap = false },
		{ "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", desc = "preview-hunk", nowait = false, remap = false },
		{ "<leader>gy", "<cmd>Telescope git_branches<CR>", desc = "branches", nowait = false, remap = false },

		-- [H]ELP -------------------
		{ "<leader>h", group = "help", nowait = false, remap = false },
		{ "<leader>hf", "<cmd>Telescope builtins<CR>", desc = "describe-function", nowait = false, remap = false },

		{ "<leader>hh", group = "git-hunk", nowait = false, remap = false },
		{ "<leader>hhp", "<cmd>Gitsigns prev_hunk<CR>", desc = "preview-hunk", nowait = false, remap = false },
		{ "<leader>hhn", "<cmd>Gitsigns next_hunk<CR>", desc = "next-hunk", nowait = false, remap = false },
		{ "<leader>hhs", "<cmd>Gitsigns stage_hunk<CR>", desc = "stage-hunk", nowait = false, remap = false },
		{
			"<leader>hhu",
			"<cmd>Gitsigns unstage_hunk<CR>",
			desc = "undo-stage-hunk",
			nowait = false,
			remap = false,
		},
		{
			"<leader>hhv",
			"<cmd>Gitsigns select_hunk<CR>",
			desc = "visual-select-hunk",
			nowait = false,
			remap = false,
		},

		{ "<leader>hk", "<cmd>Telescope keymaps<CR>", desc = "describe-key", nowait = false, remap = false },
		{ "<leader>hl", group = "harpoon", nowait = false, remap = false },
		{
			"<leader>hla",
			function()
				harpoon_list:add()
			end,
			desc = "harpoon-add",
			nowait = false,
			remap = false,
		},

		{
			"<leader>hld",
			function()
				harpoon_list:remove()
			end,
			desc = "harpoon-delete",
			nowait = false,
			remap = false,
		},

		{
			"<leader>hll",
			function()
				require("harpoon").ui:toggle_quick_menu(harpoon_list)
			end,
			desc = "harpoon-list",
			nowait = false,
			remap = false,
		},

		{
			"<leader>hlp",
			function()
				harpoon_list:prev()
			end,
			desc = "harpoon-prev",
			nowait = false,
			remap = false,
		},

		{
			"<leader>hln",
			function()
				harpoon_list:next()
			end,
			desc = "harpoon-next",
			nowait = false,
			remap = false,
		},

		{ "<leader>hrr", "<cmd>echo '`emacs` command 🫠'<CR>", desc = "N/A", nowait = false, remap = false },
		{
			"<leader>hs",
			"<cmd>lua vim.lsp.buf.signature_help()<CR>",
			desc = "lsp signature",
			nowait = false,
			remap = false,
		},
		{ "<leader>ht", "<cmd>FzfLua colorschemes<CR>", desc = "themes", nowait = false, remap = false },

		{ "<leader>i", group = "info", nowait = false, remap = false }, -- [I]NFO / [I]NSERT --------
		{ "<leader>ib", "<cmd> !battery<CR>", desc = "battery", nowait = false, remap = false },
		{ "<leader>ic", "<cmd> !clock<CR>", desc = "clock", nowait = false, remap = false },
		{ "<leader>id", "<cmd> !date<CR>", desc = "date-time", nowait = false, remap = false },
		{ "<leader>il", "<cmd> !pwd;ls -la<CR>", desc = "list-all-files", nowait = false, remap = false },
		{ "<leader>im", "<cmd> !memory<CR>", desc = "memory", nowait = false, remap = false },
		{ "<leader>ip", "<cmd> !battery<CR>", desc = "power-percent", nowait = false, remap = false },
		{ "<leader>ir", "<cmd> !memory<CR>", desc = "rar", nowait = false, remap = false },
		{ "<leader>it", "<cmd> !clock<CR>", desc = "date-time", nowait = false, remap = false },
		{ "<leader>iu", "<cmd> !upt<CR>", desc = "date-uptime", nowait = false, remap = false },
		{ "<leader>iv", "<cmd> !volume<CR>", desc = "volume", nowait = false, remap = false },

		{ "<leader>j", group = "tabs", nowait = false, remap = false }, -- TABS ------------
		{ "<leader>j0", "<cmd>tabfirst<CR>", desc = "first-tab", nowait = false, remap = false },
		{ "<leader>j1", "<cmd>1tabnext<CR>", desc = "tab-1", nowait = false, remap = false },
		{ "<leader>j2", "<cmd>2tabnext<CR>", desc = "tab-2", nowait = false, remap = false },
		{ "<leader>j3", "<cmd>3tabnext<CR>", desc = "tab-3", nowait = false, remap = false },
		{ "<leader>j4", "<cmd>4tabnext<CR>", desc = "tab-4", nowait = false, remap = false },
		{ "<leader>j5", "<cmd>5tabnext<CR>", desc = "tab-5", nowait = false, remap = false },
		{ "<leader>j6", "<cmd>6tabnext<CR>", desc = "tab-6", nowait = false, remap = false },
		{ "<leader>j7", "<cmd>7tabnext<CR>", desc = "tab-7", nowait = false, remap = false },
		{ "<leader>j8", "<cmd>8tabnext<CR>", desc = "tab-8", nowait = false, remap = false },
		{ "<leader>j9", "<cmd>tablast<CR>", desc = "last-tab", nowait = false, remap = false },
		{ "<leader>jK", "<cmd>tabonly<CR>", desc = "only-current-tab", nowait = false, remap = false },
		{ "<leader>jc", "<cmd>tabclose<CR>", desc = "close-tab", nowait = false, remap = false },
		{ "<leader>jh", "<cmd>-tabmove<CR>", desc = "move-left", nowait = false, remap = false },
		{ "<leader>ji", "<cmd>tabs<CR>", desc = "info-tabs", nowait = false, remap = false },
		{ "<leader>jk", "<cmd>tabclose<CR>", desc = "kill-tab", nowait = false, remap = false },
		{ "<leader>jl", "<cmd>+tabmove<CR>", desc = "move-right", nowait = false, remap = false },
		{ "<leader>jn", "<cmd>tabnew<CR>", desc = "new-tab", nowait = false, remap = false },

		-- [L]ANGUAGE ----------------
		{ "<leader>l", group = "lsp", nowait = false, remap = false },

		{
			"<leader>la",
			"<cmd>lua vim.lsp.buf.code_action()<CR>",
			desc = "code-action",
			nowait = false,
			remap = false,
		},
		{ "<leader>ld", "", desc = "document-diagnostics", nowait = false, remap = false },

		{
			"<leader>lD",
			"<cmd>Telescope diagnostics<CR>",
			desc = "workspace-diagnostics",
			nowait = false,
			remap = false,
		},

		{
			"<leader>lf",
			"<cmd>lua vim.lsp.buf.type_definition()<CR>",
			desc = "type-definition",
			nowait = false,
			remap = false,
		},

		{ "<leader>li", "<cmd>InspectTree<CR>", desc = "inspect-tree", nowait = false, remap = false },
		{ "<leader>lI", "<cmd>LspInfo<CR>", desc = "lsp-info", nowait = false, remap = false },
		{ "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "hover", nowait = false, remap = false },

		{
			"<leader>ll",
			"<cmd>lua vim.diagnostic.open_float()<CR>",
			desc = "cursor-diagnostics",
			nowait = false,
			remap = false,
		},

		{
			"<leader>lL",
			"<cmd>lua vim.diagnostic.open_float()<CR>",
			desc = "line-diagnostics",
			nowait = false,
			remap = false,
		},

		-- [n]ext -------------------
		{ "<leader>ln", group = "next", nowait = false, remap = false },
		{
			"<leader>lnd",
			"<cmd>lua vim.diagnostic.goto_next()<CR>",
			desc = "next-diagnostic",
			nowait = false,
			remap = false,
		},

		-- [p]revious ---------------
		{ "<leader>lp", group = "next", nowait = false, remap = false },
		{
			"<leader>lpd",
			"<cmd>lua vim.diagnostic.goto_prev()<CR>",
			desc = "prev-diagnostic",
			nowait = false,
			remap = false,
		},

		{ "<leader>lq", "<cmd>Telescope quickfix<CR>", desc = "quickfix", nowait = false, remap = false },
		{ "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "rename", nowait = false, remap = false },
		{ "<leader>lx", "<cmd>cclose<CR>", desc = "close-quickfix", nowait = false, remap = false },

		-- [M]AKE -------------------
		{ "<leader>m", group = "prefix", nowait = false, remap = false },
		{ "<leader>mc", "<cmd>FloatermNew --autoclose=0 make<CR>", desc = "make clean", nowait = false, remap = false },
		{
			"<leader>md",
			"<cmd>FloatermNew --autoclose=0 make debug<CR>",
			desc = "make debug",
			nowait = false,
			remap = false,
		},
		{ "<leader>ml", group = "link", nowait = false, remap = false },
		{ "<leader>mll", "<cmd>echo '`emacs` command 🫠'<CR>", desc = "N/A", nowait = false, remap = false },
		{ "<leader>mlt", "<cmd>echo '`emacs` command 🫠'<CR>", desc = "N/A", nowait = false, remap = false },
		{ "<leader>mm", "<cmd>FloatermNew --autoclose=0 make<CR>", desc = "make all", nowait = false, remap = false },
		{ "<leader>mo", "<cmd>e Makefile<CR>", desc = "open Makefile", nowait = false, remap = false },
		{
			"<leader>mt",
			"<cmd>FloatermNew --autoclose=0 make test<CR>",
			desc = "make test",
			nowait = false,
			remap = false,
		},
		{ "<leader>mz", "<cmd>MakeFzf<CR>", desc = "make-fzf", nowait = false, remap = false },

		-- [N]OTES -------------------
		{ "<leader>n", group = "notes", nowait = false, remap = false },

		---- news[b]oat --------------
		{ "<leader>nb", group = "boat", nowait = false, remap = false },
		{
			"<leader>nbb",
			"<cmd>e $HOME/.config/newsboat/rss.yml<CR>",
			desc = "boat/rss.yml",
			nowait = false,
			remap = false,
		},
		{
			"<leader>nbc",
			"<cmd>! python $HOME/.config/newsboat/rss2urls.py<CR>",
			desc = "boat-compile",
			nowait = false,
			remap = false,
		},

		---- [j]ournal ---------------
		{
			"<leader>nbu",
			"<cmd>e $HOME/.config/newsboat/urls<CR>",
			desc = "boat/urls",
			nowait = false,
			remap = false,
		},

		{ "<leader>nj", group = "journal", nowait = false, remap = false },
		{ "<leader>njj", "<cmd>echo '`emacs` command 🫠'<CR>", desc = "N/A", nowait = false, remap = false },
		{
			"<leader>njs",
			function()
				telescope_builtins.find_files({ cwd = "$HOME/my/org/journal/" })
			end,
			desc = "journal",
			nowait = false,
			remap = false,
		},

		---- [r]oam ------------------
		{ "<leader>nr", group = "roam", nowait = false, remap = false },
		{
			"<leader>nrf",
			function()
				telescope_builtins.find_files({ cwd = "$HOME/my/org/roam/" })
			end,
			desc = "roam",
			nowait = false,
			remap = false,
		},
		{ "<leader>nri", "<cmd>echo '`emacs` command 🫠'<CR>", desc = "N/A", nowait = false, remap = false },
		{ "<leader>nrr", "<cmd>echo '`emacs` command 🫠'<CR>", desc = "N/A", nowait = false, remap = false },
		{ "<leader>nrs", "<cmd>echo '`emacs` command 🫠'<CR>", desc = "N/A", nowait = false, remap = false },
		{ "<leader>ns", "<cmd>echo '`emacs` command 🫠'<CR>", desc = "N/A", nowait = false, remap = false },

		---- [t]odo ------------------
		{ "<leader>nt", group = "todo", nowait = false, remap = false },

		-- [O]PEN -------------------
		{ "<leader>o", group = "open", nowait = false, remap = false },
		{ "<leader>od", "<cmd>FloatermNew lazydocker<CR>", desc = "lazydocker", nowait = false, remap = false },
		{ "<leader>oe", "<cmd>NvimTreeToggle<CR>", desc = "explorer", nowait = false, remap = false },
		{ "<leader>ol", "<cmd>FloatermNew lazygit<CR>", desc = "lazygit", nowait = false, remap = false },
		{ "<leader>om", "<cmd>e Makefile<CR>", desc = "Makefile", nowait = false, remap = false },
		{ "<leader>on", "<cmd>Messages<CR>", desc = "notifications", nowait = false, remap = false },
		-- { "<leader>on", "<cmd>NoiceAll<CR>", desc = "notifications", nowait = false, remap = false },

		{
			"<leader>oo",
			"<cmd>Telescope lsp_document_symbols<CR>",
			desc = "document-symbols",
			nowait = false,
			remap = false,
		},

		{
			"<leader>oO",
			"<cmd>Telescope lsp_workspace_symbols<CR>",
			desc = "workspace-symbols",
			nowait = false,
			remap = false,
		},

		{ "<leader>oP", "<cmd>Lazy<CR>", desc = "plugin-manager", nowait = false, remap = false },
		{ "<leader>or", "<cmd>FloatermNew ranger .<CR>", desc = "ranger", nowait = false, remap = false },
		{ "<leader>ot", "<cmd>ToggleTerm<CR>", desc = "terminal", nowait = false, remap = false },
		{ "<leader>oz", "<cmd>Telescope builtin<CR>", desc = "telescope", nowait = false, remap = false },

		-- [P]ROJECT ----------------
		{ "<leader>p", group = "project", nowait = false, remap = false },
		{ "<leader>pt", "<cmd>TodoQuickFix<CR>", desc = "todo-fixes", nowait = false, remap = false },

		-- [Q]UIT -------------------
		{ "<leader>q", group = "quit", nowait = false, remap = false },
		{ "<leader>qa", "<cmd>qa<CR>", desc = "quit all, unmodified", nowait = false, remap = false },
		{ "<leader>qq", "<cmd>q<CR>", desc = "quit file, unmodified", nowait = false, remap = false },
		{
			"<leader>qr",
			"<cmd>luafile $HOME/.config/nvim/init.lua<CR>",
			desc = "reload",
			nowait = false,
			remap = false,
		},
		{ "<leader>qu", "<cmd>update<CR>", desc = "update", nowait = false, remap = false },
		{ "<leader>qw", "<cmd>wq<CR>", desc = "save and quit", nowait = false, remap = false },

		-- [R]ELOAD ----------------
		{ "<leader>r", group = "reload", nowait = false, remap = false },
		{ "<leader>re", "<cmd>NvimTreeRefresh<CR>", desc = "explorer", nowait = false, remap = false },
		{ "<leader>rf", "<cmd>NvimTreeRefresh<CR>", desc = "explorer", nowait = false, remap = false },
		{
			"<leader>rr",
			"<cmd>source $HOME/.config/nvim/init.lua<CR>",
			desc = "source init.vim",
			nowait = false,
			remap = false,
		},

		-- [S]EARCH ----------------
		{ "<leader>s", group = "search", nowait = false, remap = false },
		{ "<leader>sM", "<cmd>Telescope man_pages<CR>", desc = "Man Pages", nowait = false, remap = false },
		{ "<leader>sR", "<cmd>Telescope registers<CR>", desc = "Registers", nowait = false, remap = false },
		{ "<leader>sb", "<cmd>Gitsigns blame_line<CR>", desc = "blame_line", nowait = false, remap = false },
		{ "<leader>sd", "<cmd>!date<CR>", desc = "show-datetime", nowait = false, remap = false },
		{ "<leader>sf", "<cmd>Telescope find_files<CR>", desc = "Find File", nowait = false, remap = false },
		{ "<leader>sm", "<cmd>Telescope marks<CR>", desc = "Marks", nowait = false, remap = false },
		{ "<leader>sr", "<cmd>Telescope oldfiles<CR>", desc = "Open Recent File", nowait = false, remap = false },
		{ "<leader>st", "<cmd>!date<CR>", desc = "show-datetime", nowait = false, remap = false },

		-- [T]OGGLE ----------------
		{ "<leader>t", group = "toggle", nowait = false, remap = false },
		{ "<leader>tb", "<cmd>Gitsigns blame<CR>", desc = "BLAME", nowait = false, remap = false },
		{ "<leader>tc", "<cmd>CloakPreviewLine<CR>", desc = "cloak", nowait = false, remap = false },
		{ "<leader>tC", "<cmd>CloakToggle<CR>", desc = "cloak", nowait = false, remap = false },
		{ "<leader>tg", "<cmd>Gitsigns toggle_signs<CR>", desc = "git-signs", nowait = false, remap = false },
		{ "<leader>tG", "<cmd>%norm! g??<CR>", desc = "gibberish-rot13", nowait = false, remap = false },
		{ "<leader>th", "<cmd>set hls!<CR>", desc = "hl-search", nowait = false, remap = false },
		{ "<leader>tl", "<cmd>LspRestart<CR>", desc = "lsp-restart", nowait = false, remap = false },
		{ "<leader>to", "<cmd>call Cpp_Flip_Ext()<CR>", desc = "CppFlip", nowait = false, remap = false },
		{ "<leader>tr", "<cmd>set ro!<CR>", desc = "read-only", nowait = false, remap = false },
		{ "<leader>ts", "<cmd>set spell!<CR>", desc = "spell-check", nowait = false, remap = false },
		{
			"<leader>tt",
			"<cmd>highlight Normal guibg=None<CR>",
			desc = "bg-transparent",
			nowait = false,
			remap = false,
		},
		{ "<leader>tT", "<cmd>highlight Normal guibg=black<CR>", desc = "bg-black", nowait = false, remap = false },
		{ "<leader>tw", "<cmd>set nowrap!<CR>", desc = "wrap-text", nowait = false, remap = false },
		{ "<leader>tz", "<cmd>ZenMode<CR>", desc = "wrap-text", nowait = false, remap = false },

		-- [W]INDOW ----------------
		{ "<leader>w", group = "window", nowait = false, remap = false },
		{ "<leader>w+", "<C-w>>", desc = "increase-height", nowait = false, remap = false },
		{ "<leader>w-", "<C-w><", desc = "decrease-height", nowait = false, remap = false },
		{ "<leader>w<", "<C-w><", desc = "decrease-width", nowait = false, remap = false },
		{ "<leader>w=", "<C-w>=", desc = "equalize-window", nowait = false, remap = false },
		{ "<leader>w>", "<C-w>>", desc = "increase-width", nowait = false, remap = false },
		{ "<leader>wc", "<C-w>c", desc = "close-window", nowait = false, remap = false },
		{ "<leader>we", "<C-w>=", desc = "balance-window", nowait = false, remap = false },
		{ "<leader>wh", "<C-w>h", desc = "left-window", nowait = false, remap = false },
		{ "<leader>wj", "<C-w>j", desc = "bottom-window", nowait = false, remap = false },
		{ "<leader>wk", "<C-w>k", desc = "top-window", nowait = false, remap = false },
		{ "<leader>wl", "<C-w>l", desc = "right-window", nowait = false, remap = false },
		{ "<leader>wm", "<cmd>only<CR>", desc = "maximize-window", nowait = false, remap = false },
		{ "<leader>wn", "<cmd>new<CR>", desc = "new-window", nowait = false, remap = false },
		{ "<leader>wo", "<cmd>only<CR>", desc = "only-window", nowait = false, remap = false },
		{ "<leader>wq", "<C-w>q", desc = "quit-window", nowait = false, remap = false },
		{ "<leader>ws", "<C-w>s", desc = "split-window-below", nowait = false, remap = false },
		{ "<leader>wv", "<C-w>v", desc = "split-window-right", nowait = false, remap = false },
		{ "<leader>ww", "<C-w>w", desc = "switch-window", nowait = false, remap = false },
		{ "<leader>wx", "<C-w>x", desc = "swap-window", nowait = false, remap = false },
		{ "<leader>w|", "<C-w><", desc = "max-out-width", nowait = false, remap = false },

		-- MISC ----------------------
		{ "<leader>x", group = "misc", nowait = false, remap = false },

		-- FU[Z]ZY ---------------
		{ "<leader>z", group = "telescope", nowait = false, remap = false },
		{ "<leader>za", "<cmd>Telescope autocommands<CR>", desc = "buffers", nowait = false, remap = false },
		{ "<leader>zb", "<cmd>Telescope buffers<CR>", desc = "buffers", nowait = false, remap = false },
		{ "<leader>zB", "<cmd>Telescope builtins<CR>", desc = "builtins", nowait = false, remap = false },
		{ "<leader>zc", "<cmd>Telescope commands<CR>", desc = "commands", nowait = false, remap = false },
		{ "<leader>zC", "<cmd>Telescope colorscheme<CR>", desc = "colors", nowait = false, remap = false },
		{ "<leader>zf", "<cmd>Telescope find_files<CR>", desc = "files", nowait = false, remap = false },
		{ "<leader>zF", "<cmd>Telescope filetypes<CR>", desc = "file type", nowait = false, remap = false },
		{
			"<leader>zH",
			"<cmd>Telescope command_history<CR>",
			desc = "command-history",
			nowait = false,
			remap = false,
		},

		---- [g]it ----------------
		{ "<leader>zg", group = "git", nowait = false, remap = false },
		{ "<leader>zgS", "<cmd>Telescope git_stash<CR>", desc = "stash", nowait = false, remap = false },
		{ "<leader>zgb", "<cmd>Telescope git_commits<CR>", desc = "commits", nowait = false, remap = false },
		{ "<leader>zgf", "<cmd>Telescope git_files<CR>", desc = "files", nowait = false, remap = false },
		{ "<leader>zgs", "<cmd>Telescope git_status<CR>", desc = "status", nowait = false, remap = false },

		{ "<leader>zh", "<cmd>Telescope help_tags<CR>", desc = "Help tags", nowait = false, remap = false },
		{ "<leader>zm", "<cmd>Telescope marks<CR>", desc = "marks", nowait = false, remap = false },
		{ "<leader>zM", "<cmd>Telescope man_pages<CR>", desc = "man pages", nowait = false, remap = false },
		-- { "<leader>zn", "<cmd>NoiceTelescope<CR>", desc = "noice", nowait = false, remap = false },
		{ "<leader>zr", "<cmd>Telescope registers<CR>", desc = "registers", nowait = false, remap = false },

		---- [s]earch ---------------
		{ "<leader>zs", group = "show", nowait = false, remap = false },
		{
			"<leader>zss",
			"<cmd>Telescope command_history<CR>",
			desc = "command-history",
			nowait = false,
			remap = false,
		},

		{ "<leader>zt", "<cmd>TodoTelescope keywords=TODO,FIX<CR>", desc = "todo", nowait = false, remap = false },
		{ "<leader>zu", "<cmd>Telescope undo<CR>", desc = "undo", nowait = false, remap = false },
		{ "<leader>zv", "<cmd>Telescope commands<CR>", desc = "vim-commands", nowait = false, remap = false },
		{ "<leader>zz", "<cmd>Telescope live_grep<CR>", desc = "file-browser", nowait = false, remap = false },
		{ "<leader>zZ", "<cmd>Telescope grep_string<CR>", desc = "grep_string", nowait = false, remap = false },
	},

	--- VISUAL MODE
	{
		mode = "v",
		-- [G]IT ------------------
		{ "<leader>g", group = "git", nowait = false, remap = false },

		---- [h]unk ---------------
		{ "<leader>hh", group = "git-hunk", nowait = false, remap = false },
		{ "<leader>hhs", "<cmd>Gitsigns stage_hunk<CR>", desc = "stage-hunk", nowait = false, remap = false },
		{ "<leader>hhu", "<cmd>Gitsigns undo_stage_hunk<CR>", desc = "unstage-hunk", nowait = false, remap = false },
	},

	--- TERMINAL MODE
	{
		mode = "t",
		{ "<C-`>", "<cmd>ToggleTerm<CR>", desc = "toggle-term", nowait = false, remap = false },
		{ "<leader>ot", "<cmd>ToggleTerm<CR>", desc = "toggle-term", nowait = false, remap = false },
	},
}

local setup_delay_function = function()
	return function(ctx)
		return ctx.plugin and 0 or 200
	end
end

local setup_filter_function = function()
	return function(mapping)
		return mapping == true
	end
end

local setup_defer_function = function()
	return function(ctx)
		return ctx.mode == "V" or ctx.mode == "<C-V>"
	end
end

local setup_plugins = function()
	return {
		marks = true,
		registers = true,
		spelling = {
			enabled = true,
			suggestions = 20,
		},
		presets = {
			operators = true,
			motions = true,
			text_objects = true,
			windows = true,
			nav = true,
			z = true,
			g = true,
		},
	}
end

local setup_window_options = function()
	return {
		no_overlap = true,
		padding = { 1, 2 },
		title = true,
		title_pos = "center",
		zindex = 1000,
		bo = {},
		wo = {},
	}
end

local setup_layout_options = function()
	return {
		height = { min = 14, max = 25 },
		width = { min = 20, max = 50 },
		spacing = 3,
	}
end

local setup_keys = function()
	return {
		scroll_down = "<c-d>",
		scroll_up = "<c-u>",
	}
end

local setup_icons = function()
	return {
		breadcrumb = "»",
		separator = "➜",
		group = "+",
		ellipsis = "…",
		mappings = true,
		rules = {},
		colors = true,
		keys = {
			Up = " ",
			Down = " ",
			Left = " ",
			Right = " ",
			C = "󰘴 ",
			M = "󰘵 ",
			D = "󰘳 ",
			S = "󰘶 ",
			CR = "󰌑 ",
			Esc = "󱊷 ",
			ScrollWheelDown = "󱕐 ",
			ScrollWheelUp = "󱕑 ",
			NL = "󰌑 ",
			BS = "󰁮",
			Space = "󱁐 ",
			Tab = "󰌒 ",
			F1 = "󱊫",
			F2 = "󱊬",
			F3 = "󱊭",
			F4 = "󱊮",
			F5 = "󱊯",
			F6 = "󱊰",
			F7 = "󱊱",
			F8 = "󱊲",
			F9 = "󱊳",
			F10 = "󱊴",
			F11 = "󱊵",
			F12 = "󱊶",
		},
	}
end

local setup_which_key = function()
	local wk = require("which-key")

	wk.setup({
		---@type false | "classic" | "modern" | "helix"
		preset = "classic",
		delay = setup_delay_function(),
		filter = setup_filter_function(),
		spec = {},
		notify = true,
		triggers = {
			{ "<auto>", mode = "nxsot" },
		},
		defer = setup_defer_function(),
		plugins = setup_plugins(),
		win = setup_window_options(),
		layout = setup_layout_options(),
		keys = setup_keys(),
		sort = { "local", "order", "group", "alphanum", "mod" },
		expand = 0,
		icons = setup_icons(),
		show_help = true,
		show_keys = true,
		disable = {
			ft = {},
			bt = {},
		},
		debug = false,
	})

	-- Register the key mappings
	wk.add(key_mappings)
end

setup_which_key()
