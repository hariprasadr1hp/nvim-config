-- lua/plugins/snapshot.lua

local opts = {
    -- Optional: Uncomment if you want to set a custom save path
    -- save_path = "~/Pictures/nvim_snap/",
    has_breadcrumbs = true,
    breadcrumbs_separator = " 󰶻 ",
    -- Optional: Uncomment if you want to set a background theme
    -- bg_theme = "bamboo",
    bg_padding = 0,
    has_line_number = true,
    -- Optional: Uncomment if you want to set a watermark
    -- watermark = "hariprasadr1hp",
}

local setup_codesnap = function()
    MiniDeps.add({
        source = "mistricky/codesnap.nvim",
        hooks = {
            post_checkout = function(path)
                vim.fn.system({ "make" }, path)
            end,
        },
    })

    require("codesnap").setup(opts)
end

MiniDeps.later(setup_codesnap)
