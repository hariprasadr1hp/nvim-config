-- after/plugin/buffer_info.lua

local map = require("config.helpers").map

local function get_lsp_clients(buf_id)
    local clients = vim.lsp.get_clients({ bufnr = buf_id })
    if #clients == 0 then
        return "None"
    end

    local names = {}
    for _, client in ipairs(clients) do
        table.insert(names, client.name)
    end
    return table.concat(names, ", ")
end

local function get_treesitter_status(buf_id)
    local ok, hl = pcall(require, "vim.treesitter.highlighter")
    if not ok or not hl.active then
        return "Unknown"
    end
    return hl.active[buf_id] and "✔ Enabled" or "✘ Disabled"
end

local function get_blink_sources()
    local ok, blink = pcall(require, "blink")
    if not ok or not blink.sources then
        return "None"
    end

    local sources = {}
    for name, source in pairs(blink.sources) do
        if not source.is_available or source.is_available() then
            table.insert(sources, name)
        end
    end

    return #sources > 0 and table.concat(sources, ", ") or "None"
end

local function get_diagnostics_count(buf_id)
    local ok, diag = pcall(vim.diagnostic.count, buf_id)
    if not ok or not diag then
        return "Unavailable"
    end

    return string.format(
        "E:%d W:%d I:%d H:%d",
        diag[vim.diagnostic.severity.ERROR] or 0,
        diag[vim.diagnostic.severity.WARN] or 0,
        diag[vim.diagnostic.severity.INFO] or 0,
        diag[vim.diagnostic.severity.HINT] or 0
    )
end

local function get_buffer_metadata(buf_id)
    local bo = vim.bo[buf_id]
    local name = vim.api.nvim_buf_get_name(buf_id)
    local shortname = name ~= "" and vim.fn.fnamemodify(name, ":~:.") or "[No Name]"

    return {
        { "Buffer ID:", buf_id },
        { "Name:", shortname },
        { "Type:", bo.buftype ~= "" and bo.buftype or "(normal)" },
        { "Filetype:", bo.filetype },
        { "Lines:", vim.api.nvim_buf_line_count(buf_id) },
        { "Encoding:", bo.fileencoding },
        { "Format:", bo.fileformat },
        { "Listed:", bo.buflisted and "✔" or "✘" },
        { "Loaded:", vim.api.nvim_buf_is_loaded(buf_id) and "✔" or "✘" },
        { "Modifiable:", bo.modifiable and "✔" or "✘" },
        { "Hidden:", bo.bufhidden ~= "" and bo.bufhidden or "none" },
        { "Modified:", bo.modified and "✔ Yes" or "✘ No" },
        { "LSP Clients:", get_lsp_clients(buf_id) },
        { "Tree-sitter:", get_treesitter_status(buf_id) },
        { "Completion:", get_blink_sources() },
        { "Diagnostics:", get_diagnostics_count(buf_id) },
        { "CWD:", vim.fn.fnamemodify(vim.fn.getcwd(), ":~") },
    }
end

local function get_buffer_info()
    local buf_id = vim.api.nvim_get_current_buf()
    local items = get_buffer_metadata(buf_id)

    local lines = { "🔍 Current Buffer Info", string.rep("─", 50) }
    for _, pair in ipairs(items) do
        table.insert(lines, string.format("%-15s %s", pair[1], pair[2]))
    end
    table.insert(lines, string.rep("─", 50))
    table.insert(lines, "Press 'q' to close this window.")

    local info_buf = vim.api.nvim_create_buf(false, true)
    vim.bo[info_buf].filetype = "BufferInfo"
    vim.api.nvim_buf_set_lines(info_buf, 0, -1, false, lines)

    local width = 70
    local height = #lines
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    local win = vim.api.nvim_open_win(info_buf, true, {
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
    vim.bo[info_buf].modifiable = false
    vim.bo[info_buf].readonly = true
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = info_buf, silent = true })
end

vim.api.nvim_create_user_command("BufferInfo", get_buffer_info, {})

map("n", "<leader>ib", get_buffer_info, "buffer-info")
