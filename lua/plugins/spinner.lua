-- lua/plugins/spinner.lua

local opts = {
    -- Pre-defined pattern key name in
    -- https://github.com/xieyonn/spinner.nvim/blob/main/lua/spinner/pattern.lua
    pattern = "dots",

    -- Time-to-live in milliseconds since the most recent start, after which the
    -- spinner stops, preventing it from running indefinitely.
    ttl_ms = 0,

    -- Milliseconds to wait after startup before showing the spinner.
    -- This helps prevent the spinner from briefly flashing for short-lived tasks.
    initial_delay_ms = 0,

    -- Text displayed when the spinner is inactive.
    -- Used in statusline/tabline/winbar/extmark/cursor
    --
    -- true: show an empty string, with length equal to spinner frames.
    -- false: equals to "".
    -- or string values
    --
    -- eg: show ✔ when lsp progress finished.
    placeholder = false,

    cursor_spinner = {
        -- Highlight group for text, use fg of `Comment` by default.
        hl_group = "Spinner",

        -- CursorSpinner window option.
        winblend = 60,

        -- CursorSpinner window option.
        zindex = 50,

        -- CursorSpinner window position, relative to cursor.
        -- row = -1 col = 1 means Top-Right next to cursor.
        row = -1,
        col = 1,

        -- CursorSpinner window option.
        border = "none",
    },

    extmark_spinner = {
        -- Highlight group for text, use fg of `Comment` by default.
        hl_group = "Spinner",
    },

    cmdline_spinner = {
        -- Highlight group for text, use fg of `Comment` by default.
        hl_group = "Spinner",
    },
}

return {
    {
        "xieyonn/spinner.nvim",
        config = function()
            require("spinner").setup(opts)
        end,
    },
}
