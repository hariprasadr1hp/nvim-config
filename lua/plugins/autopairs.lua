-- lua/plugins/autopairs.lua

local opts = {
    check_ts = true,
    ts_config = {
        lua = { "string" }, -- don't add pairs in lua string treesitter nodes
        javascript = { "template_string" }, -- don't add pairs in js template_string treesitter nodes
        java = false, -- don't check treesitter on java
    },
}

return {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    opts = opts
}
