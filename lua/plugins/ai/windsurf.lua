-- lua/plugins/ai/windsurf.lua

-- NOTE: `windsurf` plugin log is written to `~/.cache/nvim/codeium/codeium.log`

local opts = {
    enable_cmp_source = true,

    virtual_text = {
        enabled = true,
        manual = false,
        filetypes = {
            bash = false,
        },
        default_filetype_enabled = true,
        idle_delay = 75,
        virtual_text_priority = 65535,
        map_keys = true,
        accept_fallback = nil,
        key_bindings = {
            accept = "<C-g>",
            accept_word = "<C-D>",
            accept_line = "<C-d>",
            clear = "<C-x>",
            next = "<M-]>",
            prev = "<M-[>",
        },
    },

    workspace_root = {
        use_lsp = true,
        -- TODO: should add the logic for finding workspace root directory
        find_root = nil,
        paths = {
            ".bzr",
            ".git",
            ".hg",
            ".svn",
            "_FOSSIL_",
            "package.json",
        },
    },
}

local function setup_windsurf_config()
    local codeium = require("codeium")
    codeium.setup(opts)

    codeium.toggle()

    local keymap_set = require("config.helpers").keymap_set
    keymap_set("n", "<leader>ta", codeium.toggle, "ai-completion")
end

return {
    {
        "Exafunction/windsurf.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "saghen/blink.cmp",
        },
        config = setup_windsurf_config,
    },
}
