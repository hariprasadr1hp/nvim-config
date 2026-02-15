-- lua/plugins/ai/codecompanion/adapters/http_gemini.lua

-- REFER: https://ai.google.dev/gemini-api/docs/pricing

local companion_adapters = require("codecompanion.adapters")

local opts = {
    defaults = {
        ---@type "oauth-personal" | "gemini-api-key" | "vertex-ai"
        auth_method = "oauth-personal",
    },
    opts = {
        attachment_upload = true,
    },
    schema = {
        model = {
            -- TODO: update default model
            default = "gemini-2.5-flash",
            choices = nil,
        },
    },
}

return companion_adapters.extend("gemini", opts)
