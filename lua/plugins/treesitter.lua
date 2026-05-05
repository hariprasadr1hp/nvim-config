-- lua/plugins/treesitter.lua

local ensure_installed = {
    "arduino",
    "awk",
    "bash",
    "beancount",
    "bibtex",
    -- "bruno",
    "c",
    "cmake",
    "cpp",
    "css",
    "csv",
    -- "cypher",
    "diff",
    "dockerfile",
    "gdscript",
    "godot_resource",
    "gdshader",
    "gitignore",
    "graphql",
    "haskell",
    "hcl",
    "html",
    "hurl",
    "javascript",
    "json",
    -- "jsonc",
    "julia",
    "kdl",
    "lua",
    "luadoc",
    "markdown",
    "markdown_inline",
    "make",
    "nix",
    -- "org",
    "python",
    "query",
    "regex",
    "rust",
    "sparql",
    "sql",
    "svelte",
    "terraform",
    "tlaplus",
    "toml",
    "tsx",
    "turtle",
    "typescript",
    "vim",
    "vimdoc",
    "vue",
    "xml",
    "yaml",
}

local function setup_treesitter_config()
    -- local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

    -- local parsers = require("nvim-treesitter.parsers")
    --
    -- parsers.bruno = {
    --     install_info = {
    --         url = "https://github.com/Scalamando/tree-sitter-bruno",
    --         files = { "src/parser.c", "src/scanner.c" },
    --         branch = "main",
    --     },
    --     filetype = "bruno",
    -- }
    --
    -- parsers.cypher = {
    --     install_info = {
    --         url = "https://github.com/simplificare-org/tree-sitter-cypher",
    --         files = { "src/parser.c" },
    --         branch = "main",
    --     },
    --     filetype = "cypher",
    -- }
    --
    -- parsers.sql_bigquery = {
    --     install_info = {
    --         url = "https://github.com/takegue/tree-sitter-sql-bigquery",
    --         files = { "src/parser.c", "src/scanner.c" },
    --         branch = "main",
    --     },
    --     filetype = "sql",
    -- }
    --
    -- parsers.pgn = {
    --     install_info = {
    --         url = "https://github.com/rolandwalker/tree-sitter-pgn",
    --         files = { "src/parser.c", "src/scanner.c" },
    --     },
    --     filetype = "pgn",
    -- }

    local treesitter = require("nvim-treesitter")

    local opts = {
        install_dir = vim.fn.stdpath("data") .. "/site",
    }
    treesitter.setup(opts)
    treesitter.install(ensure_installed)

    -- FIX: registering custom TS parsers in version 0.12

    -- vim.treesitter.language.register("sql_bigquery", { "sqlx" })
    -- vim.treesitter.language.register("cypher", { "cypher" })
    -- vim.treesitter.language.register("markdown", { "codecompanion" })
end

return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
        "windwp/nvim-ts-autotag",
    },
    config = setup_treesitter_config,
}

-- TODO: export LST as json on a buffer level (using buffer-actions)
