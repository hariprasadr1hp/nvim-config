-- lua/plugins/ai/companion.lua

local M = {}

local display = {
    diff = {
        provider = "mini_diff",
    },
}

local prompt_library = {
    ["Boilerplate HTML"] = {
        strategy = "inline",
        description = "Generate some boilerplate HTML",
        prompts = {
            {
                role = "system",
                content = "You are an expert HTML programmer",
            },
            {
                role = "user",
                content = "Please generate some HTML boilerplate for me. Return the code only and no markdown codeblocks",
            },
        },
    },
}

--- @param adapter CodeCompanion.Adapter
--- @return string
local function setup_system_prompt(adapter)
    if adapter.schema.model.default == "llama3.2:latest" then
        return "My custom system prompt"
    end
    return "My default system prompt"
end

local strategies = {
    chat = {
        adapter = "ollama",
    },
    inline = {
        adapter = "ollama",
    },
    agent = {
        adapter = "ollama",
    },
}

local function setup_code_companion()
    return require("codecompanion").setup({
        display = display,
        prompt_library = prompt_library,
        strategies = strategies,
        opts = {
            log_level = "DEBUG",

            system_prompt = function(adapter)
                return setup_system_prompt(adapter)
            end,
        },
    })
end

M = {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
        "nvim-telescope/telescope.nvim", -- Optional: For using slash commands
        -- { "stevearc/dressing.nvim", opts = {} }, -- Optional: Improves `vim.ui.select`
    },
    config = setup_code_companion,
}

return M
