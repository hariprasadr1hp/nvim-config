-- lua/plugins/whichkey.lua

local config_dir = vim.fn.stdpath("config")

local function setup_delay_function()
    return function(ctx)
        return ctx.plugin and 0 or 200
    end
end

local function setup_filter_function()
    return function(mapping)
        return mapping == true
    end
end

local function setup_defer_function()
    return function(ctx)
        return ctx.mode == "V" or ctx.mode == "<C-V>"
    end
end

local plugins = {
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

local win = {
    no_overlap = true,
    padding = { 1, 2 },
    title = true,
    title_pos = "center",
    zindex = 1000,
    bo = {},
    wo = {},
}

local layout = {
    height = { min = 14, max = 25 },
    width = { min = 20, max = 50 },
    spacing = 3,
}

local keys = {
    scroll_down = "<c-d>",
    scroll_up = "<c-u>",
}

local icons = {
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

local opts = {
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
    plugins = plugins,
    win = win,
    layout = layout,
    keys = keys,
    sort = { "local", "order", "group", "alphanum", "mod" },
    expand = 0,
    icons = icons,
    show_help = true,
    show_keys = true,
    disable = {
        ft = {},
        bt = {},
    },
    debug = false,
}

local key_maps = {
    --- NORMAL MODE
    {
        mode = "n",
        { "<C-`>", "<cmd>ToggleTerm<CR>", desc = "toggle-term", nowait = false, remap = false },
        { "<C-.><C-.>", "<cmd>NvimTreeToggle<CR>", desc = "toggle-term", nowait = false, remap = false },
        { "<C-w>a", ":WindowResizeModeEnter<CR>", desc = "resize-window-mode", nowait = false, remap = false },
        { "<M-x>", ":Telescope commands<CR>", desc = "telescope-commands", nowait = false, remap = false },

        { ",p", group = "swap-prev", nowait = false, remap = false },
        { ",n", group = "swap-next", nowait = false, remap = false },

        { "<leader>,", "<cmd>Pick files<CR>", desc = "files", nowait = false, remap = false },
        { "<leader>.", "<cmd>FzfLua files<CR>", desc = "files", nowait = false, remap = false },
        -- { "<leader>/", ":CommentToggle<CR>", desc = "comment", nowait = false, remap = false },

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
        { "<leader>bd", "<cmd>bd!<CR>", desc = "discard-changes", nowait = false, remap = false },
        { "<leader>bf", "<cmd>bfirst<CR>", desc = "first-buffer", nowait = false, remap = false },
        { "<leader>bi", "<cmd>buffers<CR>", desc = "info-tabs", nowait = false, remap = false },
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

        -- {
        --     "<leader>cf",
        --     function()
        --         conform.format({ async = true, lsp_format = "fallback" })
        --     end,
        --     desc = "format",
        --     nowait = false,
        --     remap = false,
        -- },

        { "<leader>cF", "<cmd>FzfLua filetypes<CR>", desc = "filetype", nowait = false, remap = false },
        {
            "<leader>cS",
            "<cmd>FzfLua lsp_workspace_symbols<CR>",
            desc = "workspace-symbols",
            nowait = false,
            remap = false,
        },
        { "<leader>cT", "<cmd>! ctags -R *<CR>", desc = "ctags", nowait = false, remap = false },
        { "<leader>cm", "<cmd>FloatermNew --autoclose=0 make<CR>", desc = "make all", nowait = false, remap = false },
        {
            "<leader>cs",
            "<cmd>FzfLua lsp_document_symbols<CR>",
            desc = "document-symbols",
            nowait = false,
            remap = false,
        },

        -- [D]EBUG ------------------
        { "<leader>d", group = "debug", nowait = false, remap = false },
        -- {
        --     "<leader>db",
        --     function()
        --         dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
        --     end,
        --     desc = "set-breakpoint",
        --     nowait = false,
        --     remap = false,
        -- },
        -- { "<leader>dd", "<cmd>DapContinue<CR>", desc = "continue", nowait = false, remap = false },
        -- { "<leader>di", "<cmd>DapStepInto<CR>", desc = "step-into", nowait = false, remap = false },
        -- { "<leader>do", "<cmd>DapStepOver<CR>", desc = "step-over", nowait = false, remap = false },
        -- {
        --     "<leader>dm",
        --     "<cmd>FloatermNew --autoclose=0 make debug<CR>",
        --     desc = "make debug",
        --     nowait = false,
        --     remap = false,
        -- },
        -- { "<leader>dr", "<cmd>DapToggleRepl<CR>", desc = "open-repl", nowait = false, remap = false },

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
            "<cmd>e " .. config_dir .. "/init.lua<CR>",
            desc = "init.lua",
            nowait = false,
            remap = false,
        },
        {
            "<leader>fI",
            "<cmd>e " .. config_dir .. "/vimscript/init.vim<CR>",
            desc = "init.vim",
            nowait = false,
            remap = false,
        },
        {
            "<leader>fk",
            "<cmd>e " .. config_dir .. "/lua/plugins/whichkey.lua<CR>",
            desc = "which-key",
            nowait = false,
            remap = false,
        },
        {
            "<leader>fl",
            "<cmd>e " .. config_dir .. "/lua/plugins/lspconfig.lua<CR>",
            desc = "lsp",
            nowait = false,
            remap = false,
        },
        {
            "<leader>fp",
            function()
                require("telescope.builtin").find_files({ cwd = config_dir })
            end,
            desc = "private-config",
            nowait = false,
            remap = false,
        },
        {
            "<leader>fP",
            "<cmd>e " .. config_dir .. "/lua/plugins/init.lua<CR>",
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
        { "<leader>fS", "<cmd>SaveWithNoFormat<CR>", desc = "save-file-wo-format", nowait = false, remap = false },
        {
            "<leader>fx",
            "<cmd>! rm -f $HOME/.local/state/nvim/swap/*<CR>",
            desc = "delete-swap-files",
            nowait = false,
            remap = false,
        },
        {
            "<leader>fX",
            "<cmd>! rm -f " .. config_dir .. "/undodir/*<CR>",
            desc = "delete-undo-files",
            nowait = false,
            remap = false,
        },
        {
            "<leader>fw",
            "<cmd>e " .. config_dir .. "/lua/plugins/whichkey.lua<CR>",
            desc = "whichkey-config",
            nowait = false,
            remap = false,
        },
        {
            "<leader>fz",
            "<cmd>e $HOME/.config/zellij/config.kdl<CR>",
            desc = "zellij-config",
            nowait = false,
            remap = false,
        },

        -- [G]IT --------------------
        { "<leader>g", group = "git", nowait = false, remap = false },
        { "<leader>gb", "<cmd>Gitsigns blame_line<CR>", desc = "blame-line", nowait = false, remap = false },
        { "<leader>gB", "<cmd>Gitsigns blame<CR>", desc = "blame", nowait = false, remap = false },
        { "<leader>gc", "<cmd>FzfLua git_commits<CR>", desc = "commits", nowait = false, remap = false },
        { "<leader>gC", "<cmd>FzfLua git_bcommits<CR>", desc = "bcommits", nowait = false, remap = false },
        { "<leader>gf", "<cmd>FzfLua git_files<CR>", desc = "git-files", nowait = false, remap = false },
        { "<leader>gg", "<cmd>Gitsigns preview_hunk_inline<CR>", desc = "preview-hunk", nowait = false, remap = false },
        { "<leader>gG", "<cmd>DiffviewOpen --selected-file<CR>", desc = "preview", nowait = false, remap = false },
        { "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", desc = "preview-hunk", nowait = false, remap = false },
        { "<leader>gS", "<cmd>FzfLua git_stash<CR>", desc = "stash", nowait = false, remap = false },
        { "<leader>gy", "<cmd>FzfLua git_branches<CR>", desc = "branches", nowait = false, remap = false },

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

        { "<leader>hk", "<cmd>FzfLua keymaps<CR>", desc = "describe-key", nowait = false, remap = false },
        { "<leader>hl", group = "harpoon", nowait = false, remap = false },
        { "<leader>hrr", "<cmd>echo '`emacs` command 🫠'<CR>", desc = "N/A", nowait = false, remap = false },
        {
            "<leader>hs",
            "<cmd>lua vim.lsp.buf.signature_help()<CR>",
            desc = "lsp signature",
            nowait = false,
            remap = false,
        },
        { "<leader>ht", "<cmd>FzfLua colorschemes<CR>", desc = "themes", nowait = false, remap = false },

        -- [I]NFO / [I]NSERT --------
        { "<leader>i", group = "info", nowait = false, remap = false },
        { "<leader>it", "<cmd>InspectTree<CR>", desc = "inspect-tree", nowait = false, remap = false },

        -- [J]TABS ------------
        { "<leader>j", group = "tabs", nowait = false, remap = false },
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
        { "<leader>jK", "<cmd>tabonly<CR>", desc = "kill-other-than-current-tab", nowait = false, remap = false },
        { "<leader>jh", "<cmd>-tabmove<CR>", desc = "move-left", nowait = false, remap = false },
        { "<leader>ji", "<cmd>tabs<CR>", desc = "info-tabs", nowait = false, remap = false },
        { "<leader>jk", "<cmd>tabclose<CR>", desc = "kill-tab", nowait = false, remap = false },
        { "<leader>jl", "<cmd>+tabmove<CR>", desc = "move-right", nowait = false, remap = false },
        { "<leader>jn", "<cmd>tabnew<CR>", desc = "new-tab", nowait = false, remap = false },
        { "<leader>jO", "<cmd>tabonly<CR>", desc = "only-current-tab", nowait = false, remap = false },

        -- [L]ANGUAGE ----------------
        { "<leader>l", group = "lsp", nowait = false, remap = false },

        {
            "<leader>la",
            "<cmd>lua vim.lsp.buf.code_action()<CR>",
            desc = "code-action",
            nowait = false,
            remap = false,
        },

        { "<leader>ld", "FzfLua diagnostics_document", desc = "document-diagnostics", nowait = false, remap = false },

        {
            "<leader>lD",
            "<cmd>FzfLua diagnostics_workspace<CR>",
            desc = "workspace-diagnostics",
            nowait = false,
            remap = false,
        },

        {
            "<leader>lf",
            "<cmd>lua vim.lsp.buf.type_definition()<CR>",
            desc = "goto-type-definition",
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

        {
            "<leader>ln",
            "<cmd>lua vim.diagnostic.goto_next()<CR>",
            desc = "next-diagnostic",
            nowait = false,
            remap = false,
        },

        { "<leader>lo", "<cmd>AerialToggle<CR>", desc = "outline", nowait = false, remap = false },

        {
            "<leader>lp",
            "<cmd>lua vim.diagnostic.goto_prev()<CR>",
            desc = "prev-diagnostic",
            nowait = false,
            remap = false,
        },

        { "<leader>lq", "<cmd>Telescope quickfix<CR>", desc = "quickfix", nowait = false, remap = false },
        { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "rename", nowait = false, remap = false },
        { "<leader>lR", "<cmd>LspRestart<CR>", desc = "restart", nowait = false, remap = false },
        { "<leader>lx", "<cmd>cclose<CR>", desc = "close-quickfix", nowait = false, remap = false },

        -- [M]AKE -------------------
        { "<leader>m", group = "prefix", nowait = false, remap = false },
        {
            "<leader>ma",
            "<cmd>FloatermNew --autoclose=0 make temp<CR>",
            desc = "make temp",
            nowait = false,
            remap = false,
        },
        {
            "<leader>mc",
            "<cmd>FloatermNew --autoclose=0 make clean<CR>",
            desc = "make clean",
            nowait = false,
            remap = false,
        },
        {
            "<leader>md",
            "<cmd>FloatermNew --autoclose=0 make debug<CR>",
            desc = "make debug",
            nowait = false,
            remap = false,
        },
        {
            "<leader>mf",
            "<cmd>FloatermNew --autoclose=0 make format<CR>",
            desc = "make format",
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
                require("telescope.builtin").find_files({ cwd = "$HOME/my/org/journal/" })
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
                require("telescope.builtin").find_files({ cwd = "$HOME/my/org/roam/" })
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
        { "<leader>on", "<cmd>messages<CR>", desc = "notifications", nowait = false, remap = false },
        -- { "<leader>on", "<cmd>NoiceAll<CR>", desc = "notifications", nowait = false, remap = false },
        {
            "<leader>oo",
            "<cmd>FzfLua lsp_document_symbols<CR>",
            desc = "document-symbols",
            nowait = false,
            remap = false,
        },
        {
            "<leader>oO",
            "<cmd>FzfLua lsp_workspace_symbols<CR>",
            desc = "document-symbols",
            nowait = false,
            remap = false,
        },
        { "<leader>oP", "<cmd>Lazy<CR>", desc = "plugin-manager", nowait = false, remap = false },
        { "<leader>or", "<cmd>FloatermNew ranger .<CR>", desc = "ranger", nowait = false, remap = false },
        { "<leader>ot", "<cmd>FloatermToggle<CR>", desc = "terminal", nowait = false, remap = false },
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
            "<cmd>luafile " .. config_dir .. "/init.lua<CR>",
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
            "<cmd>source " .. config_dir .. "/init.lua<CR>",
            desc = "source init.vim",
            nowait = false,
            remap = false,
        },

        -- [S]EARCH ----------------
        { "<leader>s", group = "search", nowait = false, remap = false },
        { "<leader>sb", "<cmd>FzfLua grep_curbuf<CR>", desc = "buffer", nowait = false, remap = false },
        { "<leader>sc", "<cmd>FzfLua grep_cword<CR>", desc = "current-word", nowait = false, remap = false },
        { "<leader>sd", "<cmd>!date<CR>", desc = "show-datetime", nowait = false, remap = false },
        { "<leader>sf", "<cmd>Telescope find_files<CR>", desc = "files", nowait = false, remap = false },
        { "<leader>sh", "<cmd>FzfLua search_history<CR>", desc = "history", nowait = false, remap = false },
        { "<leader>sm", "<cmd>FzfLua marks<CR>", desc = "marks", nowait = false, remap = false },
        { "<leader>sM", "<cmd>FzfLua man_pages<CR>", desc = "man-pages", nowait = false, remap = false },
        { "<leader>sr", "<cmd>FzfLua oldfiles<CR>", desc = "recent-file", nowait = false, remap = false },
        { "<leader>sR", "<cmd>FzfLua registers<CR>", desc = "registers", nowait = false, remap = false },
        { "<leader>ss", "<cmd>FzfLua grep_cword<CR>", desc = "current-word", nowait = false, remap = false },
        { "<leader>st", "<cmd>!date<CR>", desc = "show-datetime", nowait = false, remap = false },

        -- [T]OGGLE ----------------
        { "<leader>t", group = "toggle", nowait = false, remap = false },
        -- { "<leader>tb", "<cmd>DapToggleBreakpoint<CR>", desc = "toggle-Breakpoint", nowait = false, remap = false },
        { "<leader>tc", "<cmd>CloakPreviewLine<CR>", desc = "cloak-line", nowait = false, remap = false },
        { "<leader>tC", "<cmd>CloakToggle<CR>", desc = "cloak-file", nowait = false, remap = false },
        { "<leader>tg", "<cmd>Gitsigns toggle_signs<CR>", desc = "git-signs", nowait = false, remap = false },
        { "<leader>tG", "<cmd>%norm! g??<CR>", desc = "gibberish-rot13", nowait = false, remap = false },
        { "<leader>th", "<cmd>set hls!<CR>", desc = "hl-search", nowait = false, remap = false },
        { "<leader>tn", "<cmd>setl nu! rnu!<CR>", desc = "line-numbers", nowait = false, remap = false },
        { "<leader>tr", "<cmd>setl ro!<CR>", desc = "read-only", nowait = false, remap = false },
        { "<leader>ts", "<cmd>setl spell!<CR>", desc = "spell-check", nowait = false, remap = false },
        { "<leader>tT", "<cmd>highlight Normal guibg=black<CR>", desc = "bg-black", nowait = false, remap = false },
        {
            "<leader>tw",
            "<cmd>setlocal nowrap! linebreak breakindent<CR>",
            desc = "wrap-text",
            nowait = false,
            remap = false,
        },
        { "<leader>tz", "<cmd>ZenMode<CR>", desc = "wrap-text", nowait = false, remap = false },

        -- [W]INDOW ----------------
        { "<leader>w", group = "window", nowait = false, remap = false },
        { "<leader>w6", "<cmd>wincmd +<CR>", desc = "increase-height", nowait = false, remap = false },
        { "<leader>w7", "<cmd>wincmd -<CR>", desc = "decrease-height", nowait = false, remap = false },
        { "<leader>w9", "<cmd>wincmd <<CR>", desc = "decrease-width", nowait = false, remap = false },
        { "<leader>w0", "<cmd>wincmd ><CR>", desc = "increase-width", nowait = false, remap = false },
        { "<leader>w=", "<cmd>wincmd =<CR>", desc = "equalize-window", nowait = false, remap = false },
        { "<leader>wa", ":WindowResizeModeEnter<CR>", desc = "resize-window-mode", nowait = false, remap = false },
        { "<leader>wc", "<cmd>wincmd c<CR>", desc = "close-window", nowait = false, remap = false },
        { "<leader>we", "<cmd>RandomThemeGenerate<CR>", desc = "random-theme", nowait = false, remap = false },
        { "<leader>wh", "<cmd>wincmd h<CR>", desc = "left-window", nowait = false, remap = false },
        { "<leader>wj", "<cmd>wincmd j<CR>", desc = "bottom-window", nowait = false, remap = false },
        { "<leader>wk", "<cmd>wincmd k<CR>", desc = "top-window", nowait = false, remap = false },
        { "<leader>wl", "<cmd>wincmd l<CR>", desc = "right-window", nowait = false, remap = false },
        { "<leader>wm", "<cmd>wincmd |<CR>", desc = "maximize-window", nowait = false, remap = false },
        { "<leader>wn", "<cmd>new<CR>", desc = "new-window", nowait = false, remap = false },
        { "<leader>wO", "<cmd>only<CR>", desc = "only-current-window", nowait = false, remap = false },
        { "<leader>wq", "<cmd>wincmd q<CR>", desc = "quit-window", nowait = false, remap = false },
        { "<leader>ws", "<cmd>wincmd s<CR>", desc = "split-window-below", nowait = false, remap = false },
        { "<leader>wv", "<cmd>wincmd v<CR>", desc = "split-window-right", nowait = false, remap = false },
        { "<leader>ww", "<cmd>wincmd w<CR>", desc = "switch-window", nowait = false, remap = false },
        { "<leader>wx", "<cmd>wincmd x<CR>", desc = "swap-window", nowait = false, remap = false },
        { "<leader>w|", "<cmd>wincmd <<CR>", desc = "max-out-width", nowait = false, remap = false },

        -- MISC ----------------------
        { "<leader>x", group = "misc", nowait = false, remap = false },

        -- FU[Z]ZY ---------------
        { "<leader>z", group = "telescope", nowait = false, remap = false },
        { "<leader>za", "<cmd>Telescope autocommands<CR>", desc = "buffers", nowait = false, remap = false },
        { "<leader>zb", "<cmd>Telescope buffers<CR>", desc = "buffers", nowait = false, remap = false },
        { "<leader>zB", "<cmd>Telescope builtin<CR>", desc = "builtins", nowait = false, remap = false },
        { "<leader>zc", "<cmd>FzfLua commands<CR>", desc = "commands", nowait = false, remap = false },
        { "<leader>zd", "<cmd>FzfLua dap_commands<CR>", desc = "commands", nowait = false, remap = false },
        { "<leader>zf", "<cmd>Telescope find_files<CR>", desc = "files", nowait = false, remap = false },
        { "<leader>zF", "<cmd>FzfLua filetypes<CR>", desc = "file type", nowait = false, remap = false },
        {
            "<leader>zH",
            "<cmd>FzfLua command_history<CR>",
            desc = "command-history",
            nowait = false,
            remap = false,
        },

        ---- [g]it ----------------
        { "<leader>zg", group = "git", nowait = false, remap = false },
        { "<leader>zgS", "<cmd>FzfLua git_stash<CR>", desc = "stash", nowait = false, remap = false },
        { "<leader>zgb", "<cmd>FzfLua git_commits<CR>", desc = "commits", nowait = false, remap = false },
        { "<leader>zgf", "<cmd>FzfLua git_files<CR>", desc = "files", nowait = false, remap = false },
        { "<leader>zgs", "<cmd>FzfLua git_status<CR>", desc = "status", nowait = false, remap = false },

        { "<leader>zh", "<cmd>FzfLua help_tags<CR>", desc = "help-tags", nowait = false, remap = false },
        { "<leader>zj", "<cmd>FzfLua jumps<CR>", desc = "jumps", nowait = false, remap = false },
        { "<leader>zl", "<cmd>FzfLua loclist<CR>", desc = "llist", nowait = false, remap = false },
        { "<leader>zL", "<cmd>FzfLua loclist_stack<CR>", desc = "llist-history", nowait = false, remap = false },
        { "<leader>zm", "<cmd>FzfLua marks<CR>", desc = "marks", nowait = false, remap = false },
        { "<leader>zM", "<cmd>FzfLua man_pages<CR>", desc = "man-pages", nowait = false, remap = false },
        -- { "<leader>zn", "<cmd>NoiceTelescope<CR>", desc = "noice", nowait = false, remap = false },
        { "<leader>zo", "<cmd>FzfLua nvim_options<CR>", desc = "nvim-options", nowait = false, remap = false },
        { "<leader>zr", "<cmd>FzfLua registers<CR>", desc = "registers", nowait = false, remap = false },
        { "<leader>zq", "<cmd>FzfLua quickfix<CR>", desc = "clist", nowait = false, remap = false },
        { "<leader>zQ", "<cmd>FzfLua quickfix_stack<CR>", desc = "clist-history", nowait = false, remap = false },

        ---- [s]earch ---------------
        { "<leader>zs", group = "search", nowait = false, remap = false },
        {
            "<leader>zss",
            "<cmd>FzfLua command_history<CR>",
            desc = "command-history",
            nowait = false,
            remap = false,
        },

        { "<leader>zt", "<cmd>TodoTelescope keywords=TODO,FIX<CR>", desc = "todo", nowait = false, remap = false },
        { "<leader>zu", "<cmd>Telescope undo<CR>", desc = "undo", nowait = false, remap = false },
        { "<leader>zv", "<cmd>FzfLua commands<CR>", desc = "vim-commands", nowait = false, remap = false },
        { "<leader>zx", "<cmd>FzfLua resume<CR>", desc = "resume", nowait = false, remap = false },
        { "<leader>zz", "<cmd>FzfLua live_grep<CR>", desc = "live-grep", nowait = false, remap = false },
        { "<leader>zZ", "<cmd>Telescope grep_string<CR>", desc = "grep-string", nowait = false, remap = false },
    },

    --- VISUAL MODE
    {
        mode = "v",
        -- [G]IT ------------------
        { "<leader>g", group = "git", nowait = false, remap = false },

        -- [H]UNK ------------------
        { "<leader>hh", group = "git-hunk", nowait = false, remap = false },
        -- { "<leader>hhs", "<cmd>Gitsigns stage_hunk<CR>", desc = "stage-hunk", nowait = false, remap = false },
        -- { "<leader>hhu", "<cmd>Gitsigns undo_stage_hunk<CR>", desc = "unstage-hunk", nowait = false, remap = false },

        -- [S]EARCH -------------
        { "<leader>ss", "<cmd>FzfLua grep_visual<CR>", desc = "search", nowait = false, remap = false },

        -- [T]OGGLE -------------
        { "<leader>tG", "g?", desc = "gibberish-rot13", nowait = false, remap = false },
    },

    --- TERMINAL MODE
    {
        mode = "t",
        { "<C-`>", "<cmd>ToggleTerm<CR>", desc = "toggle-term", nowait = false, remap = false },
    },
}

local setup_whichkey = function()
    MiniDeps.add({
        source = "folke/which-key.nvim",
    })

    vim.api.nvim_create_autocmd("BufWinEnter", {
        once = true,
        callback = function()
            local wk = require("which-key")
            wk.setup(opts)
            wk.add(key_maps)
        end,
    })
end

-- MiniDeps.later(setup_whichkey)
setup_whichkey()
