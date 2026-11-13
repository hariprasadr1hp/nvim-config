-- lua/plugins/text_objects.lua
--
-- NOTE: on the `main` branch, `setup()` only accepts behaviour options
-- (`select`, `move`). Keymaps are NOT read from the config table and must be
-- defined explicitly with `vim.keymap.set`.

---@type TSTextObjects.UserConfig
local opts = {
    select = {
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
        include_surrounding_whitespace = false,
    },
    move = {
        set_jumps = true,
    },
}

-- { lhs, query, desc }
local select_maps = {
    { "a=", "@assignment.outer", "around-assignment" },
    { "i=", "@assignment.inner", "inner-assignment" },
    { "l=", "@assignment.lhs", "left-assignment" },
    { "r=", "@assignment.rhs", "right-assignment" },

    { "ai", "@conditional.outer", "around-conditional" },
    { "ii", "@conditional.inner", "inner-conditional" },

    { "al", "@loop.outer", "around-loop" },
    { "il", "@loop.inner", "inner-loop" },

    { "af", "@function.outer", "around-function" },
    { "if", "@function.inner", "inner-function" },

    { "ac", "@class.outer", "around-class" },
    { "ic", "@class.inner", "inner-class" },
}

-- { lhs, method, query, desc }
local swap_maps = {
    { ",na", "swap_next", "@parameter.inner", "swap-next-parameter" },
    { ",nf", "swap_next", "@function.outer", "swap-next-function" },
    { ",pa", "swap_previous", "@parameter.inner", "swap-prev-parameter" },
    { ",pf", "swap_previous", "@function.outer", "swap-prev-function" },
}

-- { lhs, method, query, desc }
-- TODO: `[o`/`]o` jumps: goto prev/next text object under cursor
local move_maps = {
    { "]f", "goto_next_start", "@function.outer", "next-function-start" },
    { "]F", "goto_next_end", "@function.outer", "next-function-end" },
    { "[f", "goto_previous_start", "@function.outer", "prev-function-start" },
    { "[F", "goto_previous_end", "@function.outer", "prev-function-end" },
}

local function setup_text_objects_config()
    require("nvim-treesitter-textobjects").setup(opts)

    local select = require("nvim-treesitter-textobjects.select")
    for _, m in ipairs(select_maps) do
        vim.keymap.set({ "x", "o" }, m[1], function()
            select.select_textobject(m[2], "textobjects")
        end, { desc = m[3] })
    end

    local swap = require("nvim-treesitter-textobjects.swap")
    for _, m in ipairs(swap_maps) do
        vim.keymap.set("n", m[1], function()
            swap[m[2]](m[3])
        end, { desc = m[4] })
    end

    local move = require("nvim-treesitter-textobjects.move")
    for _, m in ipairs(move_maps) do
        vim.keymap.set({ "n", "x", "o" }, m[1], function()
            move[m[2]](m[3], "textobjects")
        end, { desc = m[4] })
    end
end

return {
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        init = function()
            -- Disable built-in ftplugin mappings (e.g. python's `]f`) to avoid conflicts.
            vim.g.no_plugin_maps = true
        end,
        config = setup_text_objects_config,
    },
}
