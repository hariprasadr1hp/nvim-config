-- lua/plugins/ai/mcphub/tools/greet.lua

---@class MCPTool
local M = {
    name = "greeting",
    description = "Greet a user",

    inputSchema = {
        type = "object",
        properties = {
            name = {
                type = "string",
                description = "Name to greet",
            },
        },
    },

    handler = function(req, res)
        return res:text("Hello " .. req.params.name):send()
    end,
}

return M
