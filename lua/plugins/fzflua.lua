-- lua/plugins/fzflua.lua

local winopts = {
    -- split = "belowright new",-- open in a split instead?
    -- "belowright new"  : split below
    -- "aboveleft new"   : split above
    -- "belowright vnew" : split right
    -- "aboveleft vnew   : split left
    -- Only valid when using a float window
    -- (i.e. when 'split' is not defined, default)
    height = 0.99, -- window height
    width = 0.99, -- window width
    row = 0.35, -- window row position (0=top, 1=bottom)
    col = 0.50, -- window col position (0=left, 1=right)
    -- border argument passthrough to nvim_open_win()
    border = "rounded",
    -- Backdrop opacity, 0 is fully opaque, 100 is fully transparent (i.e. disabled)
    backdrop = 60,
    -- title         = "Title",
    ---@type "left" | "center" | "right"
    title_pos = "center",
    -- title_flags   = false,           -- uncomment to disable title flags
    fullscreen = false, -- start fullscreen?
    -- enable treesitter highlighting for the main fzf window will only have
    -- effect where grep like results are present, i.e. "file:line:col:text"
    -- due to highlight color collisions will also override `fzf_colors`
    -- set `fzf_colors=false` or `fzf_colors.hl=...` to override
    treesitter = {
        enabled = true,
        fzf_colors = { ["hl"] = "-1:reverse", ["hl+"] = "-1:reverse" },
    },
    preview = {
        default = "bat",
        border = "rounded", -- preview border: accepts both `nvim_open_win`
        -- and fzf values (e.g. "border-top", "none")
        -- native fzf previewers (bat/cat/git/etc)
        -- can also be set to `fun(winopts, metadata)`
        wrap = false,
        hidden = false,
        vertical = "up:55%", -- up|down:size
        horizontal = "right:60%", -- right|left:size
        ---@type "horizontal" | "vertical" | "flex"
        layout = "vertical",
        flip_columns = 100, -- #cols to switch to horizontal on flex
        -- Only used with the builtin previewer:
        title = true,
        ---@type "left" | "center" | "right"
        title_pos = "right",
        -- float:  in-window floating border
        -- border: in-border "block" marker
        ---@type false | "float" | "border"
        scrollbar = "float",
        scrolloff = -1, -- float scrollbar offset from right (applies only when scrollbar = 'float')
        delay = 20, -- delay(ms) displaying the preview (prevents lag on fast scrolling)
        winopts = {
            number = true,
            relativenumber = false,
            cursorline = true,
            cursorlineopt = "both",
            cursorcolumn = false,
            signcolumn = "no",
            list = false,
            foldenable = false,
            foldmethod = "manual",
        },
    },
    on_create = function()
        -- called once upon creation of the fzf main window
        -- can be used to add custom fzf-lua mappings, e.g:
        --   vim.keymap.set("t", "<C-j>", "<Down>", { silent = true, buffer = true })
    end,
    -- called once _after_ the fzf interface is closed
    -- on_close = function() ... end
}

local keymap = {
    builtin = {
        -- neovim `:tmap` mappings for the fzf win
        -- true,        -- uncomment to inherit all the below in your custom config
        ["<M-Esc>"] = "hide", -- hide fzf-lua, `:FzfLua resume` to continue
        ["<F1>"] = "toggle-help",
        ["<F2>"] = "toggle-fullscreen",
        -- Only valid with the 'builtin' previewer
        ["<F3>"] = "toggle-preview-wrap",
        ["<F4>"] = "toggle-preview",
        -- Rotate preview clockwise/counter-clockwise
        ["<F5>"] = "toggle-preview-ccw",
        ["<F6>"] = "toggle-preview-cw",
        -- `ts-ctx` binds require `nvim-treesitter-context`
        ["<F7>"] = "toggle-preview-ts-ctx",
        ["<F8>"] = "preview-ts-ctx-dec",
        ["<F9>"] = "preview-ts-ctx-inc",
        ["<S-Left>"] = "preview-reset",
        ["<S-down>"] = "preview-page-down",
        ["<S-up>"] = "preview-page-up",
        ["<M-S-down>"] = "preview-down",
        ["<M-S-up>"] = "preview-up",
    },

    fzf = {
        -- fzf '--bind=' options
        -- true,        -- uncomment to inherit all the below in your custom config
        ["ctrl-z"] = "abort",
        ["ctrl-u"] = "unix-line-discard",
        ["ctrl-f"] = "half-page-down",
        ["ctrl-b"] = "half-page-up",
        ["ctrl-a"] = "beginning-of-line",
        ["ctrl-e"] = "end-of-line",
        ["alt-a"] = "toggle-all",
        ["alt-g"] = "first",
        ["alt-G"] = "last",
        ["alt-t"] = "toggle-preview",
        -- Only valid with fzf previewers (bat/cat/git/etc)
        ["f3"] = "toggle-preview-wrap",
        ["f4"] = "toggle-preview",
        ["shift-down"] = "preview-page-down",
        ["shift-up"] = "preview-page-up",
    },
}

local function setup_actions(actions)
    return {
        -- Below are the default actions, setting any value in these tables will override
        -- the defaults, to inherit from the defaults change [1] from `false` to `true`
        files = {
            -- true,        -- uncomment to inherit all the below in your custom config
            -- Pickers inheriting these actions:
            --   files, git_files, git_status, grep, lsp, oldfiles, quickfix, loclist,
            --   tags, btags, args, buffers, tabs, lines, blines
            -- `file_edit_or_qf` opens a single selection or sends multiple selection to quickfix
            -- replace `enter` with `file_edit` to open all files/bufs whether single or multiple
            -- replace `enter` with `file_switch_or_edit` to attempt a switch in current tab first
            ["enter"] = actions.file_edit_or_qf,
            ["alt-Q"] = actions.file_sel_to_ll,
            ["alt-f"] = actions.toggle_follow,
            ["alt-h"] = actions.toggle_hidden,
            ["alt-i"] = actions.toggle_ignore,
            ["alt-l"] = actions.file_sel_to_ll,
            ["alt-q"] = actions.file_sel_to_qf,
            ["ctrl-h"] = actions.toggle_hidden,
            ["ctrl-i"] = actions.toggle_ignore,
            ["ctrl-l"] = actions.file_sel_to_ll,
            ["ctrl-q"] = actions.file_sel_to_qf,
            ["ctrl-s"] = actions.file_split,
            ["ctrl-t"] = actions.file_tabedit,
            ["ctrl-v"] = actions.file_vsplit,
        },
    }
end

local fzf_opts = {
    ["--ansi"] = true,
    ["--info"] = "inline-right", -- fzf < v0.42 = "inline"
    ["--height"] = "100%",
    ["--layout"] = "reverse",
    ["--border"] = "none",
    ["--highlight-line"] = true, -- fzf >= v0.53
}

local fzf_colors = {
    true,
    ["fg"] = { "fg", "CursorLine" },
    ["bg"] = { "bg", "Normal" },
    ["hl"] = { "fg", "Comment" },
    ["fg+"] = { "fg", "Normal", "underline" },
    ["bg+"] = { "bg", { "CursorLine", "Normal" } },
    ["hl+"] = { "fg", "Statement" },
    ["info"] = { "fg", "PreProc" },
    ["prompt"] = { "fg", "Conditional" },
    ["pointer"] = { "fg", "Exception" },
    ["marker"] = { "fg", "Keyword" },
    ["spinner"] = { "fg", "Label" },
    ["header"] = { "fg", "Comment" },
    ["gutter"] = "-1",
}

local hls = {
    normal = "Normal",
    preview_normal = "Normal",
}

local previewers = {
    cat = { cmd = "cat", args = "-n" },
    bat = { cmd = "bat", args = "--color=always --style=numbers,changes" },
    head = { cmd = "head", args = nil },
    man = { cmd = "man -P cat %s | col -bx" },

    git_diff = {
        -- if required, use `{file}` for argument positioning
        -- e.g. `cmd_modified = "git diff --color HEAD {file} | cut -c -30"`
        cmd_deleted = "git diff --color HEAD --",
        cmd_modified = "git diff --color HEAD",
        cmd_untracked = "git diff --color --no-index /dev/null",
        -- git-delta is automatically detected as pager, set `pager=false`
        -- to disable, can also be set under 'git.status.preview_pager'
    },

    builtin = {
        syntax = true,
        syntax_limit_l = 0, -- syntax limit (lines), 0=nolimit
        syntax_limit_b = 1024 * 1024, -- syntax limit (bytes), 0=nolimit
        limit_b = 1024 * 1024 * 10, -- preview limit (bytes), 0=nolimit
        -- previewer treesitter options:
        -- enable specific filetypes with: `{ enabled = { "lua" } }
        -- exclude specific filetypes with: `{ disabled = { "lua" } }
        -- disable `nvim-treesitter-context` with `context = false`
        -- disable fully with: `treesitter = false` or `{ enabled = false }`
        treesitter = {
            enabled = true,
            disabled = {},
            -- nvim-treesitter-context config options
            context = { max_lines = 1, trim_scope = "inner" },
        },
        -- By default, the main window dimensions are calculated as if the
        -- preview is visible, when hidden the main window will extend to
        -- full size. Set the below to "extend" to prevent the main window
        -- from being modified when toggling the preview.
        toggle_behavior = "default",
        -- Title transform function, by default only displays the tail
        -- title_fnamemodify = function(s) vim.fn.fnamemodify(s, ":t") end,
        -- preview extensions using a custom shell command:
        -- for example, use `viu` for image previews
        -- will do nothing if `viu` isn't executable
        extensions = {
            -- neovim terminal only supports `viu` block output
            ["png"] = { "viu", "-b" },
            -- by default the filename is added as last argument
            -- if required, use `{file}` for argument positioning
            ["svg"] = { "chafa", "{file}" },
            ["jpg"] = { "ueberzug" },
        },
        -- if using `ueberzug` in the above extensions map
        -- set the default image scaler, possible scalers:
        --   false (none), "crop", "distort", "fit_contain",
        --   "contain", "forced_cover", "cover"
        -- https://github.com/seebye/ueberzug
        ueberzug_scaler = "cover",
        -- Custom filetype autocmds aren't triggered on
        -- the preview buffer, define them here instead
        -- ext_ft_override = { ["ksql"] = "sql", ... },
        -- render_markdown.nvim integration, enabled by default for markdown
        render_markdown = { enabled = true, filetypes = { ["markdown"] = true } },
    },

    -- Code Action previewers, default is "codeaction" (set via `lsp.code_actions.previewer`)
    -- "codeaction_native" uses fzf's native previewer, recommended when combined with git-delta
    -- options for vim.diff(): https://neovim.io/doc/user/lua.html#vim.diff()
    codeaction = { diff_opts = { ctxlen = 3 } },
    -- git-delta is automatically detected as pager, set `pager=false`
    -- to disable, can also be set under 'lsp.code_actions.preview_pager'
    -- recommended styling for delta
    --pager = [[delta --width=$COLUMNS --hunk-header-style="omit" --file-style="omit"]],
    codeaction_native = { diff_opts = { ctxlen = 3 } },
}

local function setup_fzflua_keymaps()
    local map = require("config.helpers").map
    local fzflua = require("fzf-lua")

    map("n", "<M-x>", fzflua.commands, "commands")
    map("n", "gd", fzflua.lsp_definitions, "commands")
    map("n", "gr", fzflua.lsp_references, "commands")
    map("n", "gI", fzflua.lsp_implementations, "commands")

    map("n", "<leader>.", fzflua.files, "files")
    map("n", "<leader>cF", fzflua.filetypes, "make-temp")
    map("n", "<leader>cs", fzflua.lsp_document_symbols, "lsp-document-symbols")
    map("n", "<leader>cS", fzflua.lsp_workspace_symbols, "lsp-workspace-symbols")
    map("n", "<leader>fc", function()
        fzflua.files({ cwd = vim.env.CUSTOM_PLUGIN_DIR })
    end, "custom-plugin-files")
    map("n", "<leader>ff", function()
        fzflua.files({ cwd = "~/my/samples/lang" })
    end, "sample-lang-files")
    map("n", "<leader>fp", function()
        fzflua.files({ cwd = vim.fn.stdpath("config") })
    end, "config-files")
    map("n", "<leader>gc", fzflua.git_commits, "commits")
    map("n", "<leader>gC", fzflua.git_bcommits, "buffer-commits")
    map("n", "<leader>gf", fzflua.git_files, "git-files")
    map("n", "<leader>gy", fzflua.git_branches, "branches")

    map("n", "<leader>hf", fzflua.builtin, "buitins")
    map("n", "<leader>hk", fzflua.keymaps, "keymaps")
    map("n", "<leader>ht", fzflua.colorschemes, "themes")
    map("n", "<leader>jJ", fzflua.tabs, "tabs")

    map("n", "<leader>l0", fzflua.lsp_outgoing_calls, "outgoing-calls")
    map("n", "<leader>l1", fzflua.lsp_incoming_calls, "incoming-calls")
    map("n", "<leader>ld", fzflua.diagnostics_document, "document-diagnostics")
    map("n", "<leader>lD", fzflua.diagnostics_workspace, "workspace-diagnostics")
    map("n", "<leader>lq", fzflua.loclist, "llist")
    map("n", "<leader>njs", function()
        fzflua.live_grep({ cwd = vim.env.ORG_DIR .. "/journal" })
    end, "journal-search")
    map("n", "<leader>nrf", function()
        fzflua.files({ cwd = vim.env.ORG_DIR .. "/roam" })
    end, "find-org-roam-node")
    map("n", "<leader>ns", function()
        fzflua.live_grep({ cwd = vim.env.ORG_DIR })
    end, "search-org-notes")
    map("n", "<leader>oo", fzflua.lsp_document_symbols, "document-symbols")
    map("n", "<leader>oO", fzflua.lsp_workspace_symbols, "workspace-symbols")
    map("n", "<leader>qq", fzflua.quickfix, "list-quickfix")

    map("n", "<leader>sb", fzflua.grep_curbuf, "current-buffer")
    map("n", "<leader>sf", fzflua.files, "files")
    map("n", "<leader>sh", fzflua.search_history, "history")
    map("n", "<leader>sm", fzflua.marks, "marks")
    map("n", "<leader>sM", fzflua.man_pages, "man-pages")
    map("n", "<leader>sr", fzflua.oldfiles, "recent-files")
    map("n", "<leader>sR", fzflua.registers, "registers")
    map("n", "<leader>ss", fzflua.grep_cword, "current-word")

    map("n", "<leader>za", fzflua.autocmds, "autocmds")
    map("n", "<leader>zb", fzflua.buffers, "buffers")
    map("n", "<leader>zB", fzflua.live_grep, "live-grep")
    map("n", "<leader>zc", fzflua.commands, "commands")
    map("n", "<leader>zd", fzflua.dap_commands, "dap-commands")
    map("n", "<leader>zf", fzflua.files, "files")
    map("n", "<leader>zF", fzflua.filetypes, "filetypes")
    map("n", "<leader>zg", fzflua.git_status, "git-status")
    map("n", "<leader>zh", fzflua.help_tags, "help-tags")
    map("n", "<leader>zj", fzflua.jumps, "jumps")
    map("n", "<leader>zl", fzflua.loclist, "llist")
    map("n", "<leader>zL", fzflua.loclist_stack, "llist-history")
    map("n", "<leader>zm", fzflua.marks, "marks")
    map("n", "<leader>zM", fzflua.man_pages, "man-pages")
    map("n", "<leader>zo", fzflua.nvim_options, "nvim-options")
    map("n", "<leader>zr", fzflua.oldfiles, "recent-files")
    map("n", "<leader>zR", fzflua.registers, "registers")
    map("n", "<leader>zq", fzflua.quickfix, "clist")
    map("n", "<leader>zQ", fzflua.quickfix_stack, "clist-history")
    map("n", "<leader>zv", fzflua.commands, "vim-commands")
    map("n", "<leader>zx", fzflua.resume, "resume")
    map("n", "<leader>zf", fzflua.files, "files")
    map("n", "<leader>zH", fzflua.command_history, "command-history")
    map("n", "<leader>zz", fzflua.live_grep, "live-grep")

    map("x", "<leader>ss", fzflua.grep_visual, "grep-visual")
end

local function setup_fzflua_config()
    local fzflua = require("fzf-lua")
    local fzflua_actions = require("fzf-lua").actions

    local opts = {
        winopts = winopts,
        keymap = keymap,
        actions = setup_actions(fzflua_actions),
        fzf_opts = fzf_opts,
        fzf_colors = fzf_colors,
        hls = hls,
        previewers = previewers,
    }

    fzflua.setup(opts)
    setup_fzflua_keymaps()
end

return {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    dependencies = { "echasnovski/mini.icons" },
    config = setup_fzflua_config,
}
