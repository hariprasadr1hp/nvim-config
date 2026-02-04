-- lua/plugins/ai/codecompanion/adapters/mcp_opencode.lua

local companion_adapters = require("codecompanion.adapters")

---@type CodeCompanion.ACPAdapter.OpenCode
local opts = {
    model = {
        default = vim.env.OLLAMA_DEFAULT_SERVER_MODEL,
    },
}

return companion_adapters.extend("opencode", opts)
