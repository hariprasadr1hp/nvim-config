-- lua/plugins/ai/codecompanion/adapters/http_anthropic.lua

-- FIX: gracefully exit, when the API key is not available

local companion_adapters = require("codecompanion.adapters")

---@type CodeCompanion.HTTPAdapter.Anthropic
local opts = {
    env = {
        api_key = vim.env.ANTHROPIC_API_KEY,
    },
}

return companion_adapters.extend("anthropic", opts)
