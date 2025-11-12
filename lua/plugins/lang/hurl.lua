-- lua/plugins/lang/hurl.lua

local opts = {
    env_file = {
        ".env",
    },
    debug = false,
    show_notification = true,
    ---@type "split" | "popup"
    mode = "popup",
    formatters = {
        json = { "jq" },
        html = {
            "prettier",
            "--parser",
            "html",
        },
        xml = {
            "tidy",
            "-xml",
            "-i",
            "-q",
        },
    },
    mappings = {
        close = "q",
        next_panel = "<C-n>",
        prev_panel = "<C-p>",
    },
}

return {
    "jellydn/hurl.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    ft = "hurl",
    opts = opts,
    cmd = {
        "HurlRunner",
        "HurlSetVariable",
        "HurlSetEnvFile",
        "HurlRunnerToEntry",
        "HurlShowLastResponse",
        "HurlVerbose",
        "HurlVeryVerbose",
    },
}
