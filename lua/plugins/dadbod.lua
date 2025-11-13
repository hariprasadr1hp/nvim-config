-- lua/plugins/dadbod.lua

-- NOTE: can find saved connections at `~/.local/share/db_ui/connections.json`

local function setup_dadbod_init()
    vim.g.db_ui_use_nerd_fonts = 1

    vim.g.db_ui_table_helpers = {
        duckdb = {
            Columns = "select * from information_schema.columns where table_name = '{table}'",
            Count = 'select count(*) from "{table}";',
            List = "select * from {table} limit 200;",
        },

        postgresql = {
            Count = 'select count(*) from "{table}";',
        },
    }

    vim.g.db_ui_auto_execute_table_helpers = 1

    vim.g.db_ui_icons = {
        expanded = "-",
        collapsed = "+",
    }
end

return {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
        { "tpope/vim-dadbod", lazy = true },
        { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql", "bqsql" }, lazy = true },
    },
    cmd = {
        "DBUI",
        "DBUIToggle",
        "DBUIAddConnection",
        "DBUIFindBuffer",
    },
    keys = {
        { "<leader>oq", "<cmd>DBUIToggle<CR>", desc = "DBUI" },
    },
    init = setup_dadbod_init,
    config = function() end,
}

-- TODO: select the complete query using TS objects

-- TODO: run the whole query at the cursor

-- TODO: sort "Query Results" by recency

-- TODO: sort "Buffers" by recency

-- TODO: persistent cache of executed queries
