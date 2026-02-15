-- lua/plugins/ai/mcphub/resources/cfile_diagnostics.lua

return {
    name = "Diagnostics: Current File",
    description = "Get diagnostics for the current file",
    uri = "neovim://diagnostics/current",
    mimeType = "text/plain",
    handler = function(req, res)
        -- Get active buffer
        local buf_info = req.editor_info.last_active
        if not buf_info then
            return res:error("No active buffer")
        end

        -- Get diagnostics
        local diagnostics = vim.diagnostic.get(buf_info.bufnr)

        -- Format header
        local text = string.format("Diagnostics for: %s\n%s\n", buf_info.filename, string.rep("-", 40))

        -- Format diagnostics
        for _, diag in ipairs(diagnostics) do
            local severity = vim.diagnostic.severity[diag.severity]
            text = text
                .. string.format(
                    "\n%s: %s\nLine %d: %s\n",
                    severity,
                    diag.source or "unknown",
                    diag.lnum + 1,
                    diag.message
                )
        end

        return res:text(text):send()
    end,
}
