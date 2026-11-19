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
            default = "gpt-6-luna",
            choices = {
                "gpt-6-luna",
                "gpt-6-sol",
            },
        },
    },
    opts = {
        vision = false,
    },
}

return companion_adapters.extend("openai_legacy", opts)
