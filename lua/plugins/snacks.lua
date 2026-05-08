--lua/plugins/snacks.lua

---@class snacks.bigfile.Config
local bigfile_opts = {
    enabled = true,
    notify = true,
    size = 1.5 * 1024 * 1024,
    line_length = 1000,
    ---@param ctx {buf: number, ft:string}
    setup = function(ctx)
        if vim.fn.exists(":NoMatchParen") ~= 0 then
            vim.cmd([[NoMatchParen]])
        end
        Snacks.util.wo(0, { foldmethod = "manual", statuscolumn = "", conceallevel = 0 })
        vim.b.minianimate_disable = true
        vim.schedule(function()
            if vim.api.nvim_buf_is_valid(ctx.buf) then
                vim.bo[ctx.buf].syntax = ctx.ft
            end
        end)
    end,
}

---@class snacks.quickfile.Config
local quickfile_opts = {
    exclude = {},
    enabled = true,
}

---@class snacks.zen.Config
local zen_opts = {
    ---@type table<string, boolean>
    toggles = {
        dim = false,
        git_signs = false,
        mini_diff_signs = false,
    },
    show = {
        statusline = false,
        tabline = false,
    },
    ---@type snacks.win.Config
    win = { style = "zen" },
}

---@class snacks.Config
local opts = {
    bigfile = bigfile_opts,
    bufdelete = { enabled = true },
    dashboard = { enabled = false },
    indent = { enabled = false },
    image = { enabled = vim.g.neovide ~= nil },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = false },
    notify = { enabled = false },
    quickfile = quickfile_opts,
    rename = { enabled = false },
    scope = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    words = { enabled = false },
    win = { enabled = true },
    zen = zen_opts,
}

local function setup_snacks_config()
    local keymap_set = require("config.helpers").keymap_set
    local snacks = require("snacks")
    snacks.setup(opts)

    local function toggle_indent_hl()
        if snacks.indent.enabled then
            snacks.indent.disable()
            vim.wo.list = false
            vim.wo.cursorline = false
        else
            snacks.indent.enable()
            vim.wo.list = true
            vim.wo.cursorline = true
        end
    end

    vim.api.nvim_create_user_command(
        "ToggleIndentHl",
        toggle_indent_hl,
        { desc = "toggle hightlight for the indent lines" }
    )

    keymap_set("n", "<leader>fz", snacks.zen.zen, "zen-mode")
    -- FIX: when github-actions not available for the current PR, supply issue and PR ids
    keymap_set("n", "<leader>gha", snacks.picker.gh_actions, "gh-actions")
    -- TODO: keymap_set("n", "<leader>ghd", snacks.picker.gh_diff, "gh-diff")
    -- TODO: keymap_set("n", "<leader>ghr", snacks.picker.gh_reactions, "gh-reactions")
    keymap_set("n", "<leader>ghi", snacks.picker.gh_issue, "gh-issues-open")
    keymap_set("n", "<leader>ghI", function()
        snacks.picker.gh_issue({ state = "all" })
    end, "gh-issues-all")
    -- TODO: keymap_set("n", "<leader>ghl", snacks.picker.gh_labels, "gh-labels")
    keymap_set("n", "<leader>ghp", snacks.picker.gh_pr, "gh-pr-open")
    keymap_set("n", "<leader>ghP", function()
        snacks.picker.gh_pr({ state = "all" })
    end, "gh-pr-all")
    keymap_set("n", "<leader>glf", snacks.picker.git_log_file, "file-logs")
    keymap_set("n", "<leader>gll", snacks.picker.git_log_line, "line-logs")
    keymap_set("n", "<leader>glL", snacks.picker.git_log, "all-logs")

    keymap_set("n", "<leader>lc", snacks.picker.lsp_config, "lsp_config")
    keymap_set("n", "<leader>ti", toggle_indent_hl, "indent-hl")
    keymap_set("n", "<leader>zi", snacks.picker.icons, "icons")
end

return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    config = setup_snacks_config,
}
