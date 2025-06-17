-- lua/plugins/text_objects.lua

local opts = {
    textobjects = {
        select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to target.vim
            lookahead = true,

            keymaps = {
                ["a="] = { query = "@assignment.outer", desc = "around-assignment" },
                ["i="] = { query = "@assignment.inner", desc = "inner-assignment" },
                ["l="] = { query = "@assignment.lhs", desc = "left-assignment" },
                ["r="] = { query = "@assignment.rhs", desc = "right-assignment" },

                ["ai"] = { query = "@conditional.outer", desc = "around-conditional" },
                ["ii"] = { query = "@conditional.inner", desc = "inner-conditional" },

                ["al"] = { query = "@loop.outer", desc = "around-loop" },
                ["il"] = { query = "@loop.outer", desc = "inner-loop" },

                ["af"] = { query = "@function.outer", desc = "around-function" },
                ["if"] = { query = "@function.inner", desc = "inner-function" },

                ["ac"] = { query = "@class.outer", desc = "around-class" },
                ["ic"] = { query = "@class.inner", desc = "inner-class" },
            },
            include_surrounding_whitespace = false,
        },

        swap = {
            enable = true,
            swap_next = {
                [",na"] = "@parameter.outer",
                [",nf"] = "@function.outer",
            },

            swap_previous = {
                [",pa"] = "@parameter.outer",
                [",pf"] = "@function.outer",
            },
        },

        move = {
            enable = true,
            set_jumps = true,

            -- TODO: `[o` jumps: to goto prev/next text object under cursor
            -- TODO: `[f` jumps: to goto prev/next functions,
            goto_previous_start = {
                ["[f"] = { query = "@function.outer", desc = "prev-function" },
                ["[o"] = { query = "", desc = "prev-object" },
            },

            goto_previous_end = {
                ["[F"] = { query = "@function.outer", desc = "prev-function" },
                ["[O"] = { query = "", desc = "prev-object" },
            },

            goto_next_start = {
                ["]f"] = { query = "@function.outer", desc = "next-function" },
                ["]o"] = { query = "", desc = "next-object" },
            },

            goto_next_end = {
                ["]F"] = { query = "@function.outer", desc = "next-function" },
                ["]O"] = { query = "", desc = "next-object" },
            },
        },
    },
}

return {
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        lazy = true,
        opts = opts,
    },
}
