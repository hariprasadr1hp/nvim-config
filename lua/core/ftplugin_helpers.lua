-- lua/core/ftplugin_helpers.lua
-- Utilities for creating filetype-specific settings that auto-revert

local M = {}

--- Apply window-local settings that automatically revert when switching filetypes
--- @param filetype string The filetype to apply settings for
--- @param opts table Configuration options
---   - win_opts: table of window options to set (e.g., {cursorline = true})
---   - buf_opts: table of buffer options to set (e.g., {readonly = true})
---   - keymaps: table of keymaps to set (e.g., {{"n", "<Tab>", "<Plug>(Action)", {silent = true}}})
---   - on_enter: function|nil callback when entering the filetype window
---   - on_leave: function|nil callback when leaving the filetype window
---   - winhighlight: table|nil highlight overrides {active = "Normal:ActiveBg", inactive = "Normal:InactiveBg"}
function M.setup_reversible_settings(filetype, opts)
    opts = opts or {}

    local augroup = vim.api.nvim_create_augroup("FtPlugin_" .. filetype, { clear = false })

    -- Save original window-local settings
    local original_win_opts = {}
    if opts.win_opts then
        for opt, _ in pairs(opts.win_opts) do
            original_win_opts[opt] = vim.wo[opt]
        end
    end

    -- Save original buffer-local settings
    local original_buf_opts = {}
    if opts.buf_opts then
        for opt, _ in pairs(opts.buf_opts) do
            original_buf_opts[opt] = vim.bo[opt]
        end
    end

    -- Save original winhighlight
    local original_winhighlight = vim.wo.winhighlight

    -- Apply window-local settings
    if opts.win_opts then
        for opt, value in pairs(opts.win_opts) do
            vim.wo[opt] = value
        end
    end

    -- Apply buffer-local settings
    if opts.buf_opts then
        for opt, value in pairs(opts.buf_opts) do
            vim.opt_local[opt] = value
        end
    end

    -- Apply buffer-local keymaps
    if opts.keymaps then
        for _, keymap in ipairs(opts.keymaps) do
            local mode = keymap[1]
            local lhs = keymap[2]
            local rhs = keymap[3]
            local keymap_opts = keymap[4] or {}

            -- Ensure buffer-local mapping
            keymap_opts.buffer = true

            vim.keymap.set(mode, lhs, rhs, keymap_opts)
        end
    end

    -- Apply winhighlight if provided
    if opts.winhighlight then
        if opts.winhighlight.inactive then
            vim.wo.winhighlight = opts.winhighlight.inactive
        end

        -- Dynamic highlight for focus
        if opts.winhighlight.active or opts.winhighlight.inactive then
            vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
                group = augroup,
                buffer = 0,
                callback = function()
                    if vim.bo.filetype == filetype and opts.winhighlight.active then
                        vim.wo.winhighlight = opts.winhighlight.active
                    end
                    if opts.on_enter then
                        opts.on_enter()
                    end
                end,
            })

            vim.api.nvim_create_autocmd("WinLeave", {
                group = augroup,
                buffer = 0,
                callback = function()
                    if vim.bo.filetype == filetype and opts.winhighlight.inactive then
                        vim.wo.winhighlight = opts.winhighlight.inactive
                    end
                    if opts.on_leave then
                        opts.on_leave()
                    end
                end,
            })
        end
    else
        -- Setup on_enter/on_leave callbacks without winhighlight
        if opts.on_enter then
            vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
                group = augroup,
                buffer = 0,
                callback = function()
                    if vim.bo.filetype == filetype then
                        opts.on_enter()
                    end
                end,
            })
        end

        if opts.on_leave then
            vim.api.nvim_create_autocmd("WinLeave", {
                group = augroup,
                buffer = 0,
                callback = function()
                    if vim.bo.filetype == filetype then
                        opts.on_leave()
                    end
                end,
            })
        end
    end

    -- Restore original settings when leaving the buffer
    vim.api.nvim_create_autocmd("BufWinLeave", {
        group = augroup,
        buffer = 0,
        callback = function()
            -- Restore window options
            for opt, value in pairs(original_win_opts) do
                vim.wo[opt] = value
            end

            -- Restore buffer options
            for opt, value in pairs(original_buf_opts) do
                vim.bo[opt] = value
            end

            -- Restore winhighlight
            vim.wo.winhighlight = original_winhighlight
        end,
    })
end

return M
