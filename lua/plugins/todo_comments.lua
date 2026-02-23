-- lua/plugins/todo_comments.lua

local keywords = {
    -- FIX = { icon = "󱢇 ", color = "error", alt = { "BUG", "ISSUE" } },
    -- WARN = { icon = " ", color = "warning" },
    -- TODO = { icon = " ", color = "info" },
    -- PERF = { icon = " ", alt = { "OPTIM" } },
    -- NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
    -- TEST = { icon = "⏲ ", color = "test", alt = { "PASSED", "FAILED" } },
    -- LEARN = { icon = " ", color = "info" },
    -- REFER = { icon = "󰏢", color = "info" },

    FIX = { icon = "", color = "error", alt = { "BUG", "ISSUE" } },
    WARN = { icon = "", color = "warning" },
    TODO = { icon = "", color = "info" },
    PERF = { icon = "", alt = { "OPTIM" } },
    NOTE = { icon = "", color = "hint", alt = { "INFO" } },
    TEST = { icon = "", color = "test", alt = { "PASSED", "FAILED" } },
    LEARN = { icon = "", color = "info" },
    REFER = { icon = "", color = "info" },
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

    -- BUG: jumplists for todo comments need to cycle-through after reaching the last one
    keymap_set("n", "]t", todo_comments.jump_next, "Next todo comment")
    keymap_set("n", "[t", todo_comments.jump_prev, "Previous todo comment")
    -- BUG: `:TodoLocList` collects todo-comment across project, not local to the file
    keymap_set("n", "<leader>qlt", ":TodoLocList<cr>", "todos-to-loclist")
    keymap_set("n", "<leader>qt", ":TodoQuickFix<cr>", "todos-to-quickfix")
    keymap_set("n", "<leader>zt", ":TodoFzfLua keywords=TODO,FIX<cr>", "todos")
end

return {
    "folke/todo-comments.nvim",
    -- cmd = { "TodoFzfLua", "TodoQuickFix" },
    -- keys = {
    --     { "<leader>pq", "<cmd>TodoQuickFix<cr>", desc = "quickfix-todo" },
    --     { "<leader>zt", "<cmd>TodoFzfLua keywords=TODO,FIX<cr>", desc = "todos" },
    -- },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "ibhagwan/fzf-lua",
    },
    config = setup_keymaps,
}

-- TODO: ability to select todo-keyword options
-- TODO: quickfix options, based on the todo-label
-- <leader>qtt to add all todo-label
-- <leader>qtf to add only-fix todo-labels
