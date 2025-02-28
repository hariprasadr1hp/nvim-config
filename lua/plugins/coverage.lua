-- lua/plugins/coverage.lua

local M = {}

local function setup_coverage()
    require("coverage").setup({
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
    })
end

M = {
    "andythigpen/nvim-coverage",
    version = "*",
    cmd = { "CoverageShow", "CoverageHide", "CoverageLoad", "CoverageSummary" },
    config = setup_coverage,
}

return M

-- TODO: Extending to other languages
-- https://github.com/andythigpen/nvim-coverage?tab=readme-ov-file#extending-to-other-languages
