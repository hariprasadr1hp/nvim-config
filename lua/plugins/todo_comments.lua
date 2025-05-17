-- lua/plugins/todo_comments.lua

local keywords = {
    FIX = {
        icon = " ",
        color = "error",
        alt = { "BUG", "ISSUE" },
    },
    TODO = { icon = " ", color = "info" },
    HACK = { icon = " ", color = "warning" },
    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
    PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
    NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
    TEST = { icon = "⏲ ", color = "test", alt = { "PASSED", "FAILED" } },
    LEARN = { icon = " ", color = "info" },
}

local gui_style = {
    fg = "NONE",
    bg = "BOLD",
}

local highlight = {
    multiline = true,
    multiline_pattern = "^.",
    multiline_context = 10,
    before = "",
    keyword = "wide",
    after = "fg",
    pattern = [[.*<(KEYWORDS)\s*:]],
    comments_only = true,
    max_line_len = 400,
    exclude = {},
}

local colors = {
    error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
    warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
    info = { "DiagnosticInfo", "#2563EB" },
    hint = { "DiagnosticHint", "#10B981" },
    default = { "Identifier", "#7C3AED" },
    test = { "Identifier", "#FF00FF" },
}

local search = {
    command = "rg",
    args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
    },
    pattern = [[\b(KEYWORDS):]], -- ripgrep regex pattern
}

local opts = {
    signs = true,
    sign_priority = 8,
    keywords = keywords,
    gui_style = gui_style,
    merge_keywords = true,
    highlight = highlight,
    colors = colors,
    search = search,
}

local function setup_keymaps()
    local keymap_set = require("config.helpers").keymap_set
    local todo_comments = require("todo-comments")
    todo_comments.setup(opts)

    -- TODO: jumplists for todo comments need to cycle-through after reach the last one
    keymap_set("n", "]t", todo_comments.jump_next, "Next todo comment")
    keymap_set("n", "[t", todo_comments.jump_prev, "Previous todo comment")
    keymap_set("n", "<leader>pq", ":TodoQuickFix<CR>", "todos-to-quickfix")
    keymap_set("n", "<leader>qt", ":TodoQuickFix<CR>", "todos-to-quickfix")
    keymap_set("n", "<leader>zt", ":TodoFzfLua keywords=TODO,FIX<CR>", "Previous todo comment")
end

return {
    "folke/todo-comments.nvim",
    -- cmd = { "TodoFzfLua", "TodoQuickFix" },
    -- keys = {
    --     { "<leader>pq", "<cmd>TodoQuickFix<CR>", desc = "quickfix-todo" },
    --     { "<leader>zt", "<cmd>TodoFzfLua keywords=TODO,FIX<CR>", desc = "todos" },
    -- },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "ibhagwan/fzf-lua",
    },
    config = setup_keymaps,
}
