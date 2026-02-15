-- lua/plugins/ai/mcphub/prompts/review_code.lua

---@class MCPPrompt
return {
    name = "review_code",
    arguments = {
        {
            name = "style",
            description = "Review style",
            enum = { "brief", "detailed" },
        },
    },
    handler = function(req, res)
        -- Get current buffer
        local buf = req.editor_info.last_active
        if not buf then
            return res:error("No active buffer")
        end

        local function generate_overview(buf)
            return "I, finally generated an overview. Wait..."
        end
        local overview = generate_overview(buf)

        return res
            -- Set review context
            :system()
            :text("You are a code reviewer.\n" .. "Style: " .. req.params.style)
            -- Add code visualization
            :image(overview, "image/png")
            :text("Above is a visualization of the code structure.")
            -- Add relevant resources
            :resource({
                uri = "neovim://diagnostics/current",
                mimeType = "text/plain",
            })
            :text("Above are the current diagnostics.")
            -- Send prompt
            :send()
    end,
}
