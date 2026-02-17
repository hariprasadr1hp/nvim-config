-- lua/plugins/ai/codecompanion/adapters/http_openai.lua

-- REFER: https://openai.com/api/pricing/

local companion_adapters = require("codecompanion.adapters")

---@type CodeCompanion.HTTPAdapter.OpenAI
local opts = {
    env = {
        api_key = vim.env.OPENAI_API_KEY,
    },
    schema = {
        model = {
            default = "gpt-5-nano",
            choices = {
                "gpt-5-nano",
                "gpt-5-mini",
            },
        },
    },
    opts = {
        vision = false,
    },
}

return companion_adapters.extend("openai", opts)
