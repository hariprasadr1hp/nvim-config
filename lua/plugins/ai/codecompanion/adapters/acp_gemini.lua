-- lua/plugins/ai/codecompanion/adapters/acp_gemini.lua

-- FIX: get gemini acp adapter working, along with model selection, and default model

local companion_adapters = require("codecompanion.adapters")

local opts = {
    defaults = {
        ---@type "oauth-personal" | "gemini-api-key" | "vertex-ai"
        auth_method = "oauth-personal",
    },
    schema = {
        model = {
            default = "gemini-2.5-flash",
        },
    },
}

return companion_adapters.extend("gemini_cli", opts)
