-- lua/plugins/init.lua

local opts = {
    require("plugins.mini"),
    require("plugins.snacks"),
    require("plugins.startup"),
    require("plugins.themes.catppuccin"),
    require("plugins.themes.kanagawa"),
    require("plugins.themes.oxocarbon"),
    require("plugins.themes.onedark"),

    require("plugins.icons"),
    require("plugins.pick"),
    -- require("plugins.telescope"),
    require("plugins.fzflua"),

    require("plugins.treesitter"),
    require("plugins.text_objects"),
    require("plugins.blink"),
    require("plugins.lspconfig"),
    require("plugins.format"),
    require("plugins.lint"),
    require("plugins.terminal"),
    require("plugins.debug"),
    require("plugins.testing"),

    require("plugins.lang.rust"),
    require("plugins.lang.hurl"),

    require("plugins.dadbod"),
    require("plugins.kulala"),
    require("plugins.snippets"),
    require("plugins.comment"),
    require("plugins.harpoon"),
    require("plugins.explorer"),
    require("plugins.gitsigns"),
    require("plugins.lualine"),
    require("plugins.outline"),
    require("plugins.todo_comments"),
    require("plugins.text_transform"),

    require("plugins.diff"),
    require("plugins.cloak"),
    require("plugins.notify"),
    require("plugins.git"),
    require("plugins.snapshot"),
    require("plugins.dashboard"),
    require("plugins.oil"),
    require("plugins.overseer"),
    require("plugins.images"),
    require("plugins.flash"),
    require("plugins.trouble"),
    require("plugins.sessions"),
    require("plugins.roam"),
    require("plugins.colors"),

    require("plugins.ai.mcphub"),
    require("plugins.ai.codecompanion"),
    require("plugins.ai.windsurf"),
    -- require("plugins.ai.cursor"),

    require("plugins.dbt"),
    require("plugins.dagster"),
    -- require("plugins.minimacs"),

    require("plugins.custom"),
    require("plugins.whichkey"),
    -- require("plugins.finally"),

    -- require("plugins.tabline"),
}

require("lazy").setup(opts)

vim.keymap.set("n", "<leader>oL", ":Lazy<cr>", { noremap = true, silent = true, desc = "Lazy" })

-- TODO: plugins to add/visit
-- Davidyz/VectorCode
-- saghen/blink.pairs
-- ThePrimeagen/refactoring.nvim
-- ryan-ressmeyer/quench.nvim
-- folke/ts-comments.nvim
-- code-biscuits/nvim-biscuits
-- esmuellert/codediff.nvim
-- nosduco/remote-sshfs.nvim
-- esmuellert/codediff.nvim
-- linux-cultist/venv-selector.nvim
