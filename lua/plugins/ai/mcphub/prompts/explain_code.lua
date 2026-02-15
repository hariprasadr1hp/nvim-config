-- lua/plugins/ai/mcphub/prompts/explain_code.lua

---@class MCPPrompt
return {
    name = "explain_code",
    handler = function(req, res)
        -- Start with base behavior
        res:system():text("You are a code explanation assistant.")

        -- Add context based on caller
        if req.caller.type == "codecompanion" then
            -- Add CodeCompanion chat context
            local chat = req.caller.codecompanion.chat
            res:text("\nPrevious discussion:\n" .. chat.history)
        elseif req.caller.type == "avante" then
            -- Add Avante code context
            local code = req.caller.avante.code
            res:text("\nSelected code:\n" .. code)
        end

        -- Add example interactions
        res:user():text("Explain this code"):llm():text("I'll explain the code in detail...")

        return res:send()
    end,
}
