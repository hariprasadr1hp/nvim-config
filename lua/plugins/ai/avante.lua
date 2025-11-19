-- lua/plugins/ai/avante.lua

local M = {}

---@class avante.Config
local function setup_opts()
    return {
        provider = "ollama",

        ollama = {
            endpoint = (vim.env.OLLAMA_SERVER_HOST or "localhost:11434"),
            model = vim.env.OLLAMA_SERVER_HOST and vim.env.OLLAMA_DEFAULT_SERVER_MODEL
                or vim.env.OLLAMA_DEFAULT_LOCAL_MODEL,
            timeout = 90000,
            temperature = 0,
            max_completion_tokens = 8192,
            ---@type "low" | "medium" | "high"
            reasoning_effort = "medium",
        },
    }
end

local dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "echasnovski/mini.pick",
    "ibhagwan/fzf-lua",
    "nvim-tree/nvim-web-devicons",
    -- "zbirenbaum/copilot.lua",
    {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
            default = {
                embed_image_as_base64 = false,
                prompt_for_file_name = false,
                drag_and_drop = {
                    insert_mode = true,
                },
                use_absolute_path = true,
            },
        },
    },
    -- {
    --     -- Make sure to set this up properly if you have lazy=true
    --     "MeanderingProgrammer/render-markdown.nvim",
    --     opts = {
    --         file_types = { "Avante" },
    --     },
    --     ft = { "Avante" },
    -- },
}

M = {
    {
        "yetone/avante.nvim",
        -- event = "VeryLazy",
        cmd = {
            "AvanteAsk",
            "AvanteBuild",
            "AvanteChat",
            "AvanteChatNew",
            "AvanteFocus",
            "AvanteHistory",
            "AvanteModels",
            "AvanteToggle",
        },
        keys = {
            { "<leader>aA", ":AvanteToggle<CR>", desc = "ai-chat-avante" },
        },
        -- WARN: Never set this value to "*"!
        version = false,
        opts = setup_opts(),
        build = "make",
        dependencies = dependencies,
    },
}

return M
