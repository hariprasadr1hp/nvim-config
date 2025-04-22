--lua/plugins/snacks.lua

---@class snacks.bigfile.Config
local bigfile = {
    -- show notification when big file detected
    notify = true,
    -- 1.5MB
    size = 1.5 * 1024 * 1024,
    -- average line length (useful for minified files)
    line_length = 1000,
    -- enable or disable features when big file detected
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
local quickfile = {
    -- any treesitter langs to exclude
    exclude = { "latex" },
}

---@type snacks.Config
local opts = {
    bigfile = bigfile,
    dashboard = { enabled = false },
    indent = { enabled = false },
    input = { enabled = true },
    picker = { enabled = false },
    notifier = { enabled = false },
    notify = { enabled = false },
    quickfile = quickfile,
    scope = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    words = { enabled = false },
}

local setup_snacks = function()
    MiniDeps.add({ source = "folke/snacks.nvim" })
    local snacks = require("snacks")
    snacks.setup(opts)
end

MiniDeps.now(setup_snacks)
