-- lua/plugins/custom.lua

local function setup_hello()
    MiniDeps.add({
        source = vim.env.CUSTOM_PLUGIN_URL,
        name = "hello/",
        checkout = "main",
        monitor = "develop",
        dependencies = { "nvim-telescope/telescope.nvim" },
    })

    vim.api.nvim_create_user_command("HelloTest", function()
        require("hello").say_hello()
    end, {})
end

-- MiniDeps.later(setup_hello)
