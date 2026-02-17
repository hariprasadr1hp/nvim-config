-- lua/plugins/ai/codecompanion/adapters/xai.lua

-- REFER: https://docs.x.ai/developers/models

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
            default = "grok-4-1-fast-reasoning",
            choices = {
                "grok-4-1-fast-reasoning",
                "grok-4-1-fast-non-reasoning",
            },
        },
    },
}

return companion_adapters.extend("xai", opts)
