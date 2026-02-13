--- textx.lua

local M = {}

function M.sort_wc(opts)
    local bufnr = 0
    local start_lnum = (opts and opts.line1) or 1
    local end_lnum = (opts and opts.line2) or vim.api.nvim_buf_line_count(bufnr)
    local reverse = (opts and opts.bang) or false

    -- Convert to 0-based indices for API (end is exclusive)
    local start_idx = start_lnum - 1
    local end_idx = end_lnum

    local lines = vim.api.nvim_buf_get_lines(bufnr, start_idx, end_idx, false)

    -- Stable sort: decorate with original index
    local decorated = {}
    for i, s in ipairs(lines) do
        decorated[i] = { s = s, len = #s, i = i }
    end

    table.sort(decorated, function(a, b)
        if a.len == b.len then
            return a.i < b.i
        end
        if reverse then
            return a.len > b.len
        else
            return a.len < b.len
        end
    end)

    for i = 1, #decorated do
        lines[i] = decorated[i].s
    end

    vim.api.nvim_buf_set_lines(bufnr, start_idx, end_idx, false, lines)
end

return M
