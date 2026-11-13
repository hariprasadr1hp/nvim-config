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

-- Custom (non-bundled) parsers. On the `main` branch these must be registered
-- inside a `User TSUpdate` autocmd, then installed with `:TSInstall <name>`.
-- `install_info.files` no longer exists; parsers are compiled from `src/`.
local custom_parsers = {
    bruno = {
        install_info = {
            url = "https://github.com/Scalamando/tree-sitter-bruno",
            revision = "dd27fe0eff8e7f8184dfc91e426b886dc8369c46", -- pin; bump to update
            queries = "queries", -- copy highlights/injections shipped by the repo
        },
        tier = 3, -- community/unsupported
    },
    -- cypher = {
    --     install_info = { url = "https://github.com/simplificare-org/tree-sitter-cypher", branch = "main" },
    -- },
    -- sql_bigquery = {
    --     install_info = { url = "https://github.com/takegue/tree-sitter-sql-bigquery", branch = "main" },
    -- },
    -- pgn = {
    --     install_info = { url = "https://github.com/rolandwalker/tree-sitter-pgn" },
    -- },
}

-- parser -> filetypes, for when the parser name differs from the filetype
-- (this is core Neovim API, no plugin needed)
local language_aliases = {
    -- sql_bigquery = { "sqlx" },
    -- cypher = { "cypher" },
    -- markdown = { "codecompanion" },
}

local function setup_treesitter_config()
    vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        group = vim.api.nvim_create_augroup("user_ts_custom_parsers", { clear = true }),
        callback = function()
            local parsers = require("nvim-treesitter.parsers")
            for name, spec in pairs(custom_parsers) do
                parsers[name] = spec
            end
        end,
    })

    for lang, filetypes in pairs(language_aliases) do
        vim.treesitter.language.register(lang, filetypes)
    end

    local treesitter = require("nvim-treesitter")
    treesitter.setup()

    -- only install what's missing; avoids spawning the installer on every startup
    local installed = treesitter.get_installed("parsers")
    local missing = vim.tbl_filter(function(lang)
        return not vim.list_contains(installed, lang)
    end, ensure_installed)
    if #missing > 0 then
        treesitter.install(missing)
    end
end

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false, -- `main` branch does not support lazy-loading
        build = ":TSUpdate",
        config = setup_treesitter_config,
    },
    {
        "windwp/nvim-ts-autotag",
        event = { "BufReadPre", "BufNewFile" },
        opts = {}, -- ensures `require("nvim-ts-autotag").setup()` is called
    },
}

-- TODO: export LST as json on a buffer level (using buffer-actions)
