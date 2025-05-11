-- lua/plugins/snapshot.lua

local opts = {
    save_path = "~/Pictures/nvim_snap/",
    has_breadcrumbs = true,
    breadcrumbs_separator = " 󰶻 ",
    bg_theme = "bamboo",
    bg_padding = 0,
    has_line_number = true,
    -- watermark = "hariprasadr1hp",
}

return {
    "mistricky/codesnap.nvim",
    build = "make",
    cmd = { "CodeSnap", "CodeSnapSaveHighlight", "CodeSnapASCII", "CodeSnapHighlight", "CodeSnapSave" },
    opts = opts,
}
