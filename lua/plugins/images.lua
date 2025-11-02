-- lua/plugins/images.lua

local opts = {
    filetypes = {
        codecompanion = {
            prompt_for_file_name = false,
            template = "[Image]($FILE_PATH)",
            use_absolute_path = true,
        },
    },
}

return {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = opts,
    keys = {
        { "<leader>ip", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    },
}
