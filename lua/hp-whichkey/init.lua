require("which-key").setup {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
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
	ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    hidden = {"<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
    show_help = true -- show help message on the command line when the popup is visible
}

local normal_layout_config = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false -- use `nowait` when creating keymaps
}

local visual_layout_config = {
    mode = "v", -- VISUAL mode
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
vim.api.nvim_set_keymap("n", "<leader>,", ":Telescope find_files<CR>", {noremap = true, silent = true})


-- TODO create entire treesitter section


local normal_mappings = {
    ["."] = "Sex!",
    [","] = "files",
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
        ["k"] = {"<cmd>bp | bd #<CR>"			, "kill-buffer"},
        ["K"] = {"<cmd>w | %bd | e#<CR><CR>"	, "only-curent-buffer"},
        ["l"] = {"<cmd>blast<CR>"				, "last-buffer"},
        ["n"] = {"<cmd>bnext<CR>"				, "next-buffer"},
        ["p"] = {"<cmd>bprevious<CR>"			, "previous-buffer"},
        ["t"] = {"<C-^>"						, "toggle-buffer"},
    },

	["c"] = {
	        name = "+code",
		["b"] = {"<cmd>FloatermNew git blame %<CR>"					,	"git-blame"},
		["f"] = {"<cmd>Telescope filetypes<CR>"				,	"filetype"},
	        ["m"] = {"<cmd>! make<CR>"						,	"make all"},
	        ["T"] = {"<cmd>! ctags -R *<CR>"				,	"ctags"},
		["s"] = {"<cmd>Telescope lsp_document_symbols<CR>"	,	"document-symbols"},
		["S"] = {"<cmd>Telescope lsp_workspace_symbols<CR>"	,	"workspace-symbols"},
	    },


    ["d"] = {
        name = "+debug",
        b = {"<cmd>DebugBreakpoint<CR>"			, "toggle-Breakpoint"},
        c = {"<cmd>DebugContinue<CR>"			, "continue"},
        i = {"<cmd>DebugStepInto<CR>"			, "step-into"},
        m = {"<cmd>!make debug<CR>"				, "make debug"},
        o = {"<cmd>DebugStepOver<CR>"			, "step-over"},
        r = {"<cmd>DebugReplOpen<CR>"			, "open-repl"},
        -- s = {"<cmd>DebugStart<CR>"				, "Start"}
    },

    ["e"] = {
        name = "+edit/eval",
		["v"] = {"<cmd>source %<CR>"										, "source %"},
		["l"] = {"<cmd>luafile %<CR>"										, "luafile"},
		["p"] = {"<cmd>Runme<CR>"											, "program"},
    },

    ["f"] = {
        name = "+file",
		["f"] = {"<cmd>Telescope find_files<CR>"							, "files"},
        ["F"] = {"<cmd>Sex! $HOME/.config/nvim<CR>"							, "config-files"},
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
        ["s"] = {"<cmd>lua vim.lsp.buf.signature_help()<CR>"	,	"lsp signature"},
        ["t"] = {"<cmd>Telescope colorscheme<CR>"				,	"themes"},
    },

    ["i"] = {
        name = "+info",
        ["b"] = {"<cmd> !battery<CR>"	,	"battery"},
        ["c"] = {"<cmd> !clock<CR>"		,	"clock"},
        ["d"] = {"<cmd> !date<CR>"		,	"date-time"},
        ["l"] = {"<cmd> !pwd;ls -la<CR>",	"list-all-files"},
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
		["K"] = {"<cmd>tabonly<CR>"			,	"only-current-tab"},
		["l"] = {"<cmd>+tabmove<CR>"		,	"move-right"},
		["n"] = {"<cmd>tabnew<CR>"			,	"new-tab"},
	},

    ["l"] = {
        name = "+lsp",
        ["a"] = {"<cmd>lua vim.lsp.buf.code_action()<CR>"		,	"code action"},
        ["d"] = {""												,	"document diagnostics"},
        ["D"] = {"<cmd>Telescope diagnostics<CR>"				,	"workspace diagnostics"},
        ["f"] = {"<cmd>lua vim.lsp.buf.type_definition()<CR>"	,	"type definition"},
        ["h"] = {"<cmd>lua vim.lsp.buf.hover()<CR>"				,	"hover"},
        ["i"] = {"<cmd>LspInfo<CR>"								,	"lsp info"},
        ["I"] = {"<cmd>LspInstallInfo<CR>"						,	"lsp install info"},
        ["l"] = {"<cmd>lua vim.diagnostic.open_float()<CR>"		,	"cursor diagnostics"},
        ["L"] = {"<cmd>lua vim.diagnostic.open_float()<CR>"		,	"line diagnostics"},
        ["n"] = {"<cmd>lua vim.diagnostic.goto_next()"			,	"next diagnostic"},
        ["p"] = {"<cmd>lua vim.diagnostic.goto_prev()"			,	"previous diagnostic"},
        ["q"] = {"<cmd>Telescope quickfix<CR>"					,	"quickfix"},
        ["r"] = {"<cmd>lua vim.lsp.buf.rename()<CR>"			,	"rename"},
        ["R"] = {"<cmd>LspRestart<CR>"							,	"LspRestart"},
        ["s"] = {"<cmd>Telescope lsp_document_symbols<CR>"		,	"doc symbols"},
        ["S"] = {"<cmd>Telescope lsp_workspace_symbols<CR>"		,	"workspace wymbols"},
        ["T"] = {"<cmd>LspStop<CR>"								,	"LspStop"},
        ["t"] = {"<cmd>LspStart<CR>"							,	"LspStart"},
        ["x"] = {"<cmd>cclose<CR>"								,	"Close Quickfix"},
    },

	["m"] = {
        name = "+make",
        ["c"] = {"<cmd>! make clean<CR>"		,	"make clean"},
		["d"] = {"<cmd>! make debug<CR>"		,	"make debug"},
		["l"] = {
			name = "+link",
			["l"] = {"<cmd>echo 'does nothing'<CR>"		,	"N/A"},
			["t"] = {"<cmd>echo 'does nothing'<CR>"		,	"N/A"},
		},
        ["m"] = {"<cmd>! make<CR>"				,	"make all"},
        ["o"] = {"<cmd>e Makefile<CR>"			,	"open Makefile"},
        ["t"] = {"<cmd>! make test<CR>"			,	"make test"},
    },

    ["n"] = {
		name = "+notes",
		["b"] = {
			name = "+boat",
			["b"] = {"<cmd>e $HOME/.config/newsboat/rss.yml<CR>"			,	"boat/rss.yml"},
			["c"] = {"<cmd>! python $HOME/.config/newsboat/rss2urls.py<CR>"	,	"boat-compile"},
			["u"] = {"<cmd>e $HOME/.config/newsboat/urls<CR>"				,	"boat/urls"},
		},
		["c"] = {
			name = "+codium",
			["i"] = {"<cmd>e $HOME/.config/VSCodium/User/nvim/init.vim<CR>"		,	"codium/init.vim"},
			["c"] = {"<cmd>e $HOME/.config/VSCodium/User/nvim/codium.vim<CR>"	,	"codium.vim"},
			["C"] = {"<cmd>e $HOME/.config/VSCodium/User/nvim/codium.lua<CR>"	,	"codium.lua"},
			["s"] = {"<cmd>Sex! $HOME/.config/VSCodium/User<CR>"				,	"codium-files"},
		},
		["e"] = {"<cmd>e $HOME/.config/espanso/default.yml<CR>"	,	"espanso"},
		["j"] = {
			name = "+journal",
			["j"] = {"<cmd>Sex! $HOME/my/org/journal/<CR>"		,	"journal"},
			["s"] = {"<cmd>Sex! $HOME/my/org/journal/<CR>"		,	"journal"},
		},
		["r"] = {
			name = "+roam",
			["f"] = {"<cmd>Sex! $HOME/my/org/roam/<CR>"			,	"roam"},
			["i"] = {"<cmd>echo 'does nothing'<CR>"				,	"N/A"},
			["r"] = {"<cmd>Sex! $HOME/my/org/roam/<CR>"			,	"roam"},
		},
		["t"] = {
			name = "+todo",
			["t"] = {"<cmd>Sex! $HOME/.todo<CR>"				,	"todo-list"},
		},
	},

    ["o"] = {
		name = "+open",
		["e"] = {"<cmd>NvimTreeToggle<CR>"			,	"explorer"},
		["l"] = {"<cmd>FloatermNew lazygit<CR>"	,	"lazygit"},
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
		["e"] = {"<cmd>NvimTreeRefresh<CR>"									,	"explorer"},
		["f"] = {"<cmd>NvimTreeRefresh<CR>"									,	"explorer"},
		["r"] = {"<cmd>source $HOME/.config/nvim/vimscript/init.vim<CR>"	,	"source init.vim"},
	},

    ["s"] = {
        name = "+search",
        ["b"] = {"<cmd>Gitsigns blame_line<CR>"					,	"blame_line"},
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
		["e"] = {"<cmd>NvimTreeToggle<CR>"					,	"explorer"},
		["f"] = {"<cmd>NvimTreeToggle<CR>"					,	"explorer"},
		["g"] = {'<cmd>Gitsigns toggle_signs<CR>'			,	"git-signs"},
		["G"] = {'<cmd>%norm! g??<CR>'						,	"gibberish-rot13"},
		["h"] = {"<cmd>set hls!<CR>"						,	"hl-search"},
		["l"] = {"<cmd>LspRestart<CR>"						,	"lsp-restart"},
		["n"] = {"<cmd>FloatermNew toggle_night<CR>"		,	"night_filter"},
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
		["h"] = {"<C-w>h"			, 	"left-window"},
		["j"] = {"<C-w>j"			, 	"bottom-window"},
		["k"] = {"<C-w>k"			, 	"top-window"},
		["l"] = {"<C-w>l"			, 	"right-window"},
		["m"] = {"<cmd>only<CR>"	,	"maximize-window"},
		["n"] = {"<cmd>new<CR>"		,	"new-window"},
		["o"] = {"<cmd>only<CR>"	,	"only-window"},
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

    ["x"] = {
		name = "+hop",
		["a"] = {"<cmd>HopChar2BC<CR>"			,	"hop-char2-above"},
		["b"] = {"<cmd>HopChar2AC<CR>"			,	"hop-char2-below"},
		["c"] = {"<cmd>HopChar2<CR>"			,	"hop-char2"},
		["C"] = {"<cmd>HopChar1<CR>"			,	"hop-char1"},
		["l"] = {
			name = "+lines",
			["j"] = {"<cmd>HopLineStartAC<CR>"	, 	"hop-lines-below"},
			["k"] = {"<cmd>HopLineStartBC<CR>"	, 	"hop-lines-above"},
			["l"] = {"<cmd>HopLineStart<CR>"		, 	"hop-lines"},
		},
		["p"] = {"<cmd>HopPattern<CR>"		, 	"hop-pattern"},
		["w"] = {
			name = "+words",
			["j"] = {"<cmd>HopWordAC<CR>"	, 	"hop-words-below"},
			["k"] = {"<cmd>HopWordBC<CR>"	, 	"hop-words-above"},
			["w"] = {"<cmd>HopWord<CR>"		, 	"hop-words"},
		},
		["x"] = {"<cmd>HopChar2<CR>"			,	"hop-char2"},
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
		["t"] = {"<cmd>Telescope treesitter<CR>"		,	"treesitter"},
		["T"] = {"<cmd>Telescope tags<CR>"				,	"tags"},
		["v"] = {"<cmd>Telescope commands<CR>"			,	"vim-commands"},
		["w"] = {"<cmd>Telescope file_browser<CR>"		,	"file_browser"},
		["z"] = {"<cmd>FloatermNew rg .<CR>"			,	"live_grep"},
		["Z"] = {"<cmd>Telescope grep_string<CR>"		,	"grep_string"},
		["s"] = {
			name = "+show",
			["s"] = {"<cmd>Telescope command_history<CR>"	,	"command-history"},
		},
	},
}

local visual_mappings = {}


local wk = require("which-key")
wk.register(normal_mappings, normal_layout_config)
wk.register(visual_mappings, visual_layout_config)
