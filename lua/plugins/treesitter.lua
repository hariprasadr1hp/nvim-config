-- lua/plugins/treesitter.lua

local ensure_installed = {
    "arduino",
    "awk",
    "bash",
    "beancount",
    "bibtex",
    "bruno",
    "c",
    "cmake",
    "cpp",
    "css",
    "csv",
    "cypher",
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
    "jsonc",
    "julia",
    "kdl",
    "lua",
    "luadoc",
    "markdown",
    "markdown_inline",
    "make",
    "nix",
    "org",
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
    "yaml",
}

local highlight = {
    enable = true,
    additional_vim_regex_highlighting = { "ruby", "sqlx" },
}

local indent = {
    enable = true,
    disable = {
        "ruby",
    },
}

local incremental_selection = {
    enable = true,
    keymaps = {
        init_selection = "<leader>lk",
        node_incremental = ".",
        node_decremental = ",",
        scope_incremental = "<c-space>",
    },
}

local autotag = {
    enable = true,
}

local opts = {
    ensure_installed = ensure_installed,
    sync_install = false,
    auto_install = true,
    ignore_install = { "org", "latex" },
    highlight = highlight,
    indent = indent,
    incremental_selection = incremental_selection,
    autotag = autotag,
}

local function setup_treesitter_config()
    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

    parser_config.bruno = {
        install_info = {
            url = "https://github.com/Scalamando/tree-sitter-bruno",
            files = { "src/parser.c", "src/scanner.c" },
            branch = "main",
        },
        filetype = "bruno",
    }

    parser_config.cypher = {
        install_info = {
            url = "https://github.com/simplificare-org/tree-sitter-cypher",
            files = { "src/parser.c" },
            branch = "main",
        },
        filetype = "cypher",
    }

    parser_config.sql_bigquery = {
        install_info = {
            url = "https://github.com/takegue/tree-sitter-sql-bigquery",
            files = { "src/parser.c", "src/scanner.c" },
            branch = "main",
        },
        filetype = "sql",
    }

    parser_config.pgn = {
        install_info = {
            url = "https://github.com/rolandwalker/tree-sitter-pgn",
            files = { "src/parser.c", "src/scanner.c" },
        },
        filetype = "pgn",
    }

    vim.treesitter.language.register("sql_bigquery", "sqlx")
    vim.treesitter.language.register("cypher", "cypher")

    local treesitter = require("nvim-treesitter.configs")
    treesitter.setup(opts)
end

return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
        "windwp/nvim-ts-autotag",
    },
    config = setup_treesitter_config,
}

-- TODO: extend selection to neighbouring-node (prev/next)?

-- TODO: extend selection to [COUNT]neighbouring-node (prev/next)?

-- TODO: export LST as json on a buffer level (using buffer-actions)
