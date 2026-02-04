-- lua/plugins/startup.lua

return {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    keys = {
        { "<leader>is", "<cmd>StartupTime<cr>", desc = "startup" },
    },
}
