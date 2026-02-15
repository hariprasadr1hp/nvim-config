-- lua/plugins/ai/codecompanion/adapters/http_anthropic.lua

-- REFER: https://platform.claude.com/docs/en/about-claude/pricing
-- FIX: gracefully exit, when the API key is not available

local companion_adapters = require("codecompanion.adapters")

local opts = {
    env = {
        api_key = vim.env.ANTHROPIC_API_KEY,
    },
    opts = {
        attachment_upload = true,
    },
    schema = {
        model = {
            default = "claude-haiku-4-5",
            choices = {
                "claude-haiku-4-5",
                "claude-haiku-3-5",
                "claude-sonnet-4-5",
            },
        },
    },
}

return companion_adapters.extend("anthropic", opts)
