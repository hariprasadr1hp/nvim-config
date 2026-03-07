-- after/plugin/linenumbers.lua

-- Render the color of linenumbers based on its mode,
-- or something mimicking a mode (macros for example)

if vim.g.vscode then
    return
end

local is_recording = require("config.helpers").is_recording
local line_numbers_augroup = vim.api.nvim_create_augroup("LineNumbers", { clear = true })

local colors = {
    red = "#e06c75",
    yellowish_green = "#98c379",
    green = "#71b951",
    yellow = "#e5c07b",
    blue = "#0987ff",
    purple = "#c678dd",
    white = "#ffffff",
    black = "#000000",
}

local function set_normal_mode_colors()
    vim.api.nvim_set_hl(0, "LineNr", { fg = colors.red, bold = true })
    vim.api.nvim_set_hl(0, "LineNrAbove", { fg = colors.green })
    vim.api.nvim_set_hl(0, "LineNrBelow", { fg = colors.green })
end

local function set_insert_mode_colors()
    vim.api.nvim_set_hl(0, "LineNr", { fg = colors.red, bold = true })
    vim.api.nvim_set_hl(0, "LineNrAbove", { fg = colors.yellow })
    vim.api.nvim_set_hl(0, "LineNrBelow", { fg = colors.yellow })
end

local function set_replace_mode_colors()
    vim.api.nvim_set_hl(0, "LineNr", { fg = colors.red, bold = true })
    vim.api.nvim_set_hl(0, "LineNrAbove", { fg = colors.white })
    vim.api.nvim_set_hl(0, "LineNrBelow", { fg = colors.white })
end

local function set_terminal_mode_colors()
    vim.api.nvim_set_hl(0, "LineNr", { fg = colors.red, bold = true })
    vim.api.nvim_set_hl(0, "LineNrAbove", { fg = colors.purple })
    vim.api.nvim_set_hl(0, "LineNrBelow", { fg = colors.purple })
end

local function set_cmdline_mode_colors()
    vim.api.nvim_set_hl(0, "LineNr", { fg = colors.red, bold = true })
    vim.api.nvim_set_hl(0, "LineNrAbove", { fg = colors.black })
    vim.api.nvim_set_hl(0, "LineNrBelow", { fg = colors.black })
end

local function set_visual_mode_colors()
    vim.api.nvim_set_hl(0, "LineNr", { fg = colors.yellowish_green, bold = true })
    vim.api.nvim_set_hl(0, "LineNrAbove", { fg = colors.red })
    vim.api.nvim_set_hl(0, "LineNrBelow", { fg = colors.red })
end

local function set_while_recording_colors()
    vim.api.nvim_set_hl(0, "LineNr", { fg = colors.blue, bold = true })
    vim.api.nvim_set_hl(0, "LineNrAbove", { fg = colors.blue })
    vim.api.nvim_set_hl(0, "LineNrBelow", { fg = colors.blue })
end

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = set_normal_mode_colors,
})

vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = "*",
    callback = function()
        local mode = vim.fn.mode()
        if is_recording() then
            set_while_recording_colors()
        elseif mode == "n" then
            set_normal_mode_colors()
        elseif mode == "i" then
            set_insert_mode_colors()
        elseif mode == "t" then
            set_terminal_mode_colors()
        elseif mode == "R" then
            set_replace_mode_colors()
        elseif mode == "v" or mode == "V" then
            set_visual_mode_colors()
        elseif mode == "c" then
            set_cmdline_mode_colors()
        else
            set_normal_mode_colors()
        end
    end,
})

vim.api.nvim_create_autocmd("RecordingEnter", {
    pattern = "*",
    group = line_numbers_augroup,
    callback = set_while_recording_colors,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
    pattern = "*",
    group = line_numbers_augroup,
    callback = set_normal_mode_colors,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
    pattern = "*",
    group = line_numbers_augroup,
    callback = set_normal_mode_colors,
})
