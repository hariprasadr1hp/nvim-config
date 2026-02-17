-- lua/plugins/ai/codecompanion/adapters/http_venice.lua

local companion_adapters = require("codecompanion.adapters")

---@type CodeCompanion.HTTPAdapter.OpenAICompatible
local opts = {
    env = {
        url = "https://api.venice.ai/api",
        chat_url = "/v1/chat/completions",
        api_key = vim.env.VENICE_API_KEY,
    },
    schema = {
        model = {
            default = "venice-uncensored",
            -- choices = nil,
        },
    },
    opts = {
        vision = false,
    },
}

return companion_adapters.extend("openai_compatible", opts)
