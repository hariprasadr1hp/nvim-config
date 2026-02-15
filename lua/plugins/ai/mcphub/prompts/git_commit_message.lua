-- lua/plugins/ai/mcphub/prompts/git_commit_message.lua

---@class MCPPrompt
return {
    name = "git_commit_message",
    description = "Help write a commit message",
    arguments = function()
        -- Get git branches
        local branches = vim.fn.systemlist("git branch --format='%(refname:short)'")

        return {
            {
                name = "type",
                description = "Commit type",
                required = true,
                -- Provide standard options
                default = "feat",
                enum = {
                    "feat",
                    "fix",
                    "docs",
                    "style",
                    "refactor",
                    "test",
                    "chore",
                },
            },
            {
                name = "branch",
                description = "Target branch",
                -- Use actual branches
                enum = branches,
            },
        }
    end,
    handler = function(req, res)
        return res:system()
            :text(string.format("Help write a %s commit for branch: %s", req.params.type, req.params.branch))
            :send()
    end,
}
