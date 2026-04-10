-- lua/plugins/whichkey.lua

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
    group = "",
    ellipsis = "…",
    mappings = true,
    rules = {
        { pattern = "action", icon = "󱌣 ", color = "red" },
        { pattern = "clear", icon = " ", color = "yellow" },
        { pattern = "debug", icon = "󰃤 ", color = "red" },
        { pattern = "eval", icon = " ", color = "cyan" },
        { pattern = "fuzzy", icon = " ", color = "cyan" },
        { pattern = "help", icon = " ", color = "cyan" },
        { pattern = "info", icon = "󰙎 ", color = "cyan" },
        { pattern = "lang", icon = "󱌯 ", color = "cyan" },
        { pattern = "make", icon = "󱌣", color = "red" },
        { pattern = "misc", icon = "󰸿 ", color = "cyan" },
        { pattern = "notes", icon = " ", color = "yellow" },
        { pattern = "open", icon = " ", color = "cyan" },
        { pattern = "project", icon = " ", color = "cyan" },
        { pattern = "quickfix", icon = "󰁨 ", color = "cyan" },
        { pattern = "reload", icon = "󰑓 ", color = "cyan" },
        { pattern = "undo", icon = "󰕍 ", color = "cyan" },
        { pattern = "verbose", icon = " ", color = "cyan" },
        { pattern = "yank", icon = "󰆒 ", color = "cyan" },
    },
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
    delay = function(ctx)
        return ctx.plugin and 0 or 200
    end,
    filter = function(mapping)
        return mapping.desc ~= nil or mapping.group ~= nil
    end,
    defer = function(ctx)
        return ctx.mode == "V" or ctx.mode == "\22"
    end,
    spec = {},
    notify = true,
    triggers = {
        { "<auto>", mode = "nxsot" },
    },
    plugins = plugins,
    win = win,
    layout = layout,
    keys = keys,
    -- sort = { "local", "order", "group", "alphanum", "mod" },
    sort = { "alphanum" },
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

        { ",p", group = "swap-prev+", nowait = false, remap = false },
        { ",n", group = "swap-next+", nowait = false, remap = false },

        { "<leader>0", "0", desc = "^", nowait = false, remap = false },
        { "<leader>9", "$", desc = "$", nowait = false, remap = false },

        -- FILETYPE
        { "<leader>;", group = "filetype+", nowait = false, remap = false },

        -- [A]CTION ----------------
        { "<leader>a", group = "action+", nowait = false, remap = false },
        { "<leader>ac", group = "copy+", nowait = false, remap = false },
        { "<leader>ad", group = "diff+", nowait = false, remap = false },
        { "<leader>ag", group = "args+", nowait = false, remap = false },
        { "<leader>ap", group = "ai-prompts+", nowait = false, remap = false },
        { "<leader>aq", group = "macro-replay+", nowait = false, remap = false },
        { "<leader>av", group = "paste+", nowait = false, remap = false },
        { "<leader>ax", group = "cut+", nowait = false, remap = false },

        -- [B]UFFER ----------------
        { "<leader>b", group = "buffer+", nowait = false, remap = false },

        -- [C]ODE -------------------
        { "<leader>c", group = "code+", nowait = false, remap = false },
        { "<leader>cn", group = "neotest+", nowait = false, remap = false },

        -- [D]EBUG ------------------
        { "<leader>d", group = "debug+", nowait = false, remap = false },

        -- [E]VAL / [E]DIT -------
        { "<leader>e", group = "edit/eval+", nowait = false, remap = false },

        -- [F]ILE -------------------
        { "<leader>f", group = "file+", nowait = false, remap = false },
        { "<leader>fl", group = "logs+", nowait = false, remap = false },

        -- [G]IT --------------------
        { "<leader>g", group = "git+", nowait = false, remap = false },
        { "<leader>gd", group = "gitdiff+", nowait = false, remap = false },
        { "<leader>gh", group = "gitHub+", nowait = false, remap = false },
        { "<leader>gl", group = "last-commit+", nowait = false, remap = false },

        -- [H]ELP -------------------
        { "<leader>h", group = "help+", nowait = false, remap = false },
        { "<leader>hh", group = "hunk+", nowait = false, remap = false },
        { "<leader>hl", group = "harpoon+", nowait = false, remap = false },
        { "<leader>hr", group = "reload+", nowait = false, remap = false },

        -- [I]NFO / [I]NSERT --------
        { "<leader>i", group = "info+", nowait = false, remap = false },

        -- [J]TABS ------------
        { "<leader>j", group = "tabs+", nowait = false, remap = false },

        -- [K]MISC ------------
        { "<leader>k", group = "misc+", nowait = false, remap = false },

        -- [L]ANGUAGE ----------------
        { "<leader>l", group = "lang+", nowait = false, remap = false },

        -- [M]AKE -------------------
        { "<leader>m", group = "make+", nowait = false, remap = false },
        { "<leader>ml", group = "link+", nowait = false, remap = false },

        -- [N]OTES -------------------
        { "<leader>n", group = "notes+", nowait = false, remap = false },
        { "<leader>nj", group = "journal+", nowait = false, remap = false },
        { "<leader>nr", group = "roam+", nowait = false, remap = false },
        { "<leader>nt", group = "todo+", nowait = false, remap = false },

        -- [O]PEN -------------------
        { "<leader>o", group = "open+", nowait = false, remap = false },

        -- [P]ROJECT ----------------
        { "<leader>p", group = "project+", nowait = false, remap = false },

        -- [Q]UIT / [Q]UICKFIX  -------------------
        { "<leader>q", group = "quickfix+", nowait = false, remap = false },
        { "<leader>qd", group = "diagnostics+", nowait = false, remap = false },
        { "<leader>ql", group = "loclist+", nowait = false, remap = false },
        { "<leader>qld", group = "diagnostics+", nowait = false, remap = false },

        -- [R]ELOAD ----------------
        { "<leader>r", group = "reload+", nowait = false, remap = false },
        { "<leader>rd", group = "debug-session+", nowait = false, remap = false },
        { "<leader>rl", group = "last+", nowait = false, remap = false },
        { "<leader>rr", group = "refactor+", nowait = false, remap = false },
        { "<leader>rs", group = "session+", nowait = false, remap = false },

        -- [S]EARCH ----------------
        { "<leader>s", group = "search/stash+", nowait = false, remap = false },
        { "<leader>sc", group = "current+", nowait = false, remap = false },
        { "<leader>st", group = "trouble+", nowait = false, remap = false },

        -- [T]OGGLE ----------------
        { "<leader>t", group = "toggle+", nowait = false, remap = false },

        -- [U]NDO ----------------
        { "<leader>u", group = "undo+", nowait = false, remap = false },

        -- [V]ERBOSE ----------------
        { "<leader>v", group = "verbose+", nowait = false, remap = false },

        -- [W]INDOW ----------------
        { "<leader>w", group = "window+", nowait = false, remap = false },

        -- CLEAR ---------------------
        { "<leader>x", group = "clear+", nowait = false, remap = false },

        -- [Y]ANK --------------------
        { "<leader>y", group = "yank+", nowait = false, remap = false },

        -- FU[Z]ZY ---------------
        { "<leader>z", group = "fuzzy+", nowait = false, remap = false },
        { "<leader>zg", group = "git+", nowait = false, remap = false },
        { "<leader>zs", group = "search+", nowait = false, remap = false },
    },

    --- VISUAL MODE
    {
        mode = "v",
        -- FILETYPE
        { "<leader>;", group = "filetype+", nowait = false, remap = false },

        -- [A]CTION ----------------
        { "<leader>a", group = "action+", nowait = false, remap = false },
        { "<leader>ac", group = "copy+", nowait = false, remap = false },
        { "<leader>aq", group = "macro-replay+", nowait = false, remap = false },
        { "<leader>av", group = "paste+", nowait = false, remap = false },
        { "<leader>ax", group = "cut+", nowait = false, remap = false },

        -- [G]IT ------------------
        { "<leader>g", group = "git+", nowait = false, remap = false },

        -- [H]UNK ------------------
        { "<leader>h", group = "help+", nowait = false, remap = false },
        { "<leader>hh", group = "hunk+", nowait = false, remap = false },

        -- [R]ELOAD ----------------
        { "<leader>r", group = "reload+", nowait = false, remap = false },
        { "<leader>rr", group = "refactor+", nowait = false, remap = false },

        -- [S]EARCH -------------
        { "<leader>s", group = "search/stash+", nowait = false, remap = false },

        -- [T]OGGLE -------------
        { "<leader>t", group = "toggle+", nowait = false, remap = false },

        -- [Y]ANK --------------------
        { "<leader>y", group = "yank+", nowait = false, remap = false },
    },
}

local function setup_whichkey_config()
    local wk = require("which-key")
    wk.setup(opts)
    wk.add(key_maps)
end

return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = setup_whichkey_config,
}
