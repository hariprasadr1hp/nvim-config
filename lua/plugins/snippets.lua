-- lua/plugins/snippets.lua

local setup_mini_snippets = function()
    local gen_loader = require("mini.snippets").gen_loader
    local opts = {
        snippets = {
            -- Load custom file with global snippets first
            gen_loader.from_file("~/.config/nvim/snippets/global.json"),

            -- Load snippets based on current language by reading files from
            -- "snippets/" subdirectories from 'runtimepath' directories.
            gen_loader.from_lang(),
        },
        mappings = {
            expand = "",

            -- Interact with default `expand.insert` session.
            -- Created for the duration of active session(s)
            jump_next = "<C-l>",
            jump_prev = "<C-h>",
            stop = "<C-c>",
        },
    }
    require("mini.snippets").setup(opts)
end

MiniDeps.later(setup_mini_snippets)
MiniDeps.later(function()
    MiniDeps.add("rafamadriz/friendly-snippets")
end)
