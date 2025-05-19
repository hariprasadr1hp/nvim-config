-- lua/config/functions.lua

local M = {}

-- Returns content from the range of line numbers,
-- relative to the current-line
---@param from_rel_lnum number
---@param to_rel_lnum number
---@return string[]
function M.GetTextBetweenLines(from_rel_lnum, to_rel_lnum)
    local current_line = vim.fn.getpos(".")[2]
    local start_line = current_line + from_rel_lnum - 1
    local end_line = current_line + to_rel_lnum
    return vim.api.nvim_buf_get_lines(0, start_line, end_line, false)
end

-- Returns contents of the visual selection as a string[],
-- split by lines
---@return string[]
function M.GetTextFromVisual()
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    return vim.api.nvim_buf_get_text(0, start_pos[2] - 1, start_pos[3] - 1, end_pos[2] - 1, end_pos[3], {})
end

-- Converts the input string or string[] to a floating window
-- without argument, the contents of the current-line is passed as input
-- and `q` to quit
---@param content string | string[] | nil
function M.as_floating_window(content)
    local lines = {}

    if content == nil then
        lines = M.GetTextBetweenLines(0, 0)
    elseif type(content) == "string" then
        lines = vim.split(content, "\n")
    elseif type(content) == "table" then
        lines = content
    end

    local dummy_buf = vim.api.nvim_create_buf(false, true)
    vim.bo[dummy_buf].filetype = "Dummmy"

    vim.api.nvim_buf_set_lines(dummy_buf, 0, -1, false, lines)

    local width, height = 70, #lines
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    local win = vim.api.nvim_open_win(dummy_buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
    })

    vim.wo[win].wrap = false
    vim.wo[win].cursorline = true
    vim.bo[dummy_buf].modifiable = false
    vim.bo[dummy_buf].readonly = true

    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = dummy_buf, silent = true })
end

--- Save the current visual selection to a temporary file under ~/.temp/zzz_XXXX.
--- The file is written to ~/.temp/zzz_{4-digit-random}. Example: ~/.temp/zzz_0243
--- @return nil
function M.SaveVisualSelection()
    -- Ensure ~/.temp exists
    vim.fn.mkdir(vim.fn.expand("~/.temp"), "p")

    -- Generate 4-digit random number
    local filename = string.format("%s/.temp/zzz_%04d", vim.fn.expand("~"), math.random(0, 9999))

    -- Save visual selection to file
    vim.cmd('silent! normal! "vy') -- Yank visual selection into register v
    local content = HP.GetTextFromVisual()
    vim.fn.writefile(content, filename)
    print("Wrote selection to " .. filename)
end

_G.HP = M
