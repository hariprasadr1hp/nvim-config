-- lua/plugins/notify.lua

local opts = {
    content = {
        format = nil,
        sort = nil,
    },

    lsp_progress = {
        enable = true,
        level = "INFO",
        duration_last = 1000,
    },

    window = {
        config = {},
        max_width_share = 0.382,
        winblend = 25,
    },
}

return {
    {
        "echasnovski/mini.notify",
        version = false,
        opts = opts,
    },
}
