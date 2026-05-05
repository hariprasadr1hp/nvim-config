-- lua/plugins/flash.lua

return {
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {
            search = {
                multi_window = true,
                forward = true,
                wrap = true,
                ---@type Flash.Pattern.Mode
                mode = "exact",
            },

            jump = {
                -- save location in the jumplist
                jumplist = true,
                ---@type "start" | "end" | "range"
                pos = "end",
                -- add pattern to search history
                history = false,
                -- add pattern to search register
                register = false,
                -- clear highlight after jump
                nohlsearch = false,
                -- automatically jump when there is only one match
                autojump = false,
                -- You can force inclusive/exclusive jumps by setting the
                -- `inclusive` option. By default it will be automatically
                -- set based on the mode.
                inclusive = nil, ---@type boolean?
                -- jump position offset. Not used for range jumps.
                -- 0: default
                -- 1: when pos == "end" and pos < current position
                offset = nil, ---@type number
            },

            label = {
                uppercase = false,
                exclude = "",
                -- add a label for the first match in the current window.
                -- you can always jump to the first match with `<CR>`
                current = true,
                -- show the label after the match
                after = true, ---@type boolean|number[]
                -- show the label before the match
                before = false, ---@type boolean|number[]
                -- position of the label extmark
                style = "overlay", ---@type "eol" | "overlay" | "right_align" | "inline"
                -- flash tries to re-use labels that were already assigned to a position,
                -- when typing more characters. By default only lower-case labels are re-used.
                reuse = "lowercase", ---@type "lowercase" | "all" | "none"
                -- for the current window, label targets closer to the cursor first
                distance = true,
                -- minimum pattern length to show labels
                -- Ignored for custom labelers.
                min_pattern_length = 0,
                -- Enable this to use rainbow colors to highlight labels
                -- Can be useful for visualizing Treesitter ranges.
                rainbow = {
                    enabled = false,
                    -- number between 1 and 9
                    shade = 5,
                },
            },

            highlight = {
                -- show a backdrop with hl FlashBackdrop
                backdrop = true,
                -- Highlight the search matches
                matches = false,
                -- extmark priority
                priority = 5000,
                groups = {
                    match = "FlashMatch",
                    current = "FlashCurrent",
                    backdrop = "FlashBackdrop",
                    label = "FlashLabel",
                },
            },

            modes = {
                treesitter = {
                    label = {
                        before = false,
                        after = false,
                    },
                    highlight = {
                        backdrop = false,
                        matches = false,
                    },
                    prompt = {
                        enabled = false,
                    },
                },
            },
        },

        keys = {
            {
                "s",
                mode = { "n", "x", "o" },
                function()
                    require("flash").jump({
                        search = {
                            mode = "fuzzy",
                        },
                    })
                end,
                desc = "flash-fuzzy",
            },
            {
                "S",
                mode = { "n", "x", "o" },
                function()
                    require("flash").jump({
                        search = {
                            mode = "exact",
                        },
                    })
                end,
                desc = "flash-exact",
            },
            {
                "R",
                mode = { "o", "x" },
                function()
                    require("flash").treesitter_search()
                end,
                desc = "ts-search",
            },
            {
                "<c-s>",
                mode = { "c" },
                function()
                    require("flash").toggle()
                end,
                desc = "toggle-flash-search",
            },
            {
                "<leader>lk",
                mode = { "n", "x", "o" },
                function()
                    require("flash").treesitter({
                        labels = "Z",
                        actions = {
                            ["."] = "next",
                            [","] = "prev",
                        },
                    })
                end,
                desc = "ts-incremental-select",
            },
        },
    },
}
