-- lua/plugins/ai/codecompanion/adapters/mcp_gemini.lua

-- FIX: get gemini acp adapter working, along with model selection, and default model

local companion_adapters = require("codecompanion.adapters")

---@type CodeCompanion.ACPAdapter.GeminiCLI
local opts = {
    defaults = {
        ---@type "oauth-personal" | "gemini-api-key" | "vertex-ai"
        auth_method = "oauth-personal",
    },
    schema = {
        model = {
            ---@type "gemini-2.5-flash" | "gemini-2.5-flash-lite" | "gemini-2.5-pro"
            default = "gemini-2.5-flash",
        },
    },
}

return companion_adapters.extend("gemini_cli", opts)
