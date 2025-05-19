-- lua/plugins/lang/sql.lua

local keymap_set = require("config.helpers").keymap_set

-- NOTE: can find saved connections at `~/.local/share/db_ui/connections.json`

return {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
        { "tpope/vim-dadbod", lazy = true },
    },
    cmd = {
        "DBUI",
        "DBUIToggle",
        "DBUIAddConnection",
        "DBUIFindBuffer",
    },
    keys = {
        { "<leader>dd", "<cmd>DBUIToggle<CR>", desc = "DBUI" },
    },
    init = function()
        vim.g.db_ui_use_nerd_fonts = 1
    end,
    config = function()
        local connection_fpath = "~/.local/share/db_ui/connections.json"
        keymap_set("n", "<leader>fd", ":e " .. connection_fpath .. "<CR>", "db-connections-file")
    end,
}

-- TODO: select the complete query using TS objects

-- TODO: run the whole query at the cursor
