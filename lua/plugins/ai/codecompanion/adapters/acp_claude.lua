-- lua/plugins/ai/codecompanion/adapters/acp_claude.lua

-- REFER: https://github.com/agentclientprotocol/claude-agent-acp

local companion_adapters = require("codecompanion.adapters")

---@type CodeCompanion.ACPAdapter.ClaudeCode
local opts = {
    env = {
        CLAUDE_CODE_OAUTH_TOKEN = vim.env.CLAUDE_CODE_OAUTH_TOKEN,
    },

    commands = {
        -- the agent process inherits nvim's env (incl. ANTHROPIC_API_KEY loaded from `.env`),
        -- which makes claude code bill the API key instead of using OAuth; strip it at spawn time
        default = {
            "env",
            "-u",
            "ANTHROPIC_API_KEY",
            "claude-agent-acp",
        },
        yolo = {
            "env",
            "-u",
            "ANTHROPIC_API_KEY",
            "claude-agent-acp",
            "--yolo",
        },
    },

    defaults = {
        session_config_options = {
            ---@type "Manual" | "Plan" | "Auto" | "Accept edits" | "Bypass permissions"
            mode = "Manual",
            ---@type "Default" | "Low" | "Medium" | "High" | "Xhigh" | "Max"
            thought_level = "Default",
        },
    },
}

return companion_adapters.extend("claude_code", opts)
