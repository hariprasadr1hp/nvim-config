-- lua/plugins/dashboard.lua

local mini_starter_opts = {
    autoopen = false,
    evaluate_single = false,
    items = nil,
    header = nil,
    footer = nil,
    content_hooks = nil,
    query_updaters = "abcdefghijklmnopqrstuvwxyz0123456789_-.",
    silent = false,
}

return {
    {
        "echasnovski/mini.starter",
        version = false,
        opts = mini_starter_opts,
    },
}
