-- lua/plugins/fzflua.lua

local winopts = {
    height = 0.99,
    width = 0.99,
    row = 0.35,
    col = 0.50,
    border = "rounded",
    backdrop = 60,
    ---@type "left" | "center" | "right"
    title_pos = "center",
    fullscreen = false, -- start fullscreen?
    treesitter = {
        enabled = true,
        fzf_colors = { ["hl"] = "-1:reverse", ["hl+"] = "-1:reverse" },
    },
    preview = {
        default = "bat",
        border = "rounded",
        wrap = false,
        hidden = false,
        vertical = "up:55%",
        horizontal = "right:60%",
        ---@type "horizontal" | "vertical" | "flex"
        layout = "vertical",
        flip_columns = 100,
        title = true,
        ---@type "left" | "center" | "right"
        title_pos = "right",
        ---@type false | "float" | "border"
        scrollbar = "float",
        scrolloff = -1,
        delay = 20,
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
    on_create = function() end,
    on_close = function() end,
}

local keymap = {
    builtin = {
        ["<M-Esc>"] = "hide",
        ["<F1>"] = "toggle-help",
        ["<F2>"] = "toggle-fullscreen",
        ["<F3>"] = "toggle-preview-wrap",
        ["<F4>"] = "toggle-preview",
        ["<F5>"] = "toggle-preview-ccw",
        ["<F6>"] = "toggle-preview-cw",
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
        ["f3"] = "toggle-preview-wrap",
        ["f4"] = "toggle-preview",
        ["shift-down"] = "preview-page-down",
        ["shift-up"] = "preview-page-up",
    },
}

local function setup_actions(actions)
    return {
        files = {
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
    ["--info"] = "inline-right",
    ["--height"] = "100%",
    ["--layout"] = "reverse",
    ["--border"] = "none",
    ["--highlight-line"] = true,
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
        cmd_deleted = "git diff --color HEAD --",
        cmd_modified = "git diff --color HEAD",
        cmd_untracked = "git diff --color --no-index /dev/null",
    },

    builtin = {
        syntax = true,
        syntax_limit_l = 0,
        syntax_limit_b = 1024 * 1024,
        limit_b = 1024 * 1024 * 10,
        treesitter = {
            enabled = true,
            disabled = {},
            context = { max_lines = 1, trim_scope = "inner" },
        },
        toggle_behavior = "default",
        extensions = {
            ["png"] = { "viu", "-b" },
            ["svg"] = { "chafa", "{file}" },
            ["jpg"] = { "ueberzug" },
        },
        ueberzug_scaler = "cover",
        render_markdown = { enabled = true, filetypes = { ["markdown"] = true } },
    },

    codeaction = { diff_opts = { ctxlen = 3 } },
    codeaction_native = { diff_opts = { ctxlen = 3 } },
}

local function setup_fzflua_keymaps()
    local keymap_set = require("config.helpers").keymap_set
    local fzflua = require("fzf-lua")

    keymap_set("n", "<M-x>", fzflua.commands, "commands")
    keymap_set("n", "gd", fzflua.lsp_definitions, "commands")
    keymap_set("n", "gr", fzflua.lsp_references, "commands")
    keymap_set("n", "gI", fzflua.lsp_implementations, "commands")

    keymap_set("n", "<leader>.", fzflua.files, "files")
    keymap_set("n", "<leader>bz", fzflua.grep_curbuf, "fzf-buffer-contents")

    keymap_set("n", "<leader>cF", fzflua.filetypes, "make-temp")
    keymap_set("n", "<leader>cs", fzflua.lsp_document_symbols, "lsp-document-symbols")
    keymap_set("n", "<leader>cS", fzflua.lsp_workspace_symbols, "lsp-workspace-symbols")
    keymap_set("n", "<leader>fc", function()
        fzflua.files({ cwd = vim.env.CUSTOM_PLUGIN_DIR })
    end, "custom-plugin-files")
    keymap_set("n", "<leader>ff", fzflua.oldfiles, "recent-files")
    keymap_set("n", "<leader>fp", function()
        fzflua.files({ cwd = vim.fn.stdpath("config") })
    end, "config-files")
    keymap_set("n", "<leader>gc", fzflua.git_commits, "commits")
    keymap_set("n", "<leader>gC", fzflua.git_bcommits, "buffer-commits")
    keymap_set("n", "<leader>gf", fzflua.git_bcommits, "buffer-commits")
    keymap_set("n", "<leader>gy", fzflua.git_branches, "branches")

    keymap_set("n", "<leader>hf", fzflua.builtin, "buitins")
    keymap_set("n", "<leader>hk", fzflua.keymaps, "keymaps")
    keymap_set("n", "<leader>ht", fzflua.colorschemes, "themes")
    keymap_set("n", "<leader>jJ", fzflua.tabs, "tabs")

    keymap_set("n", "<leader>l0", fzflua.lsp_outgoing_calls, "outgoing-calls")
    keymap_set("n", "<leader>l1", fzflua.lsp_incoming_calls, "incoming-calls")
    keymap_set("n", "<leader>ld", fzflua.diagnostics_document, "document-diagnostics")
    keymap_set("n", "<leader>lD", fzflua.diagnostics_workspace, "workspace-diagnostics")
    keymap_set("n", "<leader>lq", fzflua.loclist, "llist")
    keymap_set("n", "<leader>njs", function()
        fzflua.live_grep_resume({ cwd = vim.env.ORG_DIR .. "/journal" })
    end, "journal-search")
    keymap_set("n", "<leader>nrf", function()
        fzflua.files({ cwd = vim.env.ORG_DIR .. "/roam" })
    end, "find-org-roam-node")
    keymap_set("n", "<leader>ns", function()
        fzflua.live_grep_resume({ cwd = vim.env.ORG_DIR })
    end, "search-org-notes")
    keymap_set("n", "<leader>oo", fzflua.lsp_document_symbols, "outline-document")
    keymap_set("n", "<leader>oO", fzflua.lsp_workspace_symbols, "Outline-Workspace")
    keymap_set("n", "<leader>qq", fzflua.quickfix, "list-quickfix")

    keymap_set("n", "<leader>sr", fzflua.oldfiles, "recent-files")
    keymap_set("n", "<leader>ss", fzflua.grep_cword, "current-word")

    keymap_set("n", "<leader>z/", fzflua.search_history, "search-history")
    keymap_set("n", "<leader>z:", fzflua.command_history, "command-history")
    keymap_set("n", "<leader>z;", fzflua.command_history, "command-history")
    keymap_set("n", "<leader>z2", fzflua.registers, "registers")
    keymap_set("n", "<leader>z@", fzflua.registers, "registers")
    keymap_set("n", "<leader>za", fzflua.autocmds, "autocmds")
    keymap_set("n", "<leader>zb", fzflua.buffers, "buffers")
    keymap_set("n", "<leader>zd", fzflua.dap_commands, "dap-commands")
    keymap_set("n", "<leader>zf", function()
        fzflua.files({ cwd = "~/my/samples/lang" })
    end, "sample-lang-files")
    keymap_set("n", "<leader>zF", fzflua.filetypes, "filetypes")
    keymap_set("n", "<leader>zg", fzflua.git_status, "git-status")
    keymap_set("n", "<leader>zh", fzflua.help_tags, "help-tags")
    keymap_set("n", "<leader>zj", fzflua.jumps, "jumps")
    keymap_set("n", "<leader>zl", fzflua.loclist, "llist")
    keymap_set("n", "<leader>zL", fzflua.loclist_stack, "LLIST")
    keymap_set("n", "<leader>zm", fzflua.marks, "marks")
    keymap_set("n", "<leader>zM", fzflua.man_pages, "man-pages")
    keymap_set("n", "<leader>zo", fzflua.nvim_options, "options-nvim")
    keymap_set("n", "<leader>zr", fzflua.registers, "registers")
    keymap_set("n", "<leader>zq", fzflua.quickfix, "clist")
    keymap_set("n", "<leader>zQ", fzflua.quickfix_stack, "CLIST")
    keymap_set("n", "<leader>zv", fzflua.commands, "vim-commands")
    keymap_set("n", "<leader>zV", fzflua.command_history, "vim-command-history")
    keymap_set("n", "<leader>zx", fzflua.resume, "resume")
    keymap_set("n", "<leader>zz", function()
        fzflua.live_grep_resume({ cwd = "." })
    end, "live-grep")

    -- keymap_set("n", "<leader>zz", fzflua.live_grep_resume, "live-grep")

    keymap_set("x", "<leader>ss", fzflua.grep_visual, "grep-visual")
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
