-- lua/plugins/ai/codecompanion/adapters/acp_cursor.lua

-- REFER: https://cursor.com/docs/cli/acp

local helpers = require("codecompanion.adapters.acp.helpers")

return {
    name = "cursor",
    formatted_name = "Cursor",
    type = "acp",
    roles = {
        llm = "assistant",
        user = "user",
    },
    opts = {
        vision = false,
    },
    commands = {
        default = {
            "cursor acp",
        },
    },
    defaults = {
        acpServers = {},
        timeout = 20000, -- 20 seconds
    },
    parameters = {
        protocolVersion = 1,
        clientCapabilities = {
            fs = { readTextFile = true, writeTextFile = true },
        },
        clientInfo = {
            name = "CodeCompanion.nvim",
            version = "1.0.0",
        },
    },
    handlers = {
        lifecycle = {
            setup = function()
                return true
            end,

            auth = function()
                return true
            end,

            ---@diagnostic disable-next-line: unused-local
            on_exit = function(self, args) end,
        },

        request = {
            build_messages = helpers.build_messages,
        },
    },
}
