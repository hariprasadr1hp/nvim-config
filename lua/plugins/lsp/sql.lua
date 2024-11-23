-- plugins/lsp/sql.lua

local M = {}

local function setup_sql_config()
    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "dbout" },
        callback = function()
            vim.opt.foldenable = false
        end,
    })
end

M = {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
        { "tpope/vim-dadbod", lazy = true },
        { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql", "bqsql" }, lazy = true }, -- Optional
    },
    cmd = {
        "DBUI",
        "DBUIToggle",
        "DBUIAddConnection",
        "DBUIFindBuffer",
    },
    init = function()
        -- Your DBUI configuration
        vim.g.db_ui_use_nerd_fonts = 1
    end,
    config = setup_sql_config(),
}

return M
