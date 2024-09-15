require("which-key").setup {
	---@type false | "classic" | "modern" | "helix"
	preset = "classic",
	
	-- Delay before showing the popup. Can be a number or a function that returns a number.
	---@type number | fun(ctx: { keys: string, mode: string, plugin?: string }):number
	delay = function(ctx)
		return ctx.plugin and 0 or 200
	end,
	
	---@param mapping wk.Mapping
	filter = function(mapping)
		-- example to exclude mappings without a description
		-- return mapping.desc and mapping.desc ~= ""
		return true
	end,
	
	--- You can add any mappings here, or use `require('which-key').add()` later
	---@type wk.Spec
	spec = {},
	
	-- show a warning when issues were detected with your mappings
	notify = true,
	
	-- Which-key automatically sets up triggers for your mappings.
	-- But you can disable this and setup the triggers manually.
	-- Check the docs for more info.
	---@type wk.Spec
	triggers = {
		{ "<auto>", mode = "nxsot" },
	},
  
	-- Start hidden and wait for a key to be pressed before showing the popup
	-- Only used by enabled xo mapping modes.
	---@param ctx { mode: string, operator: string }
	defer = function(ctx)
		return ctx.mode == "V" or ctx.mode == "<C-V>"
	end,
	
	plugins = {
		-- shows a list of your marks on ' and `
        marks = true,

		-- shows your registers on " in NORMAL or <C-r> in INSERT mode
        registers = true,

        --[[ the presets plugin, adds help for a bunch of default keybindings in Neovim
        No actual key bindings are created --]]
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},

		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
    },

    win = {
		-- don't allow the popup to overlap with the cursor
		no_overlap = true,

		-- width = 1,
		-- height = { min = 4, max = 25 },
		-- col = 0,
		-- row = math.huge,
		-- border = "none",

		-- extra window padding [top/bottom, right/left]
		padding = { 1, 2 },
		title = true,
		title_pos = "center",
		zindex = 1000,
		-- Additional vim.wo and vim.bo options
		bo = {},
		wo = {
			-- winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
		},
    },

	layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
	},

	keys = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},

	---@type (string|wk.Sorter)[]
	--- Mappings are sorted using configured sorters and natural sort of the keys
	--- Available sorters:
	--- * local: buffer-local mappings first
	--- * order: order of the items (Used by plugins like marks / registers)
	--- * group: groups last
	--- * alphanum: alpha-numerical first
	--- * mod: special modifier keys last
	--- * manual: the order the mappings were added
	--- * case: lower-case first
	sort = { "local", "order", "group", "alphanum", "mod" },

	---@type number|fun(node: wk.Node):boolean?
	expand = 0, -- expand groups when <= n mappings
	-- expand = function(node)
	--   return not node.desc -- expand all nodes without a description
	-- end,

    icons = {
		-- symbol used in the command line area that shows your active key combo
        breadcrumb = "»",

		-- symbol used between a key and it's label
        separator = "➜",

		-- symbol prepended to a group
        group = "+",

		ellipsis = "…",
		
		-- set to false to disable all mapping icons,
		-- both those explicitely added in a mapping
		-- and those from rules
		mappings = true,
		
		--- See `lua/which-key/icons.lua` for more details
		--- Set to `false` to disable keymap icons from rules
		---@type wk.IconRule[]|false
		rules = {},
		
		-- use the highlights from mini.icons
		-- When `false`, it will use `WhichKeyIcon` instead
		colors = true,

		-- used by key format
		keys = {
		  Up				= " ",
		  Down				= " ",
		  Left				= " ",
		  Right				= " ",
		  C					= "󰘴 ",
		  M					= "󰘵 ",
		  D					= "󰘳 ",
		  S					= "󰘶 ",
		  CR				= "󰌑 ",
		  Esc				= "󱊷 ",
		  ScrollWheelDown	= "󱕐 ",
		  ScrollWheelUp		= "󱕑 ",
		  NL				= "󰌑 ",
		  BS				= "󰁮",
		  Space				= "󱁐 ",
		  Tab				= "󰌒 ",
		  F1				= "󱊫",
		  F2 				= "󱊬",
		  F3 				= "󱊭",
		  F4 				= "󱊮",
		  F5 				= "󱊯",
		  F6 				= "󱊰",
		  F7 				= "󱊱",
		  F8 				= "󱊲",
		  F9 				= "󱊳",
		  F10				= "󱊴",
		  F11 				= "󱊵",
		  F12 				= "󱊶",
		},
	},

	show_help = true, -- show a help message in the command line for using WhichKey
	show_keys = true, -- show the currently pressed key and its label as a message in the command line
	-- disable WhichKey for certain buf types and file types.
	disable = {
		ft = {},
		bt = {},
	},
	debug = false, -- enable wk.log in the current directory
}

local normal_layout_config = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false -- use `nowait` when creating keymaps
}


vim.api.nvim_set_keymap("v", "<leader>/", ":CommentToggle<CR>", {noremap = true, silent = true})


local normal_mappings = {
    { "<leader>,", ":Telescope find_files<CR>",									desc = "files", nowait = false, remap = false },
    { "<leader>.", ":Sex!<CR>",													desc = "Sex!", nowait = false, remap = false },
    { "<leader>/", ":CommentToggle<CR>",										desc = "comment", nowait = false, remap = false },
    { "<leader>0", "0",															desc = "0", nowait = false, remap = false },
    { "<leader>1", "^", 														desc = "1", nowait = false, remap = false },
    { "<leader>9", "$", 														desc = "9", nowait = false, remap = false },

	{ "<leader>a", group = "action", nowait = false, remap = false },			-- [A]CTION ----------------
    { "<leader>ac",																desc = "+copy", nowait = false, remap = false },
    { "<leader>av", 															desc = "+paste", nowait = false, remap = false },
    { "<leader>ax", 															desc = "+cut", nowait = false, remap = false },

	{ "<leader>b", group = "buffer", nowait = false, remap = false },			-- [B]UFFER ----------------
    { "<leader>bB", "<cmd>Telescope buffers<CR>",								desc = "fzf-buffer", nowait = false, remap = false },
    { "<leader>bK", "<cmd>%bd | enew <CR>",										desc = "kill-all-buffers", nowait = false, remap = false },
    { "<leader>bd", "<cmd>bp | bd #<CR>",										desc = "kill-buffer", nowait = false, remap = false },
    { "<leader>bf", "<cmd>bfirst<CR>",											desc = "first-buffer", nowait = false, remap = false },
    { "<leader>bk", "<cmd>bp | bd #<CR>",										desc = "kill-buffer", nowait = false, remap = false },
    { "<leader>bl", "<cmd>blast<CR>",											desc = "last-buffer", nowait = false, remap = false },
    { "<leader>bn", "<cmd>bnext<CR>",											desc = "next-buffer", nowait = false, remap = false },
    { "<leader>bO", "<cmd>%bd | e#<CR>",										desc = "kill-other-buffers", nowait = false, remap = false },
    { "<leader>bp", "<cmd>bprevious<CR>",										desc = "previous-buffer", nowait = false, remap = false },
    { "<leader>bt", "<C-^>",													desc = "toggle-buffer", nowait = false, remap = false },

	{ "<leader>c", group = "code", nowait = false, remap = false },				-- [C]ODE -------------------
    { "<leader>cF", "<cmd>Telescope filetypes<CR>",								desc = "filetype", nowait = false, remap = false },
    { "<leader>cS", "<cmd>Telescope lsp_workspace_symbols<CR>",					desc = "workspace-symbols", nowait = false, remap = false },
    { "<leader>cT", "<cmd>! ctags -R *<CR>",									desc = "ctags", nowait = false, remap = false },
    { "<leader>cb", "<cmd>FloatermNew git blame %<CR>",							desc = "git-blame", nowait = false, remap = false },
    { "<leader>cm", "<cmd>! make<CR>",											desc = "make all", nowait = false, remap = false },
    { "<leader>cs", "<cmd>Telescope lsp_document_symbols<CR>",					desc = "document-symbols", nowait = false, remap = false },

	{ "<leader>d", group = "debug", nowait = false, remap = false },			-- [D]EBUG ------------------
    { "<leader>db", "<cmd>DebugBreakpoint<CR>",									desc = "toggle-Breakpoint", nowait = false, remap = false },
    { "<leader>dc", "<cmd>DebugContinue<CR>",									desc = "continue", nowait = false, remap = false },
    { "<leader>di", "<cmd>DebugStepInto<CR>",									desc = "step-into", nowait = false, remap = false },
    { "<leader>dm", "<cmd>!make debug<CR>",										desc = "make debug", nowait = false, remap = false },
    { "<leader>do", "<cmd>DebugStepOver<CR>",									desc = "step-over", nowait = false, remap = false },
    { "<leader>dr", "<cmd>DebugReplOpen<CR>",									desc = "open-repl", nowait = false, remap = false },

	{ "<leader>e", group = "edit/eval", nowait = false, remap = false },		-- [E]VAL / [E]DIT -------
    { "<leader>el", "<cmd>luafile %<CR>",										desc = "luafile", nowait = false, remap = false },
    { "<leader>ep", "<cmd>Runme<CR>",											desc = "program", nowait = false, remap = false },
    { "<leader>ev", "<cmd>source %<CR>",										desc = "source %", nowait = false, remap = false },

	{ "<leader>f", group = "file", nowait = false, remap = false },				-- [F]ILE ------------------- 
    { "<leader>ff", "<cmd>Telescope find_files<CR>",							desc = "files", nowait = false, remap = false },
    { "<leader>fF", "<cmd>Sex! $HOME/.config/nvim<CR>",							desc = "config-files", nowait = false, remap = false },
    { "<leader>fi", "<cmd>e $HOME/.config/nvim/init.lua<CR>",					desc = "init.lua", nowait = false, remap = false },
    { "<leader>fI", "<cmd>e $HOME/.config/nvim/vimscript/init.vim<CR>",			desc = "init.vim", nowait = false, remap = false },
    { "<leader>fk", "<cmd>e $HOME/.config/nvim/lua/external_plugins/whichkey.lua<CR>",	desc = "which-key", nowait = false, remap = false },
    { "<leader>fl", "<cmd>e $HOME/.config/nvim/lua/external_plugins/lsp.lua<CR>",		desc = "lsp", nowait = false, remap = false },
    { "<leader>fp", "<cmd>e $HOME/.config/nvim/lua/lazy_plugins.lua<CR>",		desc = "plugins.lua", nowait = false, remap = false },
    { "<leader>fq", "<cmd>e $HOME/.config/wezterm/wezterm.lua<CR>",				desc = "term-config", nowait = false, remap = false },
    { "<leader>fs", "<cmd>update<CR>",											desc = "save-file", nowait = false, remap = false },
    { "<leader>fS", "<cmd>e $HOME/.config/nvim/lua/settings.lua<CR>",			desc = "settings.lua", nowait = false, remap = false },
    { "<leader>ft", "<cmd>e $HOME/.config/nvim/vimscript/temp.vim<CR>",			desc = "temp.vim", nowait = false, remap = false },
    { "<leader>fT", "<cmd>e $HOME/.config/nvim/lua/temp.lua<CR>",				desc = "temp.lua", nowait = false, remap = false },
    { "<leader>fx", "<cmd>! rm -f $HOME/.local/share/nvim/swap/*<CR>",			desc = "delete-swap-files", nowait = false, remap = false },
    { "<leader>fX", "<cmd>! rm -f $HOME/.config/nvim/undodir/*<CR>",			desc = "delete-undo-files", nowait = false, remap = false },
    { "<leader>fw", "<cmd>e $HOME/.config/nvim/lua/external_plugins/whichkey.lua<CR>", desc = "which-key", nowait = false, remap = false },
    { "<leader>fz", "<cmd>e /Users/hari/.config/zellij/config.kdl<CR>",			desc = "which-key", nowait = false, remap = false },

	{ "<leader>g", group = "git", nowait = false, remap = false },				-- [G]IT --------------------  
    { "<leader>gB", "<cmd>Gitsigns blame<CR>",									desc = "BLAME", nowait = false, remap = false },
    { "<leader>gC", "<cmd>Telescope git_bcommits<CR>",							desc = "bcommits", nowait = false, remap = false },
    { "<leader>gS", "<cmd>Telescope git_stash<CR>",								desc = "stash", nowait = false, remap = false },
    { "<leader>gb", "<cmd>Gitsigns blame_line<CR>",								desc = "blame", nowait = false, remap = false },
    { "<leader>gc", "<cmd>Telescope git_commits<CR>",							desc = "commits", nowait = false, remap = false },
    { "<leader>gf", "<cmd>Telescope git_files<CR>",								desc = "git-files", nowait = false, remap = false },
    { "<leader>gg", "<cmd>Telescope git_status<CR>",							desc = "status", nowait = false, remap = false },

	{ "<leader>gh", group = "hunk", nowait = false, remap = false },			
    { "<leader>ghp", "<cmd>Gitsigns preview_hunk<CR>",							desc = "preview-hunk", nowait = false, remap = false },
    { "<leader>ghs", "<cmd>Gitsigns stage_hunk<CR>",							desc = "stage-hunk", nowait = false, remap = false },
    { "<leader>ghu", "<cmd>Gitsigns undo_stage_hunk<CR>",						desc = "undo-stage-hunk", nowait = false, remap = false },
    { "<leader>ghv", "<cmd>Gitsigns select_hunk<CR>",							desc = "visual-select-hunk", nowait = false, remap = false },
    { "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>",							desc = "preview-hunk", nowait = false, remap = false },
    { "<leader>gy", "<cmd>Telescope git_branches<CR>",							desc = "branches", nowait = false, remap = false },

	{ "<leader>h", group = "help", nowait = false, remap = false },				-- [H]ELP -------------------
    { "<leader>hs", "<cmd>lua vim.lsp.buf.signature_help()<CR>",				desc = "lsp signature", nowait = false, remap = false },
    { "<leader>ht", "<cmd>Telescope colorscheme<CR>",							desc = "themes", nowait = false, remap = false },

	{ "<leader>i", group = "info", nowait = false, remap = false },				-- [I]NFO / [I]NSERT --------
    { "<leader>ib", "<cmd> !battery<CR>",										desc = "battery", nowait = false, remap = false },
    { "<leader>ic", "<cmd> !clock<CR>",											desc = "clock", nowait = false, remap = false },
    { "<leader>id", "<cmd> !date<CR>",											desc = "date-time", nowait = false, remap = false },
    { "<leader>il", "<cmd> !pwd;ls -la<CR>",									desc = "list-all-files", nowait = false, remap = false },
    { "<leader>im", "<cmd> !memory<CR>",										desc = "memory", nowait = false, remap = false },
    { "<leader>ip", "<cmd> !battery<CR>",										desc = "power-percent", nowait = false, remap = false },
    { "<leader>ir", "<cmd> !memory<CR>",										desc = "rar", nowait = false, remap = false },
    { "<leader>it", "<cmd> !clock<CR>",											desc = "date-time", nowait = false, remap = false },
    { "<leader>iu", "<cmd> !upt<CR>",											desc = "date-uptime", nowait = false, remap = false },
    { "<leader>iv", "<cmd> !volume<CR>",										desc = "volume", nowait = false, remap = false },

	{ "<leader>j", group = "tabs", nowait = false, remap = false },             -- TABS ------------
    { "<leader>j0", "<cmd>tabfirst<CR>",										desc = "first-tab", nowait = false, remap = false },
    { "<leader>j1", "<cmd>1tabnext<CR>", 										desc = "tab-1", nowait = false, remap = false },
    { "<leader>j2", "<cmd>2tabnext<CR>", 										desc = "tab-2", nowait = false, remap = false },
    { "<leader>j3", "<cmd>3tabnext<CR>", 										desc = "tab-3", nowait = false, remap = false },
    { "<leader>j4", "<cmd>4tabnext<CR>", 										desc = "tab-4", nowait = false, remap = false },
    { "<leader>j5", "<cmd>5tabnext<CR>", 										desc = "tab-5", nowait = false, remap = false },
    { "<leader>j6", "<cmd>6tabnext<CR>", 										desc = "tab-6", nowait = false, remap = false },
    { "<leader>j7", "<cmd>7tabnext<CR>", 										desc = "tab-7", nowait = false, remap = false },
    { "<leader>j8", "<cmd>8tabnext<CR>", 										desc = "tab-8", nowait = false, remap = false },
    { "<leader>j9", "<cmd>tablast<CR>",	 										desc = "last-tab", nowait = false, remap = false },
    { "<leader>jK", "<cmd>tabonly<CR>",  										desc = "only-current-tab", nowait = false, remap = false },
    { "<leader>jc", "<cmd>tabclose<CR>", 										desc = "close-tab", nowait = false, remap = false },
    { "<leader>jh", "<cmd>-tabmove<CR>", 										desc = "move-left", nowait = false, remap = false },
    { "<leader>ji", "<cmd>tabs<CR>",	 										desc = "info-tabs", nowait = false, remap = false },
    { "<leader>jk", "<cmd>tabclose<CR>", 										desc = "kill-tab", nowait = false, remap = false },
    { "<leader>jl", "<cmd>+tabmove<CR>", 										desc = "move-right", nowait = false, remap = false },
    { "<leader>jn", "<cmd>tabnew<CR>",   										desc = "new-tab", nowait = false, remap = false },

	{ "<leader>l", group = "lsp", nowait = false, remap = false },				-- [L]ANGUAGE ---------------- 
    { "<leader>lD", "<cmd>Telescope diagnostics<CR>",							desc = "workspace-diagnostics", nowait = false, remap = false },
    { "<leader>lI", "<cmd>LspInstallInfo<CR>",									desc = "lsp-install-info", nowait = false, remap = false },
    { "<leader>lL", "<cmd>lua vim.diagnostic.open_float()<CR>", 				desc = "line-diagnostics", nowait = false, remap = false },
    { "<leader>lR", "<cmd>LspRestart<CR>",										desc = "lsp-restart", nowait = false, remap = false },
    { "<leader>lS", "<cmd>Telescope lsp_workspace_symbols<CR>", 				desc = "workspace wymbols", nowait = false, remap = false },
    { "<leader>lT", "<cmd>LspStop<CR>",											desc = "lsp-stop", nowait = false, remap = false },
    { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>",					desc = "code-action", nowait = false, remap = false },
    { "<leader>ld", "",															desc = "document-diagnostics", nowait = false, remap = false },
    { "<leader>lf", "<cmd>lua vim.lsp.buf.type_definition()<CR>",				desc = "type-definition", nowait = false, remap = false },
    { "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<CR>",							desc = "hover", nowait = false, remap = false },
    { "<leader>li", "<cmd>LspInfo<CR>",											desc = "lsp-info", nowait = false, remap = false },
    { "<leader>ll", "<cmd>lua vim.diagnostic.open_float()<CR>",					desc = "cursor-diagnostics", nowait = false, remap = false },
    { "<leader>ln", "<cmd>lua vim.diagnostic.goto_next()",						desc = "next-diagnostic", nowait = false, remap = false },
    { "<leader>lp", "<cmd>lua vim.diagnostic.goto_prev()",						desc = "prev-diagnostic", nowait = false, remap = false },
    { "<leader>lq", "<cmd>Telescope quickfix<CR>",								desc = "quickfix", nowait = false, remap = false },
    { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>",						desc = "rename", nowait = false, remap = false },
    { "<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>",					desc = "doc symbols", nowait = false, remap = false },
    { "<leader>lt", "<cmd>LspStart<CR>",										desc = "Lsp-start", nowait = false, remap = false },
    { "<leader>lx", "<cmd>cclose<CR>",											desc = "close-quickfix", nowait = false, remap = false },

	{ "<leader>m", group = "make", nowait = false, remap = false },				-- [M]AKE -------------------
    { "<leader>mc", "<cmd>! make clean<CR>",									desc = "make clean", nowait = false, remap = false },
    { "<leader>md", "<cmd>! make debug<CR>", 									desc = "make debug", nowait = false, remap = false },
    { "<leader>ml", group = "link", nowait = false, remap = false },
    { "<leader>mll", "<cmd>echo 'does nothing'<CR>",							desc = "N/A", nowait = false, remap = false },
    { "<leader>mlt", "<cmd>echo 'does nothing'<CR>", 							desc = "N/A", nowait = false, remap = false },
    { "<leader>mm", "<cmd>! make<CR>",											desc = "make all", nowait = false, remap = false },
    { "<leader>mo", "<cmd>e Makefile<CR>",										desc = "open Makefile", nowait = false, remap = false },
    { "<leader>mt", "<cmd>! make test<CR>",										desc = "make test", nowait = false, remap = false },

	{ "<leader>n", group = "notes", nowait = false, remap = false },			-- [N]OTES -------------------

	{ "<leader>nb", group = "boat", nowait = false, remap = false },			---- news[b]oat --------------
    { "<leader>nbb", "<cmd>e $HOME/.config/newsboat/rss.yml<CR>",				desc = "boat/rss.yml", nowait = false, remap = false },
    { "<leader>nbc", "<cmd>! python $HOME/.config/newsboat/rss2urls.py<CR>",	desc = "boat-compile", nowait = false, remap = false },
    { "<leader>nbu", "<cmd>e $HOME/.config/newsboat/urls<CR>",					desc = "boat/urls", nowait = false, remap = false },
   
	{ "<leader>nj", group = "journal", nowait = false, remap = false },			---- [j]ournal ---------------
    { "<leader>njj", "<cmd>Sex! $HOME/my/org/journal/<CR>",						desc = "journal", nowait = false, remap = false },
    { "<leader>njs", "<cmd>Sex! $HOME/my/org/journal/<CR>",						desc = "journal", nowait = false, remap = false },

	{ "<leader>nr", group = "roam", nowait = false, remap = false },			---- [r]oam ------------------
    { "<leader>nrf", "<cmd>Sex! $HOME/my/org/roam/<CR>",						desc = "roam", nowait = false, remap = false },
    { "<leader>nri", "<cmd>echo 'does nothing'<CR>",							desc = "N/A", nowait = false, remap = false },
    { "<leader>nrr", "<cmd>Sex! $HOME/my/org/roam/<CR>",						desc = "roam", nowait = false, remap = false },

	{ "<leader>nt", group = "todo", nowait = false, remap = false },			---- [t]odo ------------------
    { "<leader>ntt", "<cmd>Sex! $HOME/.todo<CR>",								desc = "todo-list", nowait = false, remap = false },

	{ "<leader>o", group = "open", nowait = false, remap = false },				-- [O]PEN -------------------
    { "<leader>oe", "<cmd>NvimTreeToggle<CR>",									desc = "explorer", nowait = false, remap = false },
    { "<leader>ol", "<cmd>FloatermNew lazygit<CR>",								desc = "lazygit", nowait = false, remap = false },
    { "<leader>om", "<cmd>e Makefile<CR>",										desc = "Makefile", nowait = false, remap = false },
    { "<leader>on", "<cmd>messages<CR>",										desc = "notifications", nowait = false, remap = false },
    { "<leader>oo", "<cmd>Telescope treesitter<CR>",							desc = "symbols", nowait = false, remap = false },
    { "<leader>oP", "<cmd>Lazy<CR>",											desc = "plugin-manager", nowait = false, remap = false },
    { "<leader>or", "<cmd>FloatermNew ranger .<CR>",							desc = "ranger", nowait = false, remap = false },
    { "<leader>ot", "<cmd>FloatermToggle<CR>",									desc = "terminal", nowait = false, remap = false },
    { "<leader>oz", "<cmd>Telescope builtin<CR>",								desc = "telescope", nowait = false, remap = false },

	{ "<leader>q", group = "quit", nowait = false, remap = false },				-- [Q]UIT ------------------- 
    { "<leader>qa", "<cmd>qa<CR>",												desc = "quit all, unmodified", nowait = false, remap = false },
    { "<leader>qq", "<cmd>q<CR>",												desc = "quit file, unmodified", nowait = false, remap = false },
    { "<leader>qr", "<cmd>luafile $HOME/.config/nvim/init.lua<CR>",				desc = "reload", nowait = false, remap = false },
    { "<leader>qu", "<cmd>update<CR>",											desc = "update", nowait = false, remap = false },
    { "<leader>qw", "<cmd>wq<CR>",												desc = "save and quit", nowait = false, remap = false },

	{ "<leader>r", group = "reload", nowait = false, remap = false },			-- [R]ELOAD ----------------
    { "<leader>re", "<cmd>NvimTreeRefresh<CR>",									desc = "explorer", nowait = false, remap = false },
    { "<leader>rf", "<cmd>NvimTreeRefresh<CR>", 								desc = "explorer", nowait = false, remap = false },
    { "<leader>rr", "<cmd>source $HOME/.config/nvim/vimscript/init.vim<CR>",	desc = "source init.vim", nowait = false, remap = false },

	{ "<leader>s", group = "search", nowait = false, remap = false },			-- [S]EARCH ----------------
    { "<leader>sM", "<cmd>Telescope man_pages<CR>",								desc = "Man Pages", nowait = false, remap = false },
    { "<leader>sR", "<cmd>Telescope registers<CR>", 							desc = "Registers", nowait = false, remap = false },
    { "<leader>sb", "<cmd>Gitsigns blame_line<CR>", 							desc = "blame_line", nowait = false, remap = false },
    { "<leader>sd", "<cmd>!date<CR>",											desc = "show-datetime", nowait = false, remap = false },
    { "<leader>sf", "<cmd>Telescope find_files<CR>",							desc = "Find File", nowait = false, remap = false },
    { "<leader>sm", "<cmd>Telescope marks<CR>",									desc = "Marks", nowait = false, remap = false },
    { "<leader>sr", "<cmd>Telescope oldfiles<CR>",								desc = "Open Recent File", nowait = false, remap = false },
    { "<leader>st", "<cmd>!date<CR>",											desc = "show-datetime", nowait = false, remap = false },

	{ "<leader>t", group = "toggle", nowait = false, remap = false },			-- [T]OGGLE ----------------
    { "<leader>tG", "<cmd>%norm! g??<CR>",										desc = "gibberish-rot13", nowait = false, remap = false },
    { "<leader>tT", "<cmd>highlight Normal guibg=black<CR>",					desc = "bg-black", nowait = false, remap = false },
    { "<leader>tb", "<cmd>Gitsigns blame<CR>",									desc = "BLAME", nowait = false, remap = false },
    { "<leader>tc", '<cmd>execute "set colorcolumn=" . (&colorcolumn == "" ? "80" : "")<CR>', desc = "colorbar", nowait = false, remap = false },
    { "<leader>te", "<cmd>NvimTreeToggle<CR>",									desc = "explorer", nowait = false, remap = false },
    { "<leader>tf", "<cmd>NvimTreeToggle<CR>",									desc = "explorer", nowait = false, remap = false },
    { "<leader>tg", "<cmd>Gitsigns toggle_signs<CR>",							desc = "git-signs", nowait = false, remap = false },
    { "<leader>th", "<cmd>set hls!<CR>",										desc = "hl-search", nowait = false, remap = false },
    { "<leader>tl", "<cmd>LspRestart<CR>",										desc = "lsp-restart", nowait = false, remap = false },
    { "<leader>tn", "<cmd>FloatermNew toggle_night<CR>",						desc = "night_filter", nowait = false, remap = false },
    { "<leader>to", "<cmd>call Cpp_Flip_Ext()<CR>",								desc = "CppFlip", nowait = false, remap = false },
    { "<leader>tp", "<cmd>TSPlaygroundToggle<CR>",								desc = "TSPlayground", nowait = false, remap = false },
    { "<leader>tr", "<cmd>set ro!<CR>",											desc = "read-only", nowait = false, remap = false },
    { "<leader>ts", "<cmd>set spell!<CR>",										desc = "spell-check", nowait = false, remap = false },
    { "<leader>tt", "<cmd>highlight Normal guibg=None<CR>",						desc = "bg-transparent", nowait = false, remap = false },
    { "<leader>tw", "<cmd>set nowrap!<CR>",										desc = "wrap-text", nowait = false, remap = false },

	{ "<leader>w", group = "window", nowait = false, remap = false },			-- [W]INDOW ----------------
    { "<leader>w+", "<C-w>>",													desc = "increase-height", nowait = false, remap = false },
    { "<leader>w-", "<C-w><", 													desc = "decrease-height", nowait = false, remap = false },
    { "<leader>w<", "<C-w><", 													desc = "decrease-width", nowait = false, remap = false },
    { "<leader>w=", "<C-w>=", 													desc = "equalize-window", nowait = false, remap = false },
    { "<leader>w>", "<C-w>>", 													desc = "increase-width", nowait = false, remap = false },
    { "<leader>wT", "<C-w>s", 													desc = "break-window-into-tab", nowait = false, remap = false },
    { "<leader>wc", "<C-w>c", 													desc = "close-window", nowait = false, remap = false },
    { "<leader>we", "<C-w>=", 													desc = "balance-window", nowait = false, remap = false },
    { "<leader>wh", "<C-w>h", 													desc = "left-window", nowait = false, remap = false },
    { "<leader>wj", "<C-w>j", 													desc = "bottom-window", nowait = false, remap = false },
    { "<leader>wk", "<C-w>k", 													desc = "top-window", nowait = false, remap = false },
    { "<leader>wl", "<C-w>l", 													desc = "right-window", nowait = false, remap = false },
    { "<leader>wm", "<cmd>only<CR>",											desc = "maximize-window", nowait = false, remap = false },
    { "<leader>wn", "<cmd>new<CR>",												desc = "new-window", nowait = false, remap = false },
    { "<leader>wo", "<cmd>only<CR>",											desc = "only-window", nowait = false, remap = false },
    { "<leader>wq", "<C-w>q",													desc = "quit-window", nowait = false, remap = false },
    { "<leader>ws", "<C-w>s", 													desc = "split-window-below", nowait = false, remap = false },
    { "<leader>wv", "<C-w>v", 													desc = "split-window-right", nowait = false, remap = false },
    { "<leader>ww", "<C-w>v", 													desc = "switch-window", nowait = false, remap = false },
    { "<leader>wx", "<C-w>v", 													desc = "swap-window", nowait = false, remap = false },
    { "<leader>w|", "<C-w><", 													desc = "max-out-width", nowait = false, remap = false },

	{ "<leader>x", group = "hop", nowait = false, remap = false },				-- MISC ----------------------
    { "<leader>xC", "<cmd>HopChar1<CR>",										desc = "hop-char1", nowait = false, remap = false },
    { "<leader>xa", "<cmd>HopChar2BC<CR>",										desc = "hop-char2-above", nowait = false, remap = false },
    { "<leader>xb", "<cmd>HopChar2AC<CR>",										desc = "hop-char2-below", nowait = false, remap = false },
    { "<leader>xc", "<cmd>HopChar2<CR>",										desc = "hop-char2", nowait = false, remap = false },

	{ "<leader>xl", group = "lines", nowait = false, remap = false },
    { "<leader>xlj", "<cmd>HopLineStartAC<CR>",									desc = "hop-lines-below", nowait = false, remap = false },
    { "<leader>xlk", "<cmd>HopLineStartBC<CR>", 								desc = "hop-lines-above", nowait = false, remap = false },
    { "<leader>xll", "<cmd>HopLineStart<CR>",									desc = "hop-lines", nowait = false, remap = false },

	{ "<leader>xp", "<cmd>HopPattern<CR>",										desc = "hop-pattern", nowait = false, remap = false },
    { "<leader>xw", group = "words", nowait = false, remap = false },

	{ "<leader>xwj", "<cmd>HopWordAC<CR>",										desc = "hop-words-below", nowait = false, remap = false },
    { "<leader>xwk", "<cmd>HopWordBC<CR>",										desc = "hop-words-above", nowait = false, remap = false },
    { "<leader>xww", "<cmd>HopWord<CR>",										desc = "hop-words", nowait = false, remap = false },

	{ "<leader>xx", "<cmd>HopChar2<CR>",										desc = "hop-char2", nowait = false, remap = false },

	{ "<leader>z", group = "telescope", nowait = false, remap = false },		-- FU[Z]ZY ---------------  
    { "<leader>zC", "<cmd>Telescope colorscheme<CR>",							desc = "colors", nowait = false, remap = false },
    { "<leader>zF", "<cmd>Telescope filetypes<CR>",								desc = "file type", nowait = false, remap = false },
    { "<leader>zH", "<cmd>Telescope command_history<CR>",						desc = "command-history", nowait = false, remap = false },
    { "<leader>zM", "<cmd>Telescope man_pages<CR>",								desc = "man pages", nowait = false, remap = false },
    { "<leader>zT", "<cmd>Telescope tags<CR>",									desc = "tags", nowait = false, remap = false },
    { "<leader>zZ", "<cmd>Telescope grep_string<CR>",							desc = "grep_string", nowait = false, remap = false },
    { "<leader>zb", "<cmd>Telescope buffers<CR>",								desc = "buffers", nowait = false, remap = false },
    { "<leader>zf", "<cmd>Telescope find_files<CR>",							desc = "files", nowait = false, remap = false },

	{ "<leader>zg", group = "git", nowait = false, remap = false },				---- [g]it ----------------
    { "<leader>zgS", "<cmd>Telescope git_stash<CR>",							desc = "stash", nowait = false, remap = false },
    { "<leader>zgb", "<cmd>Telescope git_commits<CR>",							desc = "commits", nowait = false, remap = false },
    { "<leader>zgf", "<cmd>Telescope git_files<CR>",							desc = "files", nowait = false, remap = false },
    { "<leader>zgs", "<cmd>Telescope git_status<CR>",							desc = "status", nowait = false, remap = false },

	{ "<leader>zh", "<cmd>Telescope help_tags<CR>",								desc = "Help tags", nowait = false, remap = false },
    { "<leader>zm", "<cmd>Telescope marks<CR>",									desc = "marks", nowait = false, remap = false },
    { "<leader>zr", "<cmd>Telescope registers<CR>",								desc = "registers", nowait = false, remap = false },

	{ "<leader>zs", group = "show", nowait = false, remap = false },			---- [s]earch ---------------
    { "<leader>zss", "<cmd>Telescope command_history<CR>",						desc = "command-history", nowait = false, remap = false },

	{ "<leader>zt", "<cmd>Telescope treesitter<CR>",							desc = "treesitter", nowait = false, remap = false },
    { "<leader>zv", "<cmd>Telescope commands<CR>",								desc = "vim-commands", nowait = false, remap = false },
    { "<leader>zw", "<cmd>Telescope file_browser<CR>",							desc = "file-browser", nowait = false, remap = false },
}

local visual_mappings = {
	{ "<leader>g", group = "git", nowait = false, remap = false },				-- [G]IT ------------------
	{ "<leader>gh", group = "git-hunk", nowait = false, remap = false },		---- [h]unk ---------------
    { "<leader>ghs", "<cmd>Gitsigns stage_hunk<CR>",							desc = "stage-hunk", nowait = false, remap = false },
    { "<leader>ghr", "<cmd>Gitsigns reset_hunk<CR>",							desc = "reset-hunk", nowait = false, remap = false },
}

local wk = require("which-key")
wk.add(normal_mappings)
-- wk.add(visual_mappings)


