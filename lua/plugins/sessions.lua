-- lua/plugins/sessions.lua

local keymap_set = require("config.helpers").keymap_set

local opts = {
    dir = vim.fn.stdpath("state") .. "/sessions/",
    need = 1,
    branch = true,
}

-- TODO: persist breakpoints from previous session

local function setup_persistence_config()
    local persistence = require("persistence")
    persistence.setup(opts)

    -- TODO: enable notifications if session-reloaded, or decided not-to-be-saved
    keymap_set("n", "<leader>rls", function()
        persistence.load({ last = true })
    end, "nvim-session")
    keymap_set("n", "<leader>rsl", function()
        persistence.load({ last = true })
    end, "session-last")
    keymap_set("n", "<leader>rsz", persistence.select, "sessions-list")
    keymap_set("n", "<leader>rsK", persistence.stop, "dont-store-current-session")
    keymap_set("n", "<leader>xs", persistence.stop, "dont-store-current-session")
end

return {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = setup_persistence_config,
}
