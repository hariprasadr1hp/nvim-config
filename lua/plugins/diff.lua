-- lua/plugins/git/diff.lua

local function setup_diffview_config()
    local actions = require("diffview.actions")

    local opts = {
        diff_binaries = false,
        enhanced_diff_hl = false,
        git_cmd = { "git" },
        hg_cmd = { "hg" },
        use_icons = true,
        show_help_hints = true,
        watch_index = true,

        icons = {
            folder_closed = "",
            folder_open = "",
        },

        signs = {
            fold_closed = "",
            fold_open = "",
            done = "✓",
        },

        view = {
            default = {
                layout = "diff2_horizontal",
                disable_diagnostics = false,
                winbar_info = false,
            },
            merge_tool = {
                layout = "diff3_horizontal",
                disable_diagnostics = true,
                winbar_info = true,
            },
            file_history = {
                layout = "diff2_horizontal",
                disable_diagnostics = false,
                winbar_info = false,
            },
        },

        file_panel = {
            listing_style = "tree",
            tree_options = {
                flatten_dirs = true,
                folder_statuses = "only_folded",
            },
            win_config = {
                position = "left",
                width = 35,
                win_opts = {},
            },
        },

        file_history_panel = {
            log_options = {
                git = {
                    single_file = {
                        diff_merges = "combined",
                    },
                    multi_file = {
                        diff_merges = "first-parent",
                    },
                },
                hg = {
                    single_file = {},
                    multi_file = {},
                },
            },
            win_config = { -- See |diffview-config-win_config|
                position = "bottom",
                height = 16,
                win_opts = {},
            },
        },

        commit_log_panel = {
            win_config = {}, -- See |diffview-config-win_config|
        },

        default_args = { -- Default args prepended to the arg-list for the listed commands
            DiffviewOpen = {},
            DiffviewFileHistory = {},
        },
        hooks = {}, -- See |diffview-config-hooks|
        keymaps = {
            disable_defaults = false, -- Disable the default keymaps
            view = {
                -- The `view` bindings are active in the diff buffers, only when the current
                -- tabpage is a Diffview.
                {
                    "n",
                    "<tab>",
                    actions.select_next_entry,
                    { desc = "Open the diff for the next file" },
                },
                {
                    "n",
                    "<s-tab>",
                    actions.select_prev_entry,
                    { desc = "Open the diff for the previous file" },
                },
                {
                    "n",
                    "[F",
                    actions.select_first_entry,
                    { desc = "Open the diff for the first file" },
                },
                {
                    "n",
                    "]F",
                    actions.select_last_entry,
                    { desc = "Open the diff for the last file" },
                },
                {
                    "n",
                    "gf",
                    actions.goto_file_edit,
                    { desc = "Open the file in the previous tabpage" },
                },
                {
                    "n",
                    "<C-w><C-f>",
                    actions.goto_file_split,
                    { desc = "Open the file in a new split" },
                },
                {
                    "n",
                    "<C-w>gf",
                    actions.goto_file_tab,
                    { desc = "Open the file in a new tabpage" },
                },
                {
                    "n",
                    "<leader>e",
                    actions.focus_files,
                    { desc = "Bring focus to the file panel" },
                },
                { "n", "<leader>b", actions.toggle_files, { desc = "Toggle the file panel." } },
                {
                    "n",
                    "g<C-x>",
                    actions.cycle_layout,
                    { desc = "Cycle through available layouts." },
                },
                {
                    "n",
                    "[x",
                    actions.prev_conflict,
                    { desc = "In the merge-tool: jump to the previous conflict" },
                },
                {
                    "n",
                    "]x",
                    actions.next_conflict,
                    { desc = "In the merge-tool: jump to the next conflict" },
                },
                {
                    "n",
                    "<leader>co",
                    actions.conflict_choose("ours"),
                    { desc = "Choose the OURS version of a conflict" },
                },
                {
                    "n",
                    "<leader>ct",
                    actions.conflict_choose("theirs"),
                    { desc = "Choose the THEIRS version of a conflict" },
                },
                {
                    "n",
                    "<leader>cb",
                    actions.conflict_choose("base"),
                    { desc = "Choose the BASE version of a conflict" },
                },
                {
                    "n",
                    "<leader>ca",
                    actions.conflict_choose("all"),
                    { desc = "Choose all the versions of a conflict" },
                },
                { "n", "dx", actions.conflict_choose("none"), { desc = "Delete the conflict region" } },
                {
                    "n",
                    "<leader>cO",
                    actions.conflict_choose_all("ours"),
                    { desc = "Choose the OURS version of a conflict for the whole file" },
                },
                {
                    "n",
                    "<leader>cT",
                    actions.conflict_choose_all("theirs"),
                    { desc = "Choose the THEIRS version of a conflict for the whole file" },
                },
                {
                    "n",
                    "<leader>cB",
                    actions.conflict_choose_all("base"),
                    { desc = "Choose the BASE version of a conflict for the whole file" },
                },
                {
                    "n",
                    "<leader>cA",
                    actions.conflict_choose_all("all"),
                    { desc = "Choose all the versions of a conflict for the whole file" },
                },
                {
                    "n",
                    "dX",
                    actions.conflict_choose_all("none"),
                    { desc = "Delete the conflict region for the whole file" },
                },
            },
            diff1 = {
                -- Mappings in single window diff layouts
                { "n", "g?", actions.help({ "view", "diff1" }), { desc = "Open the help panel" } },
            },
            diff2 = {
                -- Mappings in 2-way diff layouts
                { "n", "g?", actions.help({ "view", "diff2" }), { desc = "Open the help panel" } },
            },
            diff3 = {
                -- Mappings in 3-way diff layouts
                {
                    { "n", "x" },
                    "2do",
                    actions.diffget("ours"),
                    { desc = "Obtain the diff hunk from the OURS version of the file" },
                },
                {
                    { "n", "x" },
                    "3do",
                    actions.diffget("theirs"),
                    { desc = "Obtain the diff hunk from the THEIRS version of the file" },
                },
                { "n", "g?", actions.help({ "view", "diff3" }), { desc = "Open the help panel" } },
            },
            diff4 = {
                -- Mappings in 4-way diff layouts
                {
                    { "n", "x" },
                    "1do",
                    actions.diffget("base"),
                    { desc = "Obtain the diff hunk from the BASE version of the file" },
                },
                {
                    { "n", "x" },
                    "2do",
                    actions.diffget("ours"),
                    { desc = "Obtain the diff hunk from the OURS version of the file" },
                },
                {
                    { "n", "x" },
                    "3do",
                    actions.diffget("theirs"),
                    { desc = "Obtain the diff hunk from the THEIRS version of the file" },
                },
                { "n", "g?", actions.help({ "view", "diff4" }), { desc = "Open the help panel" } },
            },
            file_panel = {
                {
                    "n",
                    "j",
                    actions.next_entry,
                    { desc = "Bring the cursor to the next file entry" },
                },
                {
                    "n",
                    "<down>",
                    actions.next_entry,
                    { desc = "Bring the cursor to the next file entry" },
                },
                {
                    "n",
                    "k",
                    actions.prev_entry,
                    { desc = "Bring the cursor to the previous file entry" },
                },
                {
                    "n",
                    "<up>",
                    actions.prev_entry,
                    { desc = "Bring the cursor to the previous file entry" },
                },
                {
                    "n",
                    "<cr>",
                    actions.select_entry,
                    { desc = "Open the diff for the selected entry" },
                },
                {
                    "n",
                    "o",
                    actions.select_entry,
                    { desc = "Open the diff for the selected entry" },
                },
                {
                    "n",
                    "l",
                    actions.select_entry,
                    { desc = "Open the diff for the selected entry" },
                },
                {
                    "n",
                    "<2-LeftMouse>",
                    actions.select_entry,
                    { desc = "Open the diff for the selected entry" },
                },
                {
                    "n",
                    "-",
                    actions.toggle_stage_entry,
                    { desc = "Stage / unstage the selected entry" },
                },
                {
                    "n",
                    "s",
                    actions.toggle_stage_entry,
                    { desc = "Stage / unstage the selected entry" },
                },
                { "n", "S", actions.stage_all, { desc = "Stage all entries" } },
                { "n", "U", actions.unstage_all, { desc = "Unstage all entries" } },
                {
                    "n",
                    "X",
                    actions.restore_entry,
                    { desc = "Restore entry to the state on the left side" },
                },
                {
                    "n",
                    "L",
                    actions.open_commit_log,
                    { desc = "Open the commit log panel" },
                },
                { "n", "zo", actions.open_fold, { desc = "Expand fold" } },
                { "n", "h", actions.close_fold, { desc = "Collapse fold" } },
                { "n", "zc", actions.close_fold, { desc = "Collapse fold" } },
                { "n", "za", actions.toggle_fold, { desc = "Toggle fold" } },
                { "n", "zR", actions.open_all_folds, { desc = "Expand all folds" } },
                { "n", "zM", actions.close_all_folds, { desc = "Collapse all folds" } },
                { "n", "<c-b>", actions.scroll_view(-0.25), { desc = "Scroll the view up" } },
                { "n", "<c-f>", actions.scroll_view(0.25), { desc = "Scroll the view down" } },
                {
                    "n",
                    "<tab>",
                    actions.select_next_entry,
                    { desc = "Open the diff for the next file" },
                },
                {
                    "n",
                    "<s-tab>",
                    actions.select_prev_entry,
                    { desc = "Open the diff for the previous file" },
                },
                {
                    "n",
                    "[F",
                    actions.select_first_entry,
                    { desc = "Open the diff for the first file" },
                },
                {
                    "n",
                    "]F",
                    actions.select_last_entry,
                    { desc = "Open the diff for the last file" },
                },
                {
                    "n",
                    "gf",
                    actions.goto_file_edit,
                    { desc = "Open the file in the previous tabpage" },
                },
                {
                    "n",
                    "<C-w><C-f>",
                    actions.goto_file_split,
                    { desc = "Open the file in a new split" },
                },
                {
                    "n",
                    "<C-w>gf",
                    actions.goto_file_tab,
                    { desc = "Open the file in a new tabpage" },
                },
                {
                    "n",
                    "i",
                    actions.listing_style,
                    { desc = "Toggle between 'list' and 'tree' views" },
                },
                {
                    "n",
                    "f",
                    actions.toggle_flatten_dirs,
                    { desc = "Flatten empty subdirectories in tree listing style" },
                },
                {
                    "n",
                    "R",
                    actions.refresh_files,
                    { desc = "Update stats and entries in the file list" },
                },
                {
                    "n",
                    "<leader>e",
                    actions.focus_files,
                    { desc = "Bring focus to the file panel" },
                },
                { "n", "<leader>b", actions.toggle_files, { desc = "Toggle the file panel" } },
                { "n", "g<C-x>", actions.cycle_layout, { desc = "Cycle available layouts" } },
                {
                    "n",
                    "[x",
                    actions.prev_conflict,
                    { desc = "Go to the previous conflict" },
                },
                { "n", "]x", actions.next_conflict, { desc = "Go to the next conflict" } },
                { "n", "g?", actions.help("file_panel"), { desc = "Open the help panel" } },
                {
                    "n",
                    "<leader>cO",
                    actions.conflict_choose_all("ours"),
                    { desc = "Choose the OURS version of a conflict for the whole file" },
                },
                {
                    "n",
                    "<leader>cT",
                    actions.conflict_choose_all("theirs"),
                    { desc = "Choose the THEIRS version of a conflict for the whole file" },
                },
                {
                    "n",
                    "<leader>cB",
                    actions.conflict_choose_all("base"),
                    { desc = "Choose the BASE version of a conflict for the whole file" },
                },
                {
                    "n",
                    "<leader>cA",
                    actions.conflict_choose_all("all"),
                    { desc = "Choose all the versions of a conflict for the whole file" },
                },
                {
                    "n",
                    "dX",
                    actions.conflict_choose_all("none"),
                    { desc = "Delete the conflict region for the whole file" },
                },
            },
            file_history_panel = {
                { "n", "g!", actions.options, { desc = "Open the option panel" } },
                {
                    "n",
                    "<C-A-d>",
                    actions.open_in_diffview,
                    { desc = "Open the entry under the cursor in a diffview" },
                },
                {
                    "n",
                    "y",
                    actions.copy_hash,
                    { desc = "Copy the commit hash of the entry under the cursor" },
                },
                { "n", "L", actions.open_commit_log, { desc = "Show commit details" } },
                {
                    "n",
                    "X",
                    actions.restore_entry,
                    { desc = "Restore file to the state from the selected entry" },
                },
                { "n", "zo", actions.open_fold, { desc = "Expand fold" } },
                { "n", "zc", actions.close_fold, { desc = "Collapse fold" } },
                { "n", "h", actions.close_fold, { desc = "Collapse fold" } },
                { "n", "za", actions.toggle_fold, { desc = "Toggle fold" } },
                { "n", "zR", actions.open_all_folds, { desc = "Expand all folds" } },
                { "n", "zM", actions.close_all_folds, { desc = "Collapse all folds" } },
                {
                    "n",
                    "j",
                    actions.next_entry,
                    { desc = "Bring the cursor to the next file entry" },
                },
                {
                    "n",
                    "<down>",
                    actions.next_entry,
                    { desc = "Bring the cursor to the next file entry" },
                },
                {
                    "n",
                    "k",
                    actions.prev_entry,
                    { desc = "Bring the cursor to the previous file entry" },
                },
                {
                    "n",
                    "<up>",
                    actions.prev_entry,
                    { desc = "Bring the cursor to the previous file entry" },
                },
                {
                    "n",
                    "<cr>",
                    actions.select_entry,
                    { desc = "Open the diff for the selected entry" },
                },
                {
                    "n",
                    "o",
                    actions.select_entry,
                    { desc = "Open the diff for the selected entry" },
                },
                {
                    "n",
                    "l",
                    actions.select_entry,
                    { desc = "Open the diff for the selected entry" },
                },
                {
                    "n",
                    "<2-LeftMouse>",
                    actions.select_entry,
                    { desc = "Open the diff for the selected entry" },
                },
                { "n", "<c-b>", actions.scroll_view(-0.25), { desc = "Scroll the view up" } },
                { "n", "<c-f>", actions.scroll_view(0.25), { desc = "Scroll the view down" } },
                {
                    "n",
                    "<tab>",
                    actions.select_next_entry,
                    { desc = "Open the diff for the next file" },
                },
                {
                    "n",
                    "<s-tab>",
                    actions.select_prev_entry,
                    { desc = "Open the diff for the previous file" },
                },
                {
                    "n",
                    "[F",
                    actions.select_first_entry,
                    { desc = "Open the diff for the first file" },
                },
                {
                    "n",
                    "]F",
                    actions.select_last_entry,
                    { desc = "Open the diff for the last file" },
                },
                {
                    "n",
                    "gf",
                    actions.goto_file_edit,
                    { desc = "Open the file in the previous tabpage" },
                },
                {
                    "n",
                    "<C-w><C-f>",
                    actions.goto_file_split,
                    { desc = "Open the file in a new split" },
                },
                {
                    "n",
                    "<C-w>gf",
                    actions.goto_file_tab,
                    { desc = "Open the file in a new tabpage" },
                },
                {
                    "n",
                    "<leader>e",
                    actions.focus_files,
                    { desc = "Bring focus to the file panel" },
                },
                { "n", "<leader>b", actions.toggle_files, { desc = "Toggle the file panel" } },
                { "n", "g<C-x>", actions.cycle_layout, { desc = "Cycle available layouts" } },
                { "n", "g?", actions.help("file_history_panel"), { desc = "Open the help panel" } },
            },
            option_panel = {
                { "n", "<tab>", actions.select_entry, { desc = "Change the current option" } },
                { "n", "q", actions.close, { desc = "Close the panel" } },
                { "n", "g?", actions.help("option_panel"), { desc = "Open the help panel" } },
            },
            help_panel = {
                { "n", "q", actions.close, { desc = "Close help menu" } },
                { "n", "<esc>", actions.close, { desc = "Close help menu" } },
            },
        },
    }

    require("diffview").setup(opts)
end

return {
    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
        keys = {
            { "<leader>g/", mode = "x", "<cmd>'<,'>DiffviewFileHistory<cr>", desc = "visual-select-git-history" },
            { "<leader>g/", mode = "n", "<cmd>DiffviewFileHistory %<cr>", desc = "visual-select-git-history" },
            { "<leader>gG", "<cmd>DiffviewOpen --selected-file<cr>", desc = "open-diffview" },
            {
                "<leader>gdC",
                function()
                    -- TODO: use a picker to select the commit, instead of copying
                    local commit = vim.fn.getreg("+")
                    local cmd = string.format("DiffviewOpen %s^!", commit)
                    vim.notify(cmd)
                    vim.cmd(cmd)
                end,
                desc = "diff-show-commit",
            },
            { "<leader>gdm", "<cmd>DiffviewOpen -uno<cr>", desc = "diff-only-modified-no-untracked" },
            { "<leader>gdM", "<cmd>DiffviewOpen origin/main...HEAD<cr>", desc = "diff-head-against-main" },
            { "<leader>gdr", "<cmd>DiffviewRefresh<cr>", desc = "refresh-diffview" },
            {
                "<leader>gdn",
                function()
                    local commit = vim.fn.getreg("+")

                    vim.ui.input({ prompt = "number: ", default = "1" }, function(value)
                        if not tonumber(value) then
                            vim.notify("should be a number!")
                            return
                        end

                        local cmd = string.format("DiffviewOpen HEAD~%s", value)
                        vim.notify(cmd)
                        vim.cmd(cmd)
                    end)
                end,
                desc = "diff-from-last-N-commits",
            },
            { "<leader>gLo", "<cmd>DiffviewOpen HEAD~1<cr>", desc = "open-diffview" },
            { "<leader>of", "<cmd>DiffviewToggleFiles<cr>", desc = "open-diffview" },
        },
        config = setup_diffview_config,
    },
}

-- TODO: replay versioning?
