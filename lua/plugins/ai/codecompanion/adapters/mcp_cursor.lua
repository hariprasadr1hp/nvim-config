-- lua/plugins/ai/codecompanion/adapters/mcp_cursor.lua

local helpers = require("codecompanion.adapters.acp.helpers")

---@class CodeCompanion.ACPAdapter.Cursor: CodeCompanion.ACPAdapter
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
        -- TODO: possible to get the content under "reasoning", or is it obscured?
        default = {
            "cursor-agent-acp",
        },
    },
    defaults = {
        mcpServers = {},
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
        ---@param self CodeCompanion.ACPAdapter
        ---@return boolean
        ---@diagnostic disable-next-line: unused-local
        setup = function(self)
            return true
        end,

        ---@param self CodeCompanion.ACPAdapter
        ---@return boolean
        ---@diagnostic disable-next-line: unused-local
        auth = function(self)
            -- authentication handled externally via cursor-agent CLI
            -- via `cursor-agent login`
            return true
        end,

        ---@param self CodeCompanion.ACPAdapter
        ---@param messages table
        ---@param capabilities table
        ---@return table
        form_messages = function(self, messages, capabilities)
            return helpers.form_messages(self, messages, capabilities)
        end,

        ---@param self CodeCompanion.ACPAdapter
        ---@param code number
        ---@return nil
        ---@diagnostic disable-next-line: unused-local
        on_exit = function(self, code) end,
    },
}
