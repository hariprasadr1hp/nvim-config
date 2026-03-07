-- lua/plugins/dadbod.lua

-- NOTE: can find saved connections at `~/.local/share/db_ui/connections.json`

local function setup_dadbod_ui_init()
    vim.g.db_ui_use_nerd_fonts = 1

    vim.g.db_ui_table_helpers = {
        duckdb = {
            Columns = "select * from information_schema.columns where table_name = '{table}'",
            Count = 'select count(*) from "{table}";',
            List = "select * from {table} limit 200;",
        },

        jq = {
            Root = ".",
        },

        sqlite = {
            Count = 'select count(*) from "{table}";',
        },

        postgresql = {
            Col = "select column_name, data_type from information_schema.columns where table_name = '{table}' and table_schema = '{schema}';",
            Count = 'select count(*) from "{table}";',
            Explain = "EXPLAIN ANALYZE {last_query};",
        },
    }

    vim.g.db_ui_auto_execute_table_helpers = 1

    vim.g.db_ui_icons = {
        expanded = "-",
        collapsed = "+",
    }
end

local function setup_dadbod_config()
    --
end

return {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
        {
            "tpope/vim-dadbod",
            lazy = true,
            config = setup_dadbod_config,
        },
        { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql", "bqsql" }, lazy = true },
    },
    cmd = {
        "DBUI",
        "DBUIToggle",
        "DBUIAddConnection",
        "DBUIFindBuffer",
    },
    keys = {
        { "<leader>oq", "<cmd>DBUIToggle<cr>", desc = "DBUI" },
    },
    init = setup_dadbod_ui_init,
    config = function() end,
}

-- TODO: select the complete query using TS objects

-- TODO: run the whole query at the cursor

-- TODO: sort "Query Results" by recency

-- TODO: sort "Buffers" by recency

-- TODO: persistent cache of executed queries
