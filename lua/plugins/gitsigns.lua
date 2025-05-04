-- lua/plugins/git/gitsigns.lua

local signs = {
    add = { text = "" },
    change = { text = "" },
    delete = { text = "" },
    topdelete = { text = "" },
    changedelete = { text = "" },
    untracked = { text = "" },
}

local signs_staged = {
    add = { text = "┃" },
    change = { text = "┃" },
    delete = { text = "▁" },
    topdelete = { text = "▔" },
    changedelete = { text = "~" },
}

local blame_opts = {
    virt_text = true,
    ---@type "eol" | "overlay" | "right_align"
    virt_text_pos = "right_align",
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
}

local preview_config = {
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
}

local function setup_on_attach()
    ---@diagnostic disable-next-line: unused-local
    return function(bufnr)
        local keymap_set = require("config.helpers").keymap_set
        local gitsigns = require("gitsigns")

        keymap_set("n", "<leader>gb", gitsigns.blame_line, "blame-line")
        keymap_set("n", "<leader>gB", gitsigns.blame, "blame")
        keymap_set("n", "<leader>gg", gitsigns.preview_hunk_inline, "preview-hunk")
        keymap_set("n", "<leader>tg", gitsigns.toggle_signs, "preview-hunk")

        keymap_set("n", "<leader>hhs", gitsigns.stage_hunk, "stage-hunk")
        -- map("n", "<leader>hhu", gitsigns.unstage_hunk, "unstage-hunk")
        -- map("v", "<leader>hhv", gitsigns.select_hunk, "visual-select-hunk")

        keymap_set("x", "<leader>hhs", gitsigns.stage_hunk, "stage-hunk")
        -- map("x", "<leader>hhu", gitsigns.unstage_hunk, "unstage-hunk")

        keymap_set("n", "<leader>hhp", function()
            gitsigns.nav_hunk("prev")
        end, "preview-hunk")
        keymap_set("n", "<leader>hhn", function()
            gitsigns.nav_hunk("next")
        end, "preview-hunk")

        keymap_set("n", "]h", function()
            if vim.wo.diff then
                vim.cmd.normal({ "]h", bang = true })
            else
                gitsigns.nav_hunk("next")
            end
        end, "next-git-hunk")

        keymap_set("n", "[h", function()
            if vim.wo.diff then
                vim.cmd.normal({ "[h", bang = true })
            else
                gitsigns.nav_hunk("prev")
            end
        end, "prev-git-hunk")
    end
end

local opts = {
    signs = signs,
    signs_staged = signs_staged,
    signs_staged_enable = true,
    signcolumn = true,
    numhl = false,
    linehl = false,
    word_diff = false,
    watch_gitdir = {
        enable = true,
        follow_files = true,
    },
    diff_opts = {
        ---@type "myers" | "minimal" | "patience" | "histogram"
        algorithm = "myers", -- default
        vertical = true,
    },
    auto_attach = true,
    attach_to_untracked = false,
    current_line_blame = false,
    current_line_blame_opts = blame_opts,
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d %H:%M:%S> - <summary>",
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000, -- Disable if file is longer than this
    preview_config = preview_config,
    on_attach = setup_on_attach(),
}

return {
    "lewis6991/gitsigns.nvim",
    cmd = "Gitsigns",
    event = { "BufReadPre", "BufNewFile" },
    opts = opts,
}
