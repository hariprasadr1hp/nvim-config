-- lua/plugins/autopairs.lua

local M = {}

local function setup_cmp_autopairs()
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")

    -- make autopairs and completion to work together
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

local function setup_autopairs()
    local autopairs = require("nvim-autopairs")
    autopairs.setup({
        check_ts = true,
        ts_config = {
            lua = { "string" }, -- don't add pairs in lua string treesitter nodes
            javascript = { "template_string" }, -- don't add pairs in js template_string treesitter nodes
            java = false, -- don't check treesitter on java
        },
    })

    -- Setup for nvim-cmp integration
    setup_cmp_autopairs()
end

M = {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    dependencies = { "hrsh7th/nvim-cmp" }, -- Optional dependency
    config = function()
        setup_autopairs()
    end,
}

return M
