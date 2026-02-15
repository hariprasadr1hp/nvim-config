-- lua/plugins/ai/codecompanion/adapters/acp_opencode.lua

-- REFER: https://opencode.ai/docs/acp/#codecompanionnvim

local companion_adapters = require("codecompanion.adapters")

local opts = {
    model = {
        default = vim.env.OLLAMA_DEFAULT_SERVER_MODEL,
    },
}

return companion_adapters.extend("opencode", opts)
