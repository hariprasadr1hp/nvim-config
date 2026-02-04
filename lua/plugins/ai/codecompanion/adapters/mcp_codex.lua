-- lua/plugins/ai/codecompanion/adapters/mcp_codex.lua

-- FIX: model selection, and default model

local companion_adapters = require("codecompanion.adapters")

---@type CodeCompanion.ACPAdapter.Codex
local opts = {
    defaults = {
        ---@type "openai-api-key" | "codex-api-key" | "chatgpt"
        auth_method = "chatgpt",
    },
    commands = {
        default = {
            -- https://github.com/zed-industries/codex-acp
            "codex-acp",
        },
    },
}

return companion_adapters.extend("codex", opts)
