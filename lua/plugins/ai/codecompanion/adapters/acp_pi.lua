-- lua/plugins/ai/codecompanion/adapters/acp_pi.lua

-- REFER: https://github.com/svkozak/pi-acp

-- pi-acp sends JSON `null` for fields like `description` in `configOptions`.
-- codecompanion decodes with `vim.json.decode` (no `luanil`), so those become
-- `vim.NIL` (truthy userdata) and `/acp_session_options` crashes when it does
-- `display .. " - " .. val.description`. Strip `vim.NIL` before storing them.
local patched = false

local function patch_config_options()
    if patched then
        return
    end
    local Connection = require("codecompanion.acp")

    local function strip_nil(tbl)
        for k, v in pairs(tbl) do
            if v == vim.NIL then
                tbl[k] = nil
            elseif type(v) == "table" then
                strip_nil(v)
            end
        end
        return tbl
    end

    local apply = Connection._apply_config_options
    Connection._apply_config_options = function(self, config_options)
        if type(config_options) == "table" then
            strip_nil(config_options)
        end
        return apply(self, config_options)
    end
    patched = true
end

return function()
    local helpers = require("codecompanion.adapters.acp.helpers")
    patch_config_options()

    return {
        name = "pi",
        formatted_name = "Pi",
        type = "acp",

        roles = {
            llm = "assistant",
            user = "user",
        },

        opts = {
            vision = true,
        },

        commands = {
            default = {
                "pi-acp",
            },
        },

        defaults = {
            session_config_options = {
                model = "auto",
                ---@type "off" | "minimal" | "low" | "medium" | "high"
                thought_level = "medium",
            },
            mcpServers = {},
            timeout = 20000, -- 20 seconds
        },

        env = {
            PI_ACP_ENABLE_EMBEDDED_CONTEXT = "true",
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
            lifecycle = {
                ---@diagnostic disable-next-line: unused-local
                setup = function(self)
                    return true
                end,
            },

            request = {
                build_messages = function(self, args)
                    return helpers.build_messages(self, args)
                end,
            },
        },
    }
end
