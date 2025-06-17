-- lua/plugins/ai/mcphub.lua

local function setup_mcphub()
    local opts = {
        port = 37373,
        config = vim.fn.expand("~/.config/mcphub/servers.json"),
        native_servers = {},

        auto_approve = false,
        auto_toggle_mcp_servers = true,
        extensions = {
            avante = {
                make_slash_commands = true,
            },
        },

        ui = {
            window = {
                width = 0.8,
                height = 0.8,
                relative = "editor",
                zindex = 50,
                border = "rounded",
            },
            wo = {},
        },

        on_ready = function(hub) end,
        on_error = function(err) end,

        use_bundled_binary = false,

        shutdown_delay = 600000,

        log = {
            level = vim.log.levels.WARN,
            to_file = false,
            file_path = nil,
            prefix = "MCPHub",
        },
    }

    require("mcphub").setup(opts)
end

return {
    "ravitemer/mcphub.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    cmd = "MCPHub",
    keys = {
        { "<leader>oM", "<cmd>MCPHub<CR>", desc = "MCPHub" },
    },
    build = "bundled_build.lua",
    config = setup_mcphub,
}
