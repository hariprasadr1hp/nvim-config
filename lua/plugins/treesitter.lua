-- lua/plugins/treesitter.lua

local ensure_installed = {
    "arduino",
    "awk",
    "bash",
    "c",
    "cpp",
    "css",
    "csv",
    "diff",
    "dockerfile",
    "gdscript",
    "gitignore",
    "graphql",
    "haskell",
    "html",
    "hurl",
    "javascript",
    "json",
    "julia",
    "kdl",
    "lua",
    "luadoc",
    "markdown",
    "markdown_inline",
    "make",
    "org",
    "python",
    "query",
    "regex",
    "rust",
    "sql",
    "svelte",
    "terraform",
    "tlaplus",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "vue",
    "yaml",
}

local highlight = {
    enable = true,
    additional_vim_regex_highlighting = { "ruby" },
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
    ignore_install = { "org" },
    highlight = highlight,
    indent = indent,
    incremental_selection = incremental_selection,
    autotag = autotag,
}

local function setup_treesitter_config()
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
