-- lua/plugins/ai/codecompanion/slash_commands/dummy.lua

---@class CodeCompanion.SlashCommand
local SlashCommand = {}

function SlashCommand.new(args)
    local self = setmetatable({
        Chat = args.Chat,
        config = args.config,
        context = args.context,
    }, { __index = SlashCommand })
    return self
end

---@return nil
function SlashCommand:execute()
    local chat = self.Chat
    chat:add_buf_message({ content = "This is a test prompt" })
end

return SlashCommand
