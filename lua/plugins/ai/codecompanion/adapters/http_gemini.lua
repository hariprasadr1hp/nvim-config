-- lua/plugins/ai/codecompanion/adapters/http_gemini.lua

local companion_adapters = require("codecompanion.adapters")

---@type CodeCompanion.HTTPAdapter.Gemini
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

return companion_adapters.extend("gemini", opts)
