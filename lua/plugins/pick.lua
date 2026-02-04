-- lua/plugins/pick.lua

local opts = {
    delay = {
        async = 10,
        busy = 50,
    },

    mappings = {
        caret_left = "<Left>",
        caret_right = "<Right>",

        choose = "<cr>",
        choose_in_split = "<C-s>",
        choose_in_tabpage = "<C-t>",
        choose_in_vsplit = "<C-v>",
        choose_marked = "<M-CR>",

        delete_char = "<BS>",
        delete_char_right = "<Del>",
        delete_left = "<C-u>",
        delete_word = "<C-w>",

        mark = "<C-x>",
        mark_all = "<C-a>",

        move_down = "<C-n>",
        move_start = "<C-g>",
        move_up = "<C-p>",

        paste = "<C-r>",

        refine = "<C-Space>",
        refine_marked = "<M-Space>",

        scroll_down = "<C-f>",
        scroll_left = "<C-h>",
        scroll_right = "<C-l>",
        scroll_up = "<C-b>",

        stop = "<Esc>",

        toggle_info = "<S-Tab>",
        toggle_preview = "<Tab>",
    },

    options = {
        content_from_bottom = false,
        use_cache = true,
    },

    source = {
        items = nil,
        name = nil,
        cwd = nil,

        match = nil,
        show = nil,
        preview = nil,

        choose = nil,
        choose_marked = nil,
    },

    window = {
        config = nil,
        prompt_caret = "▏",
        prompt_prefix = "> ",
    },
}

local function setup_mini_pick_config()
    require("mini.pick").setup(opts)

    local keymap_set = require("config.helpers").keymap_set

    keymap_set("n", "<leader>,", ":Pick files<cr>", "files")
    keymap_set("n", "<leader>bb", ":Pick buffers<cr>", "buffers")
    keymap_set("n", "<leader>bB", ":Pick buffers<cr>", "buffers")
end

return {
    {
        "echasnovski/mini.pick",
        version = false,
        config = setup_mini_pick_config,
    },
}

-- TODO: keymap `<M-{1,2,3,4,5}>` to select choice, by the order
