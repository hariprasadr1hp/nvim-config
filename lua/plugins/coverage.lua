-- lua/plugins/coverage.lua

local opts = {
    auto_reload = true,
    commands = true, -- create commands
    highlights = {
        -- customize highlight groups created by the plugin
        covered = { fg = "#C3E88D" }, -- supports style, fg, bg, sp (see :h highlight-gui)
        uncovered = { fg = "#F07178" },
    },
    signs = {
        -- use your own highlight groups or text markers
        covered = { hl = "CoverageCovered", text = "▎" },
        uncovered = { hl = "CoverageUncovered", text = "▎" },
    },
    summary = {
        -- customize the summary pop-up
        min_coverage = 80.0, -- minimum coverage threshold (used for highlighting)
    },
    lang = {
        -- customize language specific settings
    },
}

local function setup_coverage()
    MiniDeps.add({ source = "andythigpen/nvim-coverage" })

    local coverage = require("coverage")
    coverage.setup(opts)

    local commands = { "CoverageShow", "CoverageHide", "CoverageLoad", "CoverageSummary" }

    for _, cmd in ipairs(commands) do
        vim.api.nvim_create_user_command(cmd, function()
            coverage.setup(opts)
        end, {})
    end
end

MiniDeps.later(setup_coverage)

-- TODO: Extending to other languages
-- https://github.com/andythigpen/nvim-coverage?tab=readme-ov-file#extending-to-other-languages
