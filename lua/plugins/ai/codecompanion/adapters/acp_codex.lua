-- lua/plugins/ai/codecompanion/adapters/acp_codex.lua

-- REFER: https://github.com/zed-industries/codex-acp

-- FIX: model selection, and default model

local companion_adapters = require("codecompanion.adapters")

local opts = {
    defaults = {
        ---@type "openai-api-key" | "codex-api-key" | "chatgpt"
        auth_method = "chatgpt",
    },
    commands = {
        default = {
            "codex-acp",
        },
    },
}

return companion_adapters.extend("codex", opts)
