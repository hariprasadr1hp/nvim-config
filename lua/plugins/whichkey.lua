-- lua/plugins/whichkey.lua

local function setup_delay_function()
    return function(ctx)
        return ctx.plugin and 0 or 200
    end
end

local function setup_filter_function()
    return function(mapping)
        return mapping == true
    end
end

local function setup_defer_function()
    return function(ctx)
        return ctx.mode == "V" or ctx.mode == "<C-V>"
    end
end

local plugins = {
    marks = true,
    registers = true,
    spelling = {
        enabled = true,
        suggestions = 20,
    },
    presets = {
        operators = true,
        motions = true,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
    },
}

local win = {
    no_overlap = true,
    padding = { 1, 2 },
    title = true,
    title_pos = "center",
    zindex = 1000,
    bo = {},
    wo = {},
}

local layout = {
    height = { min = 14, max = 25 },
    width = { min = 20, max = 50 },
    spacing = 3,
}

local keys = {
    scroll_down = "<c-d>",
    scroll_up = "<c-u>",
}

local icons = {
    breadcrumb = "»",
    separator = "➜",
    group = "+",
    ellipsis = "…",
    mappings = true,
    rules = {},
    colors = true,
    keys = {
        Up = " ",
        Down = " ",
        Left = " ",
        Right = " ",
        C = "󰘴 ",
        M = "󰘵 ",
        D = "󰘳 ",
        S = "󰘶 ",
        CR = "󰌑 ",
        Esc = "󱊷 ",
        ScrollWheelDown = "󱕐 ",
        ScrollWheelUp = "󱕑 ",
        NL = "󰌑 ",
        BS = "󰁮",
        Space = "󱁐 ",
        Tab = "󰌒 ",
        F1 = "󱊫",
        F2 = "󱊬",
        F3 = "󱊭",
        F4 = "󱊮",
        F5 = "󱊯",
        F6 = "󱊰",
        F7 = "󱊱",
        F8 = "󱊲",
        F9 = "󱊳",
        F10 = "󱊴",
        F11 = "󱊵",
        F12 = "󱊶",
    },
}

local opts = {
    ---@type false | "classic" | "modern" | "helix"
    preset = "classic",
    delay = setup_delay_function(),
    filter = setup_filter_function(),
    spec = {},
    notify = true,
    triggers = {
        { "<auto>", mode = "nxsot" },
    },
    defer = setup_defer_function(),
    plugins = plugins,
    win = win,
    layout = layout,
    keys = keys,
    sort = { "local", "order", "group", "alphanum", "mod" },
    expand = 0,
    icons = icons,
    show_help = true,
    show_keys = true,
    disable = {
        ft = {},
        bt = {},
    },
    debug = false,
}

local key_maps = {
    --- NORMAL MODE
    {
        mode = "n",

        { ",p", group = "swap-prev", nowait = false, remap = false },
        { ",n", group = "swap-next", nowait = false, remap = false },

        { "<leader>0", "0", desc = "^", nowait = false, remap = false },
        { "<leader>9", "$", desc = "$", nowait = false, remap = false },

        -- [A]CTION ----------------
        { "<leader>a", group = "action", nowait = false, remap = false },
        { "<leader>ac", group = "+copy", nowait = false, remap = false },
        { "<leader>av", group = "+paste", nowait = false, remap = false },
        { "<leader>ax", group = "+cut", nowait = false, remap = false },

        -- [B]UFFER ----------------
        { "<leader>b", group = "buffer", nowait = false, remap = false },

        -- [C]ODE -------------------
        { "<leader>c", group = "code", nowait = false, remap = false },
        { "<leader>cn", group = "neotest", nowait = false, remap = false },

        -- [D]EBUG ------------------
        { "<leader>d", group = "debug", nowait = false, remap = false },
        -- {
        --     "<leader>db",
        --     function()
        --         dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
        --     end,
        --     desc = "set-breakpoint",
        --     nowait = false,
        --     remap = false,
        -- },
        -- { "<leader>dd", "<cmd>DapContinue<CR>", desc = "continue", nowait = false, remap = false },
        -- { "<leader>di", "<cmd>DapStepInto<CR>", desc = "step-into", nowait = false, remap = false },
        -- { "<leader>do", "<cmd>DapStepOver<CR>", desc = "step-over", nowait = false, remap = false },
        -- {
        --     "<leader>dm",
        --     "<cmd>FloatermNew --autoclose=0 make debug<CR>",
        --     desc = "make debug",
        --     nowait = false,
        --     remap = false,
        -- },
        -- { "<leader>dr", "<cmd>DapToggleRepl<CR>", desc = "open-repl", nowait = false, remap = false },

        -- [E]VAL / [E]DIT -------
        { "<leader>e", group = "edit/eval", nowait = false, remap = false },

        -- [F]ILE -------------------
        { "<leader>f", group = "file", nowait = false, remap = false },
        { "<leader>fl", group = "logs", nowait = false, remap = false },

        -- [G]IT --------------------
        { "<leader>g", group = "git", nowait = false, remap = false },
        { "<leader>gh", group = "gitHub", nowait = false, remap = false },

        -- [H]ELP -------------------
        { "<leader>h", group = "help", nowait = false, remap = false },
        { "<leader>hh", group = "gitHunk", nowait = false, remap = false },
        { "<leader>hl", group = "harpoon", nowait = false, remap = false },

        -- [I]NFO / [I]NSERT --------
        { "<leader>i", group = "info", nowait = false, remap = false },

        -- [J]TABS ------------
        { "<leader>j", group = "tabs", nowait = false, remap = false },

        -- [L]ANGUAGE ----------------
        { "<leader>l", group = "lang", nowait = false, remap = false },

        -- [M]AKE -------------------
        { "<leader>m", group = "make", nowait = false, remap = false },
        { "<leader>ml", group = "link", nowait = false, remap = false },

        -- [N]OTES -------------------
        { "<leader>n", group = "notes", nowait = false, remap = false },

        ---- [j]ournal ---------------
        { "<leader>nj", group = "journal", nowait = false, remap = false },

        ---- [r]oam ------------------
        { "<leader>nr", group = "roam", nowait = false, remap = false },

        ---- [t]odo ------------------
        { "<leader>nt", group = "todo", nowait = false, remap = false },

        -- [O]PEN -------------------
        { "<leader>o", group = "open", nowait = false, remap = false },

        -- [P]ROJECT ----------------
        { "<leader>p", group = "project", nowait = false, remap = false },

        -- [Q]UIT / [Q]UICKFIX  -------------------
        { "<leader>q", group = "quit", nowait = false, remap = false },

        ---- trou[b]le ---------------
        { "<leader>qb", group = "trouBle", nowait = false, remap = false },

        -- [R]ELOAD ----------------
        { "<leader>r", group = "reload", nowait = false, remap = false },

        -- [S]EARCH ----------------
        { "<leader>s", group = "search", nowait = false, remap = false },

        -- [T]OGGLE ----------------
        { "<leader>t", group = "toggle", nowait = false, remap = false },
        -- { "<leader>tb", "<cmd>DapToggleBreakpoint<CR>", desc = "toggle-Breakpoint", nowait = false, remap = false },
        -- { "<leader>tz", "<cmd>ZenMode<CR>", desc = "wrap-text", nowait = false, remap = false },

        -- [W]INDOW ----------------
        { "<leader>w", group = "window", nowait = false, remap = false },

        -- MISC ----------------------
        { "<leader>x", group = "misc", nowait = false, remap = false },

        -- FU[Z]ZY ---------------
        { "<leader>z", group = "fuzzy", nowait = false, remap = false },

        ---- [g]it ----------------
        { "<leader>zg", group = "git", nowait = false, remap = false },

        ---- [s]earch ---------------
        { "<leader>zs", group = "search", nowait = false, remap = false },
    },

    --- VISUAL MODE
    {
        mode = "v",
        -- [G]IT ------------------
        { "<leader>g", group = "git", nowait = false, remap = false },

        -- [H]UNK ------------------
        { "<leader>hh", group = "gitHunk", nowait = false, remap = false },

        -- [S]EARCH -------------

        -- [T]OGGLE -------------
    },
}

local function setup_whichkey_config()
    local wk = require("which-key")
    wk.add(key_maps)
end

return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = opts,
    config = setup_whichkey_config,
}
