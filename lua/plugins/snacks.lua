-- lua/plugins/snacks.lua

local M = {}

---@class snacks.bigfile.Config
local bigfile = {
    notify = true, -- show notification when big file detected
    size = 1.5 * 1024 * 1024, -- 1.5MB
    line_length = 1000, -- average line length (useful for minified files)
    -- Enable or disable features when big file detected
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

---@class snacks.profiler.Config
local profiler = {
    autocmds = true,
    runtime = vim.env.VIMRUNTIME, ---@type string
    -- thresholds for buttons to be shown as info, warn or error
    -- value is a tuple of [warn, error]
    thresholds = {
        time = { 2, 10 },
        pct = { 10, 20 },
        count = { 10, 100 },
    },
    on_stop = {
        highlights = true, -- highlight entries after stopping the profiler
        pick = true, -- show a picker after stopping the profiler (uses the `on_stop` preset)
    },
    ---@type snacks.profiler.Highlights
    highlights = {
        min_time = 0, -- only highlight entries with time > min_time (in ms)
        max_shade = 20, -- time in ms for the darkest shade
        badges = { "time", "pct", "count", "trace" },
        align = 80,
    },
    pick = {
        picker = "snacks", ---@type snacks.profiler.Picker
        ---@type snacks.profiler.Badge.type[]
        badges = { "time", "count", "name" },
        ---@type snacks.profiler.Highlights
        preview = {
            badges = { "time", "pct", "count" },
            align = "right",
        },
    },
    startup = {
        event = "VimEnter", -- stop profiler on this event. Defaults to `VimEnter`
        after = true, -- stop the profiler **after** the event. When false it stops **at** the event
        pattern = nil, -- pattern to match for the autocmd
        pick = true, -- show a picker after starting the profiler (uses the `startup` preset)
    },
    ---@type table<string, snacks.profiler.Pick|fun():snacks.profiler.Pick?>
    presets = {
        startup = { min_time = 1, sort = false },
        on_stop = {},
        filter_by_plugin = function()
            return { filter = { def_plugin = vim.fn.input("Filter by plugin: ") } }
        end,
    },
    ---@type string[]
    globals = {
        -- "vim",
        -- "vim.api",
        -- "vim.keymap",
        -- "Snacks.dashboard.Dashboard",
    },
    -- filter modules by pattern.
    -- longest patterns are matched first
    filter_mod = {
        default = true, -- default value for unmatched patterns
        ["^vim%."] = false,
        ["mason-core.functional"] = false,
        ["mason-core.functional.data"] = false,
        ["mason-core.optional"] = false,
        ["which-key.state"] = false,
    },
    filter_fn = {
        default = true,
        ["^.*%._[^%.]*$"] = false,
        ["trouble.filter.is"] = false,
        ["trouble.item.__index"] = false,
        ["which-key.node.__index"] = false,
        ["smear_cursor.draw.wo"] = false,
        ["^ibl%.utils%."] = false,
    },
    icons = {
        time = " ",
        pct = " ",
        count = " ",
        require = "󰋺 ",
        modname = "󰆼 ",
        plugin = " ",
        autocmd = "⚡",
        file = " ",
        fn = "󰊕 ",
        status = "󰈸 ",
    },
}

---@class snacks.quickfile.Config
local quickfile = {
    -- any treesitter langs to exclude
    exclude = { "latex" },
}

local setup_opts = function()
    -- Snacks.toggle.profiler():map("pp")
    -- Snacks.toggle.profiler_highlights():map("ph")

    ---@type snacks.Config
    return {
        bigfile = bigfile,
        dashboard = { enabled = true },
        indent = { enabled = false },
        input = { enabled = false },
        notifier = { enabled = false },
        profiler = profiler,
        quickfile = quickfile,
        scroll = { enabled = false },
        statuscolumn = { enabled = false },
        words = { enabled = false },
    }
end

local keys = {
    {
        "ps",
        function()
            Snacks.profiler.scratch()
        end,
        desc = "profiler-scratch-buffer",
    },
}

M = {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = setup_opts(),
        keys = keys,
    },
}

return M
