-- lua/plugins/ai/codecompanion/adapters/acp_pi.lua

-- REFER: https://github.com/svkozak/pi-acp

return function()
    local helpers = require("codecompanion.adapters.acp.helpers")

    return {
        name = "pi",
        formatted_name = "Pi",
        type = "acp",

        roles = {
            llm = "assistant",
            user = "user",
        },

        commands = {
            default = {
                "pi-acp",
            },
        },

        defaults = {
            model = "auto",
            mcpServers = {},
            timeout = 20000,
        },

        models = {
            ["auto"] = {
                name = "auto",
            },
        },

        parameters = {
            protocolVersion = 1,
            clientCapabilities = {
                fs = {
                    readTextFile = true,
                    writeTextFile = true,
                },
            },
            clientInfo = {
                name = "CodeCompanion.nvim",
                version = "1.0.0",
            },
        },

        handlers = {
            setup = function()
                return true
            end,

            auth = function()
                return true
            end,

            form_messages = function(self, messages, capabilities)
                return helpers.form_messages(self, messages, capabilities)
            end,

            on_exit = function(_, _) end,
        },
    }
end
