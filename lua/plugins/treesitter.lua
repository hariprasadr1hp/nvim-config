-- lua/plugins/treesitter.lua

local M = {}

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
    disable = { "ruby" },
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

local setup_treesitter = function()
    MiniDeps.add({
        source = "nvim-treesitter/nvim-treesitter",
        checkout = "master",
        monitor = "main",
        hooks = {
            post_checkout = function()
                vim.cmd("TSUpdate")
            end,
        },
    })

    require("nvim-treesitter.configs").setup(opts)
end

MiniDeps.later(setup_treesitter)

-- TODO: extend selection to neighbouring-node (prev/next)?
-- TODO: extend selection to [COUNT]neighbouring-node (prev/next)?
