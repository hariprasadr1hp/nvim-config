-- after/plugin/linenumbers.lua

-- Line numbers act as a mode indicator in the active window.
--
-- Active window:
--   - relative line numbers
--   - mode-specific colors
--
-- Inactive windows:
--   - absolute line numbers
--   - muted color

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
    inactive = "#625e5a",
}

-- Mode colors ----------------------------------------------------------------

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

local function set_mode_colors()
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
end

-- Inactive windows -----------------------------------------------------------

local inactive_mappings = {
    "LineNr:InactiveLineNr",
    "LineNrAbove:InactiveLineNr",
    "LineNrBelow:InactiveLineNr",
}

local function set_inactive_line_number_colors()
    vim.api.nvim_set_hl(0, "InactiveLineNr", {
        fg = colors.inactive,
    })
end

local function remove_inactive_mappings(winhighlight)
    for _, mapping in ipairs(inactive_mappings) do
        local escaped = vim.pesc(mapping)

        winhighlight = winhighlight:gsub("," .. escaped, "")
        winhighlight = winhighlight:gsub("^" .. escaped .. ",?", "")
    end

    return winhighlight
end

local function add_inactive_mappings(winhighlight)
    for _, mapping in ipairs(inactive_mappings) do
        if not winhighlight:find(mapping, 1, true) then
            winhighlight = winhighlight .. (winhighlight == "" and "" or ",") .. mapping
        end
    end

    return winhighlight
end

local function set_window_active()
    vim.wo.relativenumber = vim.wo.number

    vim.wo.winhighlight = remove_inactive_mappings(vim.wo.winhighlight)
end

local function set_window_inactive()
    vim.wo.relativenumber = false

    vim.wo.winhighlight = add_inactive_mappings(vim.wo.winhighlight)
end

-- Autocommands ---------------------------------------------------------------

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    group = line_numbers_augroup,
    callback = function()
        set_mode_colors()
        set_inactive_line_number_colors()
    end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = "*",
    group = line_numbers_augroup,
    callback = set_mode_colors,
})

vim.api.nvim_create_autocmd("RecordingEnter", {
    pattern = "*",
    group = line_numbers_augroup,
    callback = set_while_recording_colors,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
    pattern = "*",
    group = line_numbers_augroup,
    callback = set_mode_colors,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
    pattern = "*",
    group = line_numbers_augroup,
    callback = set_mode_colors,
})

vim.api.nvim_create_autocmd("WinEnter", {
    group = line_numbers_augroup,
    callback = set_window_active,
})

vim.api.nvim_create_autocmd("WinLeave", {
    group = line_numbers_augroup,
    callback = set_window_inactive,
})

-- Initial state ---------------------------------------------------------------

set_inactive_line_number_colors()
set_mode_colors()
set_window_active()
