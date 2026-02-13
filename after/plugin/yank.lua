-- after/plugin/yank.lua
-- Yank stuff

if vim.g.vscode then
    return
end

local keymap_set = require("config.helpers").keymap_set

--- ExtMark virtual text module
---@class VirtTextModule
local M = {}

--- Extract virtual text from extmarks on a specific line
---@param buf integer Buffer handle (0 for current buffer)
---@param lnum0 integer 0-indexed line number
---@return string Concatenated virtual text from all extmarks on the line
function M.get_virt_text_on_line(buf, lnum0)
    local extmarks = vim.api.nvim_buf_get_extmarks(
        buf,
        -1, -- all namespaces
        { lnum0, 0 },
        { lnum0, -1 },
        { details = true }
    )

    local parts = {} ---@type string[]
    for _, mark in ipairs(extmarks) do
        local details = mark[4]
        if details and details.virt_text then
            for _, chunk in ipairs(details.virt_text) do
                -- chunk = {text, hl_group}
                parts[#parts + 1] = chunk[1]
            end
        end
    end

    return table.concat(parts, "")
end

--- Yank text to a register and the unnamed register
---@param text string Text to yank
---@param reg? string Register name (defaults to "+")
function M.yank_to_register(text, reg)
    reg = reg or "+"
    vim.fn.setreg(reg, text)
    -- Also set to unnamed register for easier pasting
    vim.fn.setreg('"', text)
    vim.notify(("Yanked text to register %s"):format(reg), vim.log.levels.INFO)
end

--- Get the comment string for the current buffer's filetype
---@return string Comment string (defaults to "---")
function M.get_comment_string()
    local commentstring = vim.bo.commentstring
    if commentstring and commentstring ~= "" then
        -- Extract the comment part before the %s placeholder
        local comment = commentstring:match("^(.-)%%s") or commentstring:match("^(.-) %%s") or commentstring
        -- Remove trailing spaces
        comment = comment:gsub("%s+$", "")
        return comment ~= "" and comment or "---"
    end
    return "---"
end

--- Get the current line number (0-indexed)
---@return integer Line number (0-indexed)
function M.get_current_line_number()
    return vim.api.nvim_win_get_cursor(0)[1] - 1
end

--- Collect virtual text from a range of lines
---@param buf integer Buffer handle (0 for current buffer)
---@param start_lnum1 integer Start line (1-indexed)
---@param end_lnum1 integer End line (1-indexed)
---@return string[] Array of virtual text strings, one per line
function M.collect_virt_text_range(buf, start_lnum1, end_lnum1)
    local lines = {} ---@type string[]
    for lnum1 = start_lnum1, end_lnum1 do
        local vt = M.get_virt_text_on_line(buf, lnum1 - 1)
        lines[#lines + 1] = vt
    end
    return lines
end

--- Handle YankExtMark command
--- Yanks virtual text from the current line
---@param opts table Command options with 'args' field
function M.handle_yank_extmark(opts)
    local reg = opts.args ~= "" and opts.args or "+"
    local buf = 0
    local lnum0 = M.get_current_line_number()
    local vt = M.get_virt_text_on_line(buf, lnum0)
    M.yank_to_register(vt, reg)
end

--- Handle YankExtMarks command
--- Yanks virtual text from a range of lines
---@param opts table Command options with 'line1', 'line2', and 'args' fields
function M.handle_yank_extmarks(opts)
    local buf = 0
    local start_lnum1 = opts.line1
    local end_lnum1 = opts.line2
    local reg = opts.args ~= "" and opts.args or "+"

    local lines = M.collect_virt_text_range(buf, start_lnum1, end_lnum1)
    local text = table.concat(lines, "\n")
    M.yank_to_register(text, reg)
end

--- Handle YankActualAndExtMark command
--- Yanks both actual line text and virtual text from the current line
---@param opts table Command options with 'args' field
function M.handle_yank_actual_and_extmark(opts)
    local reg = opts.args ~= "" and opts.args or "+"
    local buf = 0
    local lnum0 = M.get_current_line_number()

    -- Get actual line text
    local actual_text = vim.api.nvim_buf_get_lines(buf, lnum0, lnum0 + 1, false)[1] or ""

    -- Get virtual text
    local virt_text = M.get_virt_text_on_line(buf, lnum0)

    -- Combine: actual text + comment delimiter + virtual text (if virtual text exists)
    local combined_text = actual_text
    if virt_text ~= "" then
        local comment = M.get_comment_string()
        combined_text = actual_text .. " " .. comment .. " " .. virt_text
    end

    M.yank_to_register(combined_text, reg)
end

--- Handle YankActualAndExtMarks command
--- Yanks both actual text and virtual text from a range of lines
---@param opts table Command options with 'line1', 'line2', and 'args' fields
function M.handle_yank_actual_and_extmarks(opts)
    local buf = 0
    local start_lnum1 = opts.line1
    local end_lnum1 = opts.line2
    local reg = opts.args ~= "" and opts.args or "+"

    local combined_lines = {} ---@type string[]
    local comment = M.get_comment_string()

    for lnum1 = start_lnum1, end_lnum1 do
        local lnum0 = lnum1 - 1

        local actual_text = vim.api.nvim_buf_get_lines(buf, lnum0, lnum0 + 1, false)[1] or ""
        local virt_text = M.get_virt_text_on_line(buf, lnum0)

        -- actual text + comment delimiter + virtual text (if virtual text exists)
        local combined_text = actual_text
        if virt_text ~= "" then
            combined_text = actual_text .. " " .. comment .. " " .. virt_text
        end

        combined_lines[#combined_lines + 1] = combined_text
    end

    local text = table.concat(combined_lines, "\n")
    M.yank_to_register(text, reg)
end

--- Setup user commands for virtual text yanking
function M.setup_commands()
    -- :YankExtMark [reg] -> yanks virt text of current line (defaults to +)
    vim.api.nvim_create_user_command("YankExtMark", M.handle_yank_extmark, {
        nargs = "?",
        desc = "Yank `extmark` from current line",
    })

    -- :'<,'>YankExtMarks [reg]
    -- Yanks raw virtual text from each line in the range (one per line)
    -- No headers, no line numbers - just the raw virtual text
    -- reg: defaults to +
    vim.api.nvim_create_user_command("YankExtMarks", M.handle_yank_extmarks, {
        nargs = "?",
        range = true,
        desc = "Yank `extmark` from each line in range",
    })

    -- :YankActualAndExtMark [reg] -> yanks both actual and virtual text of current line
    vim.api.nvim_create_user_command("YankActualAndExtMark", M.handle_yank_actual_and_extmark, {
        nargs = "?",
        desc = "Yank both actual and `extmark` from current line",
    })

    -- :'<,'>YankActualAndExtMarks [reg]
    -- Yanks both actual and virtual text from each line in the range
    vim.api.nvim_create_user_command("YankActualAndExtMarks", M.handle_yank_actual_and_extmarks, {
        nargs = "?",
        range = true,
        desc = "Yank both actual and `extmark` from each line in range",
    })
end

function M.setup_keymaps()
    keymap_set("n", "<leader>ye", function()
        M.yank_to_register(vim.fn.expand("%:e"))
    end, "yank-file-ext")
    keymap_set("n", "<leader>yf", function()
        M.yank_to_register(vim.fn.expand("%:t"))
    end, "yank-file-name")
    keymap_set("n", "<leader>yp", function()
        M.yank_to_register(vim.fn.expand("%:p"))
    end, "yank-file-path")
    keymap_set("n", "<leader>yv", "<cmd>YankExtMark<cr>", "yank-virt-text")
    keymap_set("n", "<leader>yV", "<cmd>YankActualAndExtMark<cr>", "yank-act-and-virt-text")

    keymap_set("x", "<leader>yv", ":'<,'>YankExtMarks<cr>", "yank-virt-texts")
    keymap_set("x", "<leader>yV", ":'<,'>YankActualAndExtMarks<cr>", "yank-act-and-virt-texts")
end

function M.setup()
    M.setup_commands()
    M.setup_keymaps()
end

M.setup()

return M
