-- lua/plugins/ai/codecompanion/adapters/acp_opencode.lua

-- REFER: https://opencode.ai/docs/acp/#codecompanionnvim

local companion_adapters = require("codecompanion.adapters")

---@type CodeCompanion.ACPAdapter.OpenCode
local opts = {
    model = {
        default = vim.env.OLLAMA_DEFAULT_SERVER_MODEL,
        name = "ollama/qwen2.5-coder:7b",
    },

    -- FIX: using schema.model.choices to change the model, just like in http adapters
    -- using a handler???

    -- schema = {
    --     model = {
    --         choices = {
    --             "ollama/qwen2.5-coder:7b",
    --             "ollama/devstral:24b",
    --             "ollama/llama3.2:3b",
    --         },
    --     },
    -- },
}

return companion_adapters.extend("opencode", opts)
