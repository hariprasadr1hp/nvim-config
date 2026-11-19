-- lua/plugins/ai/codecompanion/adapters/http_ollama.lua

local companion_adapters = require("codecompanion.adapters")

---@type CodeCompanion.HTTPAdapter.Ollama
local opts = {
    env = {
        url = vim.env.OLLAMA_SERVER_HOST,
    },

    headers = {
        ["Content-Type"] = "application/json",
        -- ["Authorization"] = string.format("Bearer %s", vim.env.OLLAMA_API_KEY),
    },

    parameters = {
        sync = true,
    },

    schema = {
        model = {
            default = vim.env.OLLAMA_DEFAULT_SERVER_MODEL,
            choices = {
                "gemma4:26b",
                "gemma4:e4b",
                "gemma4:e2b",
                "qwen2.5-coder:7b",
                "qwen3.5:0.8b",
            },
        },
    },
}

return companion_adapters.extend("ollama", opts)
