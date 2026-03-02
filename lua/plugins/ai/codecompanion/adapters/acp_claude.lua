-- lua/plugins/ai/codecompanion/adapters/acp_claude.lua

-- REFER: https://github.com/zed-industries/claude-code-acp

local companion_adapters = require("codecompanion.adapters")

---@type CodeCompanion.ACPAdapter.ClaudeCode
local opts = {
    env = {
        -- BUG: claudecode uses ANTHROPIC_API_KEY for api usage if claudecode is not oauth authenticated, shouldn't happen
        CLAUDE_CODE_OAUTH_TOKEN = vim.env.CLAUDE_CODE_OAUTH_TOKEN,
    },

    -- FIX: choose between haiku and sonnet models, with default as haiku
    -- refer how the models are named for claude code
    commands = {
        default = {
            "claude-agent-acp",
        },
    },
}

return companion_adapters.extend("claude_code", opts)
