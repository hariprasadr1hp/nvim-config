-- lua/plugins/ai/codecompanion/adapters/acp_claude.lua

-- REFER: https://github.com/zed-industries/claude-code-acp

local companion_adapters = require("codecompanion.adapters")

---@type CodeCompanion.ACPAdapter.ClaudeCode
local opts = {
    env = {
        CLAUDE_CODE_OAUTH_TOKEN = vim.env.CLAUDE_CODE_OAUTH_TOKEN,
    },

    -- FIX: choose between haiku and sonnet models, with default as haiku
    -- refer how the models are named for claude code
    commands = {
        default = {
            "claude-code-acp",
        },
    },
}

return companion_adapters.extend("claude_code", opts)
