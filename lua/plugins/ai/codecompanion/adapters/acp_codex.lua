-- lua/plugins/ai/codecompanion/adapters/acp_codex.lua

-- REFER: https://github.com/zed-industries/codex-acp

local companion_adapters = require("codecompanion.adapters")

---@type CodeCompanion.ACPAdapter.Codex
local opts = {
    defaults = {
        ---@type "openai-api-key" | "codex-api-key" | "chat-gpt"
        auth_method = "chat-gpt",

        session_config_options = {
            model = "gpt-6-luna",
            ---@type "Low" | "Medium" | "High" | "Xhigh" | "Max"
            thought_level = "Low",
            ---@type "Default" | "Plan"
            collaboration_mode = "Default",
            ---@type "Auto review" | "Full access" | "Read-only" | "Workspace access"
            mode = "Auto review",
        },
    },
    commands = {
        default = {
            "env",
            "-u",
            "OPENAI_API_KEY",
            "codex-acp",
        },
    },
}

return companion_adapters.extend("codex", opts)
