-- lua/plugins/ai/codecompanion/adapters/http_grok.lua

local companion_adapters = require("codecompanion.adapters")

---@type CodeCompanion.HTTPAdapter.xAI
local opts = {
    env = {
        api_key = vim.env.XAI_API_KEY,
    },
    opts = {
        stream = true,
        vision = false,
    },
    schema = {
        model = {
            ---@type "grok-4-1-fast-reasoning" | "grok-4-1-fast-non-reasoning"
            default = "grok-4-1-fast-reasoning",
        },
    },
}

return companion_adapters.extend("xai", opts)
