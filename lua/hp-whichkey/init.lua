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
    ["a"] = {
		name = "+action",
		["c"] = "+copy",
		["v"] = "+paste",
		["x"] = "+cut",
	},

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
        ["b"] = {"<cmd>! make test<CR>"			,	"make test"},
        ["c"] = {"<cmd>! make clean<CR>"		,	"make clean"},
		["f"] = {"<cmd>Telescope filetypes<CR>"	,	"filetype"},
        ["m"] = {"<cmd>! make<CR>"				,	"make all"},
        ["T"] = {"<cmd>! ctags -R *<CR>"		,	"ctags"},
		["o"] = {"<cmd>call Cpp_Flip_Ext()<CR>"	,	"CppFlip"},
    },


    ["d"] = {
        name = "+debug",
        -- b = {"<cmd>DebugToggleBreakpoint<CR>"	, "Toggle Breakpoint"},
        -- c = {"<cmd>DebugContinue<CR>"			, "Continue"},
        -- i = {"<cmd>DebugStepInto<CR>"			, "Step Into"},
        m = {"<cmd>!make debug<CR>"				, "make debug"},
        -- o = {"<cmd>DebugStepOver<CR>"			, "Step Over"},
        -- r = {"<cmd>DebugToggleRepl<CR>"			, "Toggle Repl"},
        -- s = {"<cmd>DebugStart<CR>"				, "Start"}
    },

    ["e"] = {
        name = "+edit/eval",
		["l"] = {"<cmd>luafile %<CR>"										, "eval luafile"},
		["r"] = {"<cmd>luafile $HOME/.config/nvim/init.lua<CR>"				, "reload"},
    },

    ["f"] = {
        name = "+file",
        ["f"] = {"<cmd>Telescope find_files<CR>"							, "Files"},
        ["F"] = {"<cmd>Sex! $HOME/.config/nvim<CR>"							, "Files"},
        ["i"] = {"<cmd>e $HOME/.config/nvim/init.lua<CR>"					, "init.lua"},
        ["I"] = {"<cmd>e $HOME/.config/nvim/vimscript/init.vim<CR>"			, "init.vim"},
        ["p"] = {"<cmd>e $HOME/.config/nvim/lua/plugins.lua<CR>"			, "plugins.lua"},
        ["k"] = {"<cmd>e $HOME/.config/nvim/lua/hp-whichkey/init.lua<CR>"	, "which-key"},
        ["l"] = {"<cmd>e $HOME/.config/nvim/lua/hp-lsp/init.lua<CR>"		, "hp-lsp"},
        ["s"] = {"<cmd>update<CR>"											, "update-file"},
        ["S"] = {"<cmd>e $HOME/.config/nvim/lua/settings.lua<CR>"			, "settings.lua"},
        ["t"] = {"<cmd>e $HOME/.config/nvim/vimscript/temp.vim<CR>"			, "temp.vim"},
        ["T"] = {"<cmd>e $HOME/.config/nvim/lua/temp.lua<CR>"				, "temp.lua"},
        ["w"] = {"<cmd>e $HOME/.config/nvim/lua/hp-whichkey/init.lua<CR>"	, "which-key"},
        ["x"] = {"<cmd>! rm -f $HOME/.local/share/nvim/swap/*<CR>"			, "delete swap files"},
        ["X"] = {"<cmd>! rm -f $HOME/.config/nvim/undodir/*<CR>"			, "delete undo files"},
    },

    ["g"] = {
        name = "+git",
        ["b"] = {"<cmd>Telescope git_branches<CR>"	, "branches"},
		["c"] = {"<cmd>Telescope git_commits<CR>"	, "commits"},
		["C"] = {"<cmd>Telescope git_bcommits<CR>"	, "bcommits"},
        ["f"] = {"<cmd>Telescope git_files<CR>"		, "git_Files"},
        ["g"] = {"<cmd>Telescope git_status<CR>"	, "status"},
		["h"] = {
			name = "+hunk",
			["p"] = {"<cmd>Gitsigns preview_hunk<CR>"		, "preview-hunk"},
			["s"] = {"<cmd>Gitsigns stage_hunk<CR>"			, "stage-hunk"},
			["u"] = {"<cmd>Gitsigns undo_stage_hunk<CR>"	, "undo-stage-hunk"},
			["v"] = {"<cmd>Gitsigns select_hunk<CR>"		, "visual-select-hunk"},
		},
        ["p"] = {"<cmd>Gitsigns preview_hunk<CR>"	, "preview-hunk"},
        ["S"] = {"<cmd>Telescope git_stash<CR>"	    , "stash"},
    },

    ["h"] = {
        name = "+help",
        ["b"] = {"<cmd>! battery<CR>"				,	"battery"},
        ["t"] = {"<cmd>Telescope colorscheme<CR>"	,	"themes"},
    },

    ["i"] = {
        name = "+info",
        ["b"] = {"<cmd> !battery<CR>"	,	"battery"},
        ["c"] = {"<cmd> !clock<CR>"		,	"clock"},
        ["d"] = {"<cmd> !date<CR>"		,	"date-time"},
        ["l"] = {"<cmd> !ls -a<CR>"		,	"list-all-files"},
        ["m"] = {"<cmd> !memory<CR>"	,	"memory"},
        ["p"] = {"<cmd> !battery<CR>"	,	"power-percent"},
        ["r"] = {"<cmd> !memory<CR>"	,	"rar"},
        ["t"] = {"<cmd> !clock<CR>"		,	"date-time"},
        ["u"] = {"<cmd> !upt<CR>"		,	"date-uptime"},
        ["v"] = {"<cmd> !volume<CR>"	,	"volume"},
    },

    ["j"] = {
		name = "+tabs",
		["1"] = {"<cmd>1tabnext<CR>"		,	"tab-1"},
		["2"] = {"<cmd>2tabnext<CR>"		,	"tab-2"},
		["3"] = {"<cmd>3tabnext<CR>"		,	"tab-3"},
		["4"] = {"<cmd>4tabnext<CR>"		,	"tab-4"},
		["5"] = {"<cmd>5tabnext<CR>"		,	"tab-5"},
		["6"] = {"<cmd>6tabnext<CR>"		,	"tab-6"},
		["7"] = {"<cmd>7tabnext<CR>"		,	"tab-7"},
		["8"] = {"<cmd>8tabnext<CR>"		,	"tab-8"},
		["0"] = {"<cmd>tabfirst<CR>"		,	"first-tab"},
		["9"] = {"<cmd>tablast<CR>"			,	"last-tab"},
		["c"] = {"<cmd>tabclose<CR>"		,	"close-tab"},
		["h"] = {"<cmd>-tabmove<CR>"		,	"move-left"},
		["i"] = {"<cmd>tabs<CR>"			,	"info-tabs"},
		["k"] = {"<cmd>tabclose<CR>"		,	"kill-tab"},
		["K"] = {"<cmd>tabonly<CR>"			,	"only-open-tab"},
		["l"] = {"<cmd>+tabmove<CR>"		,	"move-right"},
		["n"] = {"<cmd>tabnew<CR>"			,	"new-tab"},
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

	["m"] = {
        name = "+code",
        ["c"] = {"<cmd>! make clean<CR>"		,	"make clean"},
		["d"] = {"<cmd>! make debug<CR>"		,	"make debug"},
        ["m"] = {"<cmd>! make<CR>"				,	"make all"},
        ["o"] = {"<cmd>e make<CR>"				,	"open Makefile"},
        ["t"] = {"<cmd>! make test<CR>"			,	"make test"},
    },

    ["n"] = {
		name = "+notes",
		["b"] = {
			name = "+boat",
			["b"] = {"<cmd>e $HOME/.config/newsboat/rss.yml<CR>"			,	"boat/rss.yml"},
			["c"] = {"<cmd>! python $HOME/.config/newsboat/rss2urls.py<CR>"	,	"boat-compile"},
			["u"] = {"<cmd>e /home/hari/.config/newsboat/urls<CR>"			,	"boat/urls"},
		},
		["c"] = {
			name = "+codium",
			["i"] = {"<cmd>e $HOME/.config/VSCodium/User/nvim/init.vim<CR>"		,	"codium/init.vim"},
			["c"] = {"<cmd>e $HOME/.config/VSCodium/User/nvim/codium.vim<CR>"	,	"codium.vim"},
			["C"] = {"<cmd>e $HOME/.config/VSCodium/User/nvim/codium.lua<CR>"	,	"codium.lua"},
			["s"] = {"<cmd>Sex! $HOME/.config/VSCodium/User<CR>"				,	"codium-files"},
		},
		["e"] = {"<cmd>e $HOME/.config/espanso/default.yml<CR>"		,	"espanso"},
		["j"] = {
			name = "+journal",
			["s"] = {"<cmd>Sex! $HOME/my/org/journal/<CR>"			,	"journal"},
		},
		["r"] = {
			name = "+roam",
			["r"] = {"<cmd>Sex! $HOME/my/org/roam/<CR>"				,	"roam"},
		},
		["t"] = {
			name = "+todo",
			["t"] = {"<cmd>Sex! $HOME/.todo<CR>"					,	"todo-list"},
			["n"] =														"new-todo",
		},
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
		["q"] = {"<cmd>q<CR>"									,	"quit file, unmodified"},
		["a"] = {"<cmd>qa<CR>"									,	"quit all, unmodified"},
		["u"] = {"<cmd>update<CR>"								,	"update"},
		["w"] = {"<cmd>wq<CR>"									,	"save and quit"},
		["r"] = {"<cmd>luafile $HOME/.config/nvim/init.lua<CR>"	,	"reload"},
	},

    ["r"] = {
		name = "+reload",
		["r"] = {"<cmd>luafile $HOME/.config/nvim/init.lua<CR>"	,	"reload"},
	},

    ["s"] = {
        name = "+search",
        ["b"] = {"<cmd>Telescope git_branches<CR>"				,	"File"},
        ["d"] = {"<cmd>!date<CR>"								,	"show-datetime"},
        ["f"] = {"<cmd>Telescope find_files<CR>"				,	"Find File"},
        ["m"] = {"<cmd>Telescope marks<CR>"						,	"Marks"},
        ["M"] = {"<cmd>Telescope man_pages<CR>"					,	"Man Pages"},
        ["r"] = {"<cmd>Telescope oldfiles<CR>"					,	"Open Recent File"},
        ["R"] = {"<cmd>Telescope registers<CR>"					,	"Registers"},
        ["t"] = {"<cmd>!date<CR>"								,	"show-datetime"},
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
		["h"] = {"<cmd>set hls!<CR>"						,	"hl-search"},
		["l"] = {"<cmd>LspStart<CR>"						,	"LspStart"},
		["L"] = {"<cmd>LspStop<CR>"							,	"LspStop"},
		["n"] = {"<cmd>FloatermNew nighton<CR>"				,	"nightlight on"},
		["N"] = {"<cmd>FloatermNew nightoff<CR>"			,	"nightlight off"},
		["o"] = {"<cmd>call Cpp_Flip_Ext()<CR>"				,	"CppFlip"},
		["p"] = {"<cmd>TSPlaygroundToggle<CR>"				,	"TSPlayground"},
		["r"] = {"<cmd>set ro!<CR>"							,	"read-only"},
		["s"] = {"<cmd>set spell!<CR>"						,	"spell-check"},
		["t"] = {"<cmd>highlight Normal guibg=None<CR>"		,	"bg-transparent"},
		["T"] = {"<cmd>highlight Normal guibg=black<CR>"	,	"bg-black"},
		["w"] = {"<cmd>set nowrap!<CR>"						,	"wrap-text"},
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
