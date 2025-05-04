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
    exclude = { "latex" },
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
    zen = zen_opts,
}

local function setup_snacks_config()
    local keymap_set = require("config.helpers").keymap_set
    local snacks = require("snacks")
    snacks.setup(opts)

    local function toggle_indent_line()
        if snacks.indent.enabled then
            snacks.indent.disable()
            vim.wo.list = false
        else
            snacks.indent.enable()
            vim.wo.list = true
        end
    end

    vim.api.nvim_create_user_command(
        "ToggleIndentLines",
        toggle_indent_line,
        { desc = "toggle hightlight for the indent lines" }
    )
    keymap_set("n", "<leader>ti", toggle_indent_line, "indent-hl")
    keymap_set("n", "<leader>tz", snacks.zen.zen, "zen-mode")
end

return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    config = setup_snacks_config,
}
