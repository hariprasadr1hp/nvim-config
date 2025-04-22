-- lua/plugins/autopairs.lua

local function setup_autopairs_config()
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

local setup_autopairs = function()
    MiniDeps.add({
        source = "windwp/nvim-autopairs",
    })
    vim.api.nvim_create_autocmd("InsertEnter", {
        once = true,
        callback = setup_autopairs_config,
    })
end

M = {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    config = function()
        setup_autopairs()
    end,
}

MiniDeps.later(setup_autopairs)
