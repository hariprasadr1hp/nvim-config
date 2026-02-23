-- after/plugin/logs.lua

if vim.g.vscode then
    return
end

local M = {}

local keymap_set = require("config.helpers").keymap_set

local get_os = require("config.helpers").get_os

local function os_path(values)
    local os = get_os()
    if os == "linux" then
        return values["linux"] or nil
    elseif os == "macos" then
        return values["macos"] or nil
    else
        return nil
    end
end

local global_fpaths = {
    { name = "codecompanion", desc = "", fpath = "~/.local/state/nvim/codecompanion.log" },
    { name = "codeium", desc = "", fpath = "~/.local/state/nvim/codeium/codeium.log" },
    { name = "conform", desc = "", fpath = "~/.local/state/nvim/conform.log" },
    { name = "lsp", desc = "", fpath = "~/.local/state/nvim/lsp.log" },
    { name = "mason", desc = "", fpath = "~/.local/state/nvim/mason.log" },
    { name = "mcp-hub", desc = "", fpath = "~/.local/state/mcp-hub/logs/mcp-hub.log" },
    { name = "neotest", desc = "", fpath = "~/.local/state/nvim/neotest.log" },
    { name = "nio", desc = "", fpath = "~/.local/state/nvim/nio.log" },
    { name = "overseer", desc = "", fpath = "~/.local/state/nvim/overseer.log" },
    { name = "rplugin", desc = "", fpath = "~/.local/share/nvim/rplugin.vim" },
    { name = "ruff", desc = "", fpath = "~/.local/share/ruff.log" },
    -- { name = "wezterm", desc = "", fpath = "" },
    -- { name = "aichat", desc = "", fpath = "" },
    -- { name = "starship", desc = "", fpath = "" },
    -- { name = "sqlfluff", desc = "", fpath = "" },
    -- { name = "claude", desc = "", fpath = "" },
    -- { name = "codex", desc = "", fpath = "" },
    -- { name = "gemini", desc = "", fpath = "" },
    -- { name = "cursor", desc = "", fpath = "" },
    -- { name = "opencode", desc = "", fpath = "" },
    -- { name = "dbui", desc = "", fpath = "" },
    -- { name = "poetry", desc = "", fpath = "" },
}

function M.show_logs()
    vim.ui.select(
        vim.tbl_map(function(entry)
            local fpath = entry.fpath
            if fpath then
                local expanded_path = vim.fn.expand(fpath)
                if vim.fn.filereadable(expanded_path) == 1 then
                    return { name = entry.name, path = expanded_path }
                end
            end
            return nil
        end, global_fpaths),
        {
            prompt = "Select Log File",
            format_item = function(item)
                if item then
                    return item.name
                end
                return ""
            end,
        },
        function(choice)
            if choice and choice.path then
                -- Get total line count
                local total_lines_str = vim.fn.system(string.format("wc -l < %s", vim.fn.shellescape(choice.path)))
                local total_lines = tonumber(vim.trim(total_lines_str)) or 0

                -- Create a new buffer with only the last 1000 lines
                local lines = vim.fn.systemlist(string.format("tail -n 1000 %s", vim.fn.shellescape(choice.path)))

                -- Create a new buffer
                vim.cmd("enew")
                local bufnr = vim.api.nvim_get_current_buf()

                -- Set buffer options
                vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
                vim.bo[bufnr].buftype = "nofile"
                vim.bo[bufnr].bufhidden = "wipe"
                vim.bo[bufnr].swapfile = false
                vim.bo[bufnr].modifiable = true

                -- Set buffer name with context
                local displayed = math.min(1000, total_lines)
                vim.api.nvim_buf_set_name(
                    bufnr,
                    string.format("%s (showing last %d/%d)", choice.name, displayed, total_lines)
                )

                -- Scroll to bottom
                vim.cmd("normal! G")
            end
        end
    )
end

function M.setup_keymaps()
    keymap_set("n", "<leader>vl", M.show_logs, "show_logs")
end

function M.setup()
    M.setup_keymaps()
end

M.setup()

return M
