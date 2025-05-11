-- lua/plugins/tabline.lua

local opts = {
    show_icons = true,
    format = nil,
    tabpage_section = "right",
}

return {
    {
        "echasnovski/mini.tabline",
        version = false,
        opts = opts,
    },
}
