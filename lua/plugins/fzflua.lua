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

        ["<M-p>"] = "toggle-preview",
        ["<M-t>"] = "toggle-preview-cw",
        ["<M-S-t>"] = "toggle-preview-ccw",
        ["<M-/>"] = "toggle-help",
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
        ["alt-j"] = "preview-page-down",
        ["alt-k"] = "preview-page-up",
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
            ["ctrl-y"] = function(selected) -- yank result
                vim.fn.setreg("*", selected[1])
            end,
        },
    }
end

local fzf_opts = {
    ["--multi"] = true,
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
    keymap_set("n", "gd", fzflua.lsp_definitions, "lsp-definitions")
    keymap_set("n", "gr", fzflua.lsp_references, "lsp-references")
    keymap_set("n", "gI", fzflua.lsp_implementations, "lsp-implementations")

    -- TODO: `<leader>;z` to file-search only of filetype, same as the current file
    -- TODO: `<leader>;Z` to text-search in files of filetype, same as the current file

    keymap_set("n", "<leader>.", fzflua.files, "files")
    keymap_set("n", "<leader>agz", fzflua.args, "fzf-args")
    keymap_set("n", "<leader>bz", fzflua.grep_curbuf, "fzf-buffer-contents")

    keymap_set("n", "<leader>cF", fzflua.filetypes, "filetypes")
    keymap_set("n", "<leader>cs", fzflua.lsp_document_symbols, "lsp-document-symbols")
    keymap_set("n", "<leader>cS", fzflua.lsp_workspace_symbols, "lsp-workspace-symbols")

    keymap_set("n", "<leader>d.", fzflua.dap_breakpoints, "dap-breakpoints")
    keymap_set("n", "<leader>df", fzflua.dap_frames, "dap-frames")
    keymap_set("n", "<leader>dv", fzflua.dap_variables, "dap-variables")
    keymap_set("n", "<leader>dz", fzflua.dap_commands, "dap-commands")

    keymap_set("n", "<leader>fc", function()
        fzflua.files({ cwd = vim.env.ORG_DIR .. "/http" })
    end, "http-collections")
    keymap_set("n", "<leader>ff", fzflua.oldfiles, "recent-files")
    keymap_set("n", "<leader>fF", function()
        fzflua.files({ cwd = vim.fn.stdpath("config") .. "/lua/plugins/custom" })
    end, "custom-plugin-files")
    keymap_set("n", "<leader>fo", function()
        fzflua.files({ cwd = vim.env.CORPUS_DIR .. "/ontologies" })
    end, "ontologies")
    keymap_set("n", "<leader>fp", function()
        fzflua.files({ cwd = vim.fn.stdpath("config") })
    end, "config-files")
    keymap_set("n", "<leader>ft", function()
        fzflua.files({ cwd = "./tests" })
    end, "test-files")

    keymap_set("n", "<leader>gc", fzflua.git_commits, "commits")
    keymap_set("n", "<leader>gf", fzflua.git_bcommits, "buffer-commits")
    keymap_set("n", "<leader>gF", fzflua.git_files, "Files")
    keymap_set("n", "<leader>ghw", function()
        fzflua.files({ cwd = "./.github/workflows" })
    end, "gh-workflows")
    keymap_set("n", "<leader>gld", fzflua.git_diff, "last-commit-diffs")
    keymap_set("n", "<leader>gS", fzflua.git_stash, "Stashes")
    keymap_set("n", "<leader>gT", fzflua.git_tags, "Tags")
    keymap_set("n", "<leader>gW", fzflua.git_worktrees, "Worktrees")
    keymap_set("n", "<leader>gy", fzflua.git_branches, "branches")
    keymap_set("n", "<leader>g.", fzflua.git_files, "files")

    keymap_set("n", "<leader>hf", fzflua.builtin, "builtins")
    keymap_set("n", "<leader>hhz", fzflua.git_hunks, "git-hunks")
    keymap_set("n", "<leader>hk", fzflua.keymaps, "keymaps")
    keymap_set("n", "<leader>ht", fzflua.colorschemes, "themes")

    keymap_set("n", "<leader>jJ", fzflua.tabs, "tabwise-buffers")

    keymap_set("n", "<leader>l0", fzflua.lsp_outgoing_calls, "lsp-outgoing-calls")
    keymap_set("n", "<leader>l1", fzflua.lsp_incoming_calls, "lsp-incoming-calls")
    keymap_set("n", "<leader>ld", fzflua.lsp_declarations, "lsp-declarations")
    keymap_set("n", "<leader>lD", fzflua.lsp_definitions, "lsp-definitions")
    keymap_set("n", "<leader>le", fzflua.diagnostics_document, "diagnostics-document")
    keymap_set("n", "<leader>lE", fzflua.diagnostics_workspace, "Diagnostics-workspace")
    keymap_set("n", "<leader>lf", fzflua.lsp_references, "lsp-reFerences")
    keymap_set("n", "<leader>li", fzflua.lsp_implementations, "lsp-implementations")
    keymap_set("n", "<leader>lo", fzflua.lsp_document_symbols, "outline-document")
    keymap_set("n", "<leader>lO", fzflua.lsp_workspace_symbols, "Outline-Workspace")
    keymap_set("n", "<leader>lq", fzflua.loclist, "llist")
    keymap_set("n", "<leader>lR", fzflua.lsp_references, "lsp-references")
    keymap_set("n", "<leader>l,", fzflua.lsp_type_sub, "lsp-sub-type")
    keymap_set("n", "<leader>l.", fzflua.lsp_type_super, "lsp-super-type")

    keymap_set("n", "<leader>njs", function()
        fzflua.live_grep({ cwd = vim.env.ORG_DIR .. "/journal", resume = true })
    end, "journal-search")
    keymap_set("n", "<leader>nm", function()
        fzflua.files({ cwd = vim.env.CORPUS_DIR .. "/markdown" })
    end, "md-notes")
    keymap_set("n", "<leader>nrf", function()
        fzflua.files({ cwd = vim.env.ORG_DIR .. "/roam" })
    end, "find-org-roam-node")
    keymap_set("n", "<leader>ns", function()
        fzflua.live_grep({ cwd = vim.env.ORG_DIR, resume = true })
    end, "search-org-notes")

    keymap_set("n", "<leader>oo", fzflua.lsp_document_symbols, "outline-document")
    keymap_set("n", "<leader>oO", fzflua.lsp_workspace_symbols, "Outline-Workspace")

    keymap_set("n", "<leader>qq", fzflua.quickfix, "list-quickfix")
    keymap_set("n", "<leader>qQ", fzflua.loclist, "list-loclist")

    keymap_set("n", "<leader>scw", fzflua.grep_cword, "current-word")

    keymap_set("n", "<leader>ut", fzflua.undotree, "undo-tree")

    keymap_set("n", "<leader>z/", fzflua.search_history, "search-history")
    keymap_set("n", "<leader>z?", fzflua.help_tags, "help-tags")
    keymap_set("n", "<leader>z:", fzflua.command_history, "command-history")
    keymap_set("n", "<leader>z;", fzflua.command_history, "command-history")
    keymap_set("n", "<leader>z=", fzflua.spell_suggest, "spell-suggest")
    keymap_set("n", "<leader>z2", fzflua.registers, "registers")
    keymap_set("n", "<leader>z@", fzflua.registers, "registers")
    keymap_set("n", "<leader>za", fzflua.autocmds, "autocmds")
    keymap_set("n", "<leader>zb", fzflua.blines, "buffer-lines")
    keymap_set("n", "<leader>zc", fzflua.commands, "user-commands")
    keymap_set("n", "<leader>zd", fzflua.dap_commands, "dap-commands")
    keymap_set("n", "<leader>zf", fzflua.filetypes, "filetypes")
    keymap_set("n", "<leader>zF", function()
        fzflua.files({ cwd = "~/my/sample/filetypes/" })
    end, "sample-lang-files")
    keymap_set("n", "<leader>zgb", fzflua.git_blame, "git-blame")
    keymap_set("n", "<leader>zgd", fzflua.git_diff, "git-last-diff")
    keymap_set("n", "<leader>zgg", fzflua.git_status, "git-status")
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
    keymap_set("n", "<leader>zu", fzflua.undotree, "undo-tree")
    keymap_set("n", "<leader>zv", fzflua.commands, "vim-commands")
    keymap_set("n", "<leader>zV", fzflua.command_history, "vim-command-history")
    keymap_set("n", "<leader>zw", fzflua.lines, "workspace")
    keymap_set("n", "<leader>zx", fzflua.resume, "fzf-resume")
    keymap_set("n", "<leader>zz", function()
        fzflua.live_grep({ cwd = ".", resume = true })
    end, "live-grep")

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

-- TODO: how to add native cli arguments?
