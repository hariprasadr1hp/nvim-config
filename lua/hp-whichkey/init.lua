require("which-key").setup {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        --[[ the presets plugin, adds help for a bunch of default keybindings in Neovim
        No actual key bindings are created --]]
        presets = {
            motions = true, -- adds help for motions
            operators = true, -- adds help for operators like d, y, ...
            windows = true, -- default bindings on <c-w>
            text_objects = true, -- help for text objects triggered after entering an operator
            z = true, -- bindings for folds, spelling and others prefixed with z
            nav = true, -- misc bindings to work with windows
            g = true -- bindings for prefixed with g
        }
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+" -- symbol prepended to a group
    },
    window = {
        border = "single", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = {1, 0, 1, 0}, -- extra window margin [top, right, bottom, left]
        padding = {2, 2, 2, 2} -- extra window padding [top, right, bottom, left]
    },
    layout = {
        height = {min = 4, max = 25}, -- min and max height of the columns
        width = {min = 20, max = 50}, -- min and max width of the columns
        spacing = 3 -- spacing between columns
    },
    hidden = {"<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
    show_help = true -- show help message on the command line when the popup is visible
}

-- local opts = {
--     mode = "n", -- NORMAL mode
--     prefix = "<leader>",
--     buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
--     silent = true, -- use `silent` when creating keymaps
--     noremap = true, -- use `noremap` when creating keymaps
--     nowait = false -- use `nowait` when creating keymaps
-- }

local layout_config = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false -- use `nowait` when creating keymaps
}

-- Set leader
vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', {noremap = true, silent = true})
vim.g.mapleader = ' '

-- no hl
--vim.api.nvim_set_keymap('n', '<Leader>h', ':set hlsearch!<CR>', {noremap = true, silent = true})

-- explorer
--vim.api.nvim_set_keymap('n', '<Leader>e', ':NvimTreeToggle<CR>', {noremap = true, silent = true})

-- vim.api.nvim_set_keymap('n', '<Leader>;', ':Dashboard<CR>', {noremap = true, silent = true})

-- dashboard
-- Comments
vim.api.nvim_set_keymap("n", "<leader>/", ":CommentToggle<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("v", "<leader>/", ":CommentToggle<CR>", {noremap = true, silent = true})

-- close buffer
-- vim.api.nvim_set_keymap("n", "<leader>c", ":BufferClose<CR>", {noremap = true, silent = true})

-- Explorer
vim.api.nvim_set_keymap("n", "<leader>.", ":Sex!<CR>", {noremap = true, silent = true})

-- TODO create entire treesitter section


local mappings = {
    ["."] = "Sex!",
    ["/"] = "comment",

    ["b"] = {
		name = "+buffer",
        ["B"] = {"<cmd>Telescope buffers<CR>"	, "fzf-buffer"},
        ["d"] = {"<cmd>bd<CR>"					, "kill-buffer"},
        ["f"] = {"<cmd>bfirst<CR>"				, "first-buffer"},
        ["k"] = {"<cmd>bd<CR>"					, "kill-buffer"},
        ["l"] = {"<cmd>blast<CR>"				, "last-buffer"},
        ["n"] = {"<cmd>bnext<CR>"				, "next-buffer"},
        ["p"] = {"<cmd>bprevious<CR>"			, "previous-buffer"},
        ["t"] = {"<C-^>"						, "toggle-buffer"},
    },

	["c"] = {
        name = "+code",
        ["c"] = {"<cmd>! make clean<CR>"		,	"make clean"},
		["f"] = {"<cmd>Telescope filetypes<CR>"	,	"filetype"},
        ["m"] = {"<cmd>! make<CR>"				,	"make"},
        ["t"] = {"<cmd>! ctags -R *<CR>"		,	"ctags"},
		["o"] = {"<cmd>call Cpp_Flip_Ext()<CR>"	,	"CppFlip"},
    },


--     ["d"] = {
--         name = "+Debug",
--         b = {"<cmd>DebugToggleBreakpoint<CR>"	, "Toggle Breakpoint"},
--         c = {"<cmd>DebugContinue<CR>"			, "Continue"},
--         i = {"<cmd>DebugStepInto<CR>"			, "Step Into"},
--         o = {"<cmd>DebugStepOver<CR>"			, "Step Over"},
--         r = {"<cmd>DebugToggleRepl<CR>"			, "Toggle Repl"},
--         s = {"<cmd>DebugStart<CR>"				, "Start"}
--     },

    ["e"] = {
        name = "+edit",
		["r"] = {"<cmd>luafile $HOME/.config/nvim/init.lua<CR>", "reload"},
        ["w"] = {"<cmd>e $HOME/.config/nvim/lua/hp-whichkey/init.lua<CR>", "which-key"},
    },

    ["f"] = {
        name = "+file",
        ["f"] = {"<cmd>Telescope find_files<CR>", "Files"},
        ["i"] = {"<cmd>e $HOME/.config/nvim/init.lua<CR>", "init.lua"},
        ["I"] = {"<cmd>e $HOME/.config/nvim/vimscript/init.vim<CR>", "init.vim"},
        ["p"] = {"<cmd>e $HOME/.config/nvim/lua/plugins.lua<CR>", "plugins.lua"},
        ["k"] = {"<cmd>e $HOME/.config/nvim/lua/hp-whichkey/init.lua<CR>", "which-key"},
        ["l"] = {"<cmd>e $HOME/.config/nvim/lua/hp-lsp/init.lua<CR>", "hp-lsp"},
        ["S"] = {"<cmd>Sex! $HOME/.config/nvim/lua/<CR>", "Sex!"},
        ["s"] = {"<cmd>update<CR>", "Files"},
        ["t"] = {"<cmd>e /home/hari/.config/nvim/vimscript/temp.vim<CR>", "temp.vim"},
        ["w"] = {"<cmd>e $HOME/.config/nvim/lua/hp-whichkey/init.lua<CR>", "which-key"},
        ["X"] = {"<cmd>! rm -f /home/hari/.config/nvim/undodir/*<CR>", "delete undo files"},
        ["x"] = {"<cmd>! rm -f $HOME/.local/share/nvim/swap/*<CR>", "delete swap files"},
    },

    ["g"] = {
        name = "+git",
        ["b"] = {"<cmd>Telescope git_branches<CR>"	, "branches"},
		["c"] = {"<cmd>Telescope git_commits<CR>"	, "commits"},
		["C"] = {"<cmd>Telescope git_bcommits<CR>"	, "bcommits"},
        ["f"] = {"<cmd>Telescope git_files<CR>"		, "git_Files"},
        ["g"] = {"<cmd>Telescope git_status<CR>"	, "status"},
        ["s"] = {"<cmd>Telescope git_stash<CR>"	    , "stash"},
    },

    ["h"] = {
        name = "+help",
        ["l"] = {"<cmd>help :lua<CR>"				,	":lua"},
        ["t"] = {"<cmd>Telescope colorscheme<CR>"	,	"Colors"},
    },

    ["l"] = {
        name = "+lsp",
        ["a"] = {"<cmd>Lspsaga code_action<CR>"					,	"code action"},
        ["A"] = {"<cmd>Lspsaga range_code_action<CR>"			,	"selected action"},
        ["d"] = {"<cmd>Telescope lsp_document_diagnostics<CR>"	,	"document diagnostics"},
        ["D"] = {"<cmd>Telescope lsp_workspace_diagnostics<CR>"	,	"workspace diagnostics"},
        ["f"] = {"<cmd>Lspsaga lsp_finder<CR>"					,	"lsp finder"},
        ["h"] = {"<cmd>Lspsaga hover_doc<CR>"					,	"hover_doc"},
        ["i"] = {"<cmd>LspInfo<CR>"								,	"lsp info"},
        ["l"] = {"<cmd>Lspsaga show_cursor_diagnostics<CR>"		,	"cursor diagnostics"},
        ["L"] = {"<cmd>Lspsaga show_line_diagnostics<CR>"		,	"line diagnostics"},
        ["p"] = {"<cmd>Lspsaga preview_definition<CR>"			,	"preview definition"},
        ["q"] = {"<cmd>Telescope quickfix<CR>"					,	"quickfix"},
        ["r"] = {"<cmd>Lspsaga rename<CR>"						,	"rename"},
        ["R"] = {"<cmd>LspRestart<CR>"							,	"LspRestart"},
        ["s"] = {"<cmd>Telescope lsp_document_symbols<CR>"		,	"doc symbols"},
        ["S"] = {"<cmd>Telescope lsp_workspace_symbols<CR>"		,	"workspace wymbols"},
        ["T"] = {"<cmd>LspStop<CR>"								,	"LspStop"},
        ["t"] = {"<cmd>LspStart<CR>"							,	"LspStart"},
        ["x"] = {"<cmd>cclose<CR>"								,	"Close Quickfix"},
    },

    ["n"] = {
		name = "+notes",
		["b"] = {"<cmd>e $HOME/.config/newsboat/rss.yml<CR>"	,	"boat"},
		["j"] = {"<cmd>Sex! $HOME/my/org/journal/<CR>"			,	"journal"},
		["r"] = {"<cmd>Sex! $HOME/my/org/roam/<CR>"				,	"roam"},
		["t"] = {"<cmd>Sex! $HOME/.todo<CR>"					,	"todo"},
	},

    ["o"] = {
		name = "+open",
		["m"] = {"<cmd>e Makefile<CR>"				,	"Makefile"},
		["r"] = {"<cmd>FloatermNew ranger .<CR>"	,	"ranger"},
		["t"] = {"<cmd>FloatermToggle<CR>"			,	"terminal"},
		["z"] = {"<cmd>Telescope builtin<CR>"		,	"telescope"},
	},

    ["q"] = {
		name = "+quit",
		["q"] = {"<cmd>q<CR>"		,	"quit file, unmodified"},
		["a"] = {"<cmd>qa<CR>"		,	"quit all, unmodified"},
		["u"] = {"<cmd>update<CR>"	,	"update"},
		["w"] = {"<cmd>wq<CR>"		,	"save and quit"},
		["r"] = {"<cmd>luafile $HOME/.config/nvim/init.lua<CR>", "reload"},
	},

    ["r"] = {
		name = "+reload",
		["r"] = {"<cmd>luafile $HOME/.config/nvim/init.lua<CR>", "reload"},
	},

    ["s"] = {
        name = "+search",
        ["b"] = {"<cmd>Telescope git_branches<CR>"	, "File"},
        ["f"] = {"<cmd>Telescope find_files<CR>"	, "Find File"},
        ["m"] = {"<cmd>Telescope marks<CR>"			, "Marks"},
        ["M"] = {"<cmd>Telescope man_pages<CR>"		, "Man Pages"},
        ["r"] = {"<cmd>Telescope oldfiles<CR>"		, "Open Recent File"},
        ["R"] = {"<cmd>Telescope registers<CR>"		, "Registers"},
        ["t"] = {"<cmd>Telescope live_grep<CR>"		, "Text"},
        ["d"] = {"<cmd>Telescope lsp_document_diagnostics<CR>"	, "Document Diagnostics"},
        ["D"] = {"<cmd>Telescope lsp_workspace_diagnostics<CR>"	, "Workspace Diagnostics"},
    },

	--     ["S"] = {
	-- 	name = "+Session",
	-- 	["s"] = {"<cmd>SessionSave<CR>"	,	"Save Session"},
	-- 	["l"] = {"<cmd>SessionLoad<CR>"	,	"Load Session"},
	-- },

    ["t"] = {
		name = "+toggle",
		["c"] = {'<cmd>execute "set colorcolumn=" . (&colorcolumn == "" ? "80" : "")<CR>' , "colorbar"},
		["g"] = {'<cmd>%norm! g??<CR>'						,	"gibberish-rot13"},
		["h"] = {"<cmd>set hls!<CR>"						,	"hlsearch"},
		["l"] = {"<cmd>LspStart<CR>"						,	"LspStart"},
		["L"] = {"<cmd>LspStop<CR>"							,	"LspStop"},
		["o"] = {"<cmd>call Cpp_Flip_Ext()<CR>"				,	"CppFlip"},
		["p"] = {"<cmd>TSPlaygroundToggle<CR>"				,	"TSPlayground"},
		["r"] = {"<cmd>set ro!<CR>"							,	"read-only"},
		["s"] = {"<cmd>set spell!<CR>"						,	"spell-check"},
		["t"] = {"<cmd>highlight Normal guibg=None<CR>"		,	"bg-transparent"},
		["T"] = {"<cmd>highlight Normal guibg=black<CR>"	,	"bg-black"},
	},

    ["w"] = {
		name = "+window",
		["c"] = {"<C-w>c"			,	"close-window"},
		["e"] = {"<C-w>="			, 	"balance-window"},
		["h"] = {"<C-w>h"			, 	"window-left"},
		["j"] = {"<C-w>j"			, 	"window-below"},
		["k"] = {"<C-w>k"			, 	"window-up"},
		["l"] = {"<C-w>l"			, 	"window-right"},
		["n"] = {"<cmd>new<CR>"		,	"new-window"},
		["q"] = {"<C-w>q"			,	"quit-window"},
		["s"] = {"<C-w>s"			,	"split-window-below"},
		["T"] = {"<C-w>s"			,	"break-window-into-tab"},
		["v"] = {"<C-w>v"			,	"split-window-right"},
		["w"] = {"<C-w>v"			,	"switch-window"},
		["x"] = {"<C-w>v"			,	"swap-window"},
		["="] = {"<C-w>="			,	"equalize-window"},
		[">"] = {"<C-w>>"			,	"increase-width"},
		["<"] = {"<C-w><"			,	"decrease-width"},
		["+"] = {"<C-w>>"			,	"increase-height"},
		["-"] = {"<C-w><"			,	"decrease-height"},
		["|"] = {"<C-w><"			,	"max-out-width"},
	},

    ["z"] = {
		name = "+telescope",
		["b"] = {"<cmd>Telescope buffers<CR>"			,	"buffers"},
		["C"] = {"<cmd>Telescope colorscheme<CR>"		,	"colors"},
		["c"] = {"<cmd>Telescope git_commits<CR>"		,	"commits"},
		["f"] = {"<cmd>Telescope find_files<CR>"		,	"files"},
		["F"] = {"<cmd>Telescope filetypes<CR>"			,	"file type"},
		["h"] = {"<cmd>Telescope help_tags<CR>"			,	"Help tags"},
		["H"] = {"<cmd>Telescope command_history<CR>"	,	"command-history"},
		["m"] = {"<cmd>Telescope marks<CR>"				,	"marks"},
		["M"] = {"<cmd>Telescope man_pages<CR>"			,	"man pages"},
		["r"] = {"<cmd>Telescope registers<CR>"			,	"registers"},
		["t"] = {"<cmd>Telescope tags<CR>"				,	"tags"},
		["v"] = {"<cmd>Telescope commands<CR>"			,	"vim-commands"},
		["w"] = {"<cmd>Telescope file_browser<CR>"		,	"file_browser"},
		["z"] = {"<cmd>Telescope live_grep<CR>"			,	"live_grep"},
		["Z"] = {"<cmd>Telescope grep_string<CR>"		,	"grep_string"},
		["s"] = {
			name = "+show",
			["s"] = {"<cmd>Telescope command_history<CR>"	,	"command-history"},
		},
	},
}

local wk = require("which-key")
-- wk.register(mappings, opts)
wk.register(mappings, layout_config)
