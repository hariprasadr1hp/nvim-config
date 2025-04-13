-- lua/plugins/autopairs.lua

local M = {}

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
end

M = {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    dependencies = {
        "saghen/blink.cmp",
    },
    config = function()
        setup_autopairs()
    end,
}

return M
