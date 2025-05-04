-- lua/config/neovide.lua

--[[
-- `brew install --cask neovide`
-- `neovide --maximized --fork --title-hidden --frame buttonless`
--]]

if vim.g.neovide then
    -- ANIMATIONS
    -------------------------------------------------------------------
    vim.g.neovide_position_animation_length = 0
    vim.g.neovide_cursor_animation_length = 0.00
    vim.g.neovide_cursor_trail_size = 0
    vim.g.neovide_cursor_animate_in_insert_mode = false
    vim.g.neovide_cursor_animate_command_line = false
    vim.g.neovide_scroll_animation_far_lines = 0
    vim.g.neovide_scroll_animation_length = 0.00

    -- GUI
    -------------------------------------------------------------------
    vim.o.guifont = "Hack Nerd Font Mono:h16" -- text below applies for VimScript
    vim.g.neovide_opacity = 1
    -- vim.g.neovide_opacity = 0.3

    -- CLIPBOARD
    -------------------------------------------------------------------
    local keymap_set = require("config.helpers").keymap_set

    -- vim.keymap.set('n', '<D-s>', ':w')
    keymap_set("v", "<D-c>", '"+y')
    keymap_set("n", "<D-v>", '"+P')
    keymap_set("v", "<D-v>", '"+P')
    keymap_set("c", "<D-v>", "+")
    keymap_set("i", "<D-v>", '<C-o>"+P')

    -- RUNTIME MODIFICATIONS
    -------------------------------------------------------------------
    vim.g.neovide_scale_factor = 1.0
    local scale_factor = 1.10

    local change_scale_factor = function(delta)
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end
    vim.keymap.set("n", "<D-=>", function()
        change_scale_factor(scale_factor)
    end)
    vim.keymap.set("n", "<D-->", function()
        change_scale_factor(1 / scale_factor)
    end)
end
