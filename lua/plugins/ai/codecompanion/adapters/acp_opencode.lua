-- lua/plugins/ai/codecompanion/adapters/acp_opencode.lua

-- REFER: https://opencode.ai/docs/acp/#codecompanionnvim

local companion_adapters = require("codecompanion.adapters")

---@type CodeCompanion.ACPAdapter.OpenCode
local opts = {
    defaults = {
        session_config_options = {
            model = "ollama/" .. vim.env.OLLAMA_DEFAULT_SERVER_MODEL,
            ---@type "Build" | "Plan"
            mode = "Build",
        },
    },

    commands = {
        default = {
            "opencode",
            "acp",
        },
    },
}

return companion_adapters.extend("opencode", opts)
