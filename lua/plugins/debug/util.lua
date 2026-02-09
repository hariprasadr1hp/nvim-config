-- lua/plugins/debug/util.lua
-- Shared utilities for the debug plugin.

local M = {}

---Delete a temp file if it exists and is readable. Returns nil so caller can clear their reference.
---@param filepath string|nil
---@return nil
function M.cleanup_temp_file(filepath)
    if filepath and vim.fn.filereadable(filepath) == 1 then
        pcall(vim.fn.delete, filepath)
    end
    return nil
end

---Discover and run setup() for each language module under plugins.debug.lang.
function M.setup_lang_configs()
    local lang_dir = vim.fn.stdpath("config") .. "/lua/plugins/debug/lang"
    local ok, files = pcall(vim.fn.readdir, lang_dir)
    if not ok or not files then
        return
    end
    for _, f in ipairs(files) do
        local name = f:match("^(.+)%.lua$")
        if name then
            local mod_ok, mod = pcall(require, "plugins.debug.lang." .. name)
            if mod_ok and type(mod) == "table" and type(mod.setup) == "function" then
                local setup_ok, err = pcall(mod.setup)
                if not setup_ok then
                    vim.notify(
                        string.format("Failed to setup debug for %s: %s", name, tostring(err)),
                        vim.log.levels.WARN
                    )
                end
            end
        end
    end
end

---Build DAP info lines: generic (adapters, configurations) then lang-specific
---for the current debug session type (e.g. Python adapter/runtime when in a python session).
---@return string[]
function M.build_dap_info_lines()
    local dap = require("dap")
    local lines = {
        "Debug Adapter Protocol Info",
        string.rep("─", 60),
        "",
    }

    -- 1. Status (session state)
    local session = dap.session()
    table.insert(lines, "Status:")
    if not session then
        table.insert(lines, "  no session")
    else
        local config_name = (session.config and session.config.name) or "—"
        table.insert(lines, string.format("  session: %s", config_name))
        local state = (session.stopped_thread_id and session.stopped_thread_id ~= 0) and "stopped" or "running"
        table.insert(lines, string.format("  state:   %s", state))
    end
    table.insert(lines, "")

    -- 2. Generic: configured adapters
    table.insert(lines, "Configured Adapters:")
    local adapter_count = 0
    for name, _ in pairs(dap.adapters or {}) do
        adapter_count = adapter_count + 1
        table.insert(lines, string.format("  • %s", name))
    end
    if adapter_count == 0 then
        table.insert(lines, "  (No adapters configured)")
    end
    table.insert(lines, "")

    -- 2. Generic: configurations by filetype
    table.insert(lines, "Configurations by Filetype:")
    local config_count = 0
    for ft, configs in pairs(dap.configurations or {}) do
        config_count = config_count + 1
        table.insert(lines, string.format("  %s:", ft))
        for i, config in ipairs(configs) do
            table.insert(lines, string.format("    %d. %s", i, config.name))
        end
    end
    if config_count == 0 then
        table.insert(lines, "  (No configurations loaded)")
    end
    table.insert(lines, "")

    -- 3. Lang-specific: only for the current debug session's type (e.g. python)
    if session and session.config and session.config.type then
        local lang_type = session.config.type
        local mod_ok, mod = pcall(require, "plugins.debug.lang." .. lang_type)
        if mod_ok and type(mod) == "table" and type(mod.get_info_lines) == "function" then
            mod.get_info_lines(lines)
        end
    end

    -- 4. Defaults (fallback and type-specific)
    table.insert(lines, "Defaults:")
    local defaults = dap.defaults
    if type(defaults) == "table" then
        for key, val in pairs(defaults) do
            if type(val) == "table" then
                local sub = {}
                for k, v in pairs(val) do
                    if type(v) ~= "function" then
                        table.insert(sub, string.format("%s=%s", k, tostring(v)))
                    else
                        table.insert(sub, string.format("%s=<fun>", k))
                    end
                end
                if #sub > 0 then
                    table.insert(lines, string.format("  %s: %s", key, table.concat(sub, ", ")))
                else
                    table.insert(lines, string.format("  %s: (table)", key))
                end
            else
                table.insert(lines, string.format("  %s: %s", key, tostring(val)))
            end
        end
        if not next(defaults) then
            table.insert(lines, "  (none set)")
        end
    else
        table.insert(lines, "  (not available)")
    end
    table.insert(lines, "")

    -- 5. Configuration providers (e.g. launch.json)
    table.insert(lines, "Providers:")
    local provider_count = 0
    local ok, vscode = pcall(require, "dap.ext.vscode")

    if ok and vscode.load_launchjs then
        table.insert(lines, "  • launch.json (dap.ext.vscode)")
        provider_count = provider_count + 1
    end

    local config_providers = rawget(dap, "configuration_providers") or rawget(dap, "config_providers")
    if type(config_providers) == "table" then
        for name, _ in pairs(config_providers) do
            table.insert(lines, string.format("  • %s", tostring(name)))
            provider_count = provider_count + 1
        end
    end
    if provider_count == 0 then
        table.insert(lines, "  (none registered)")
    end

    table.insert(lines, "")
    table.insert(lines, string.rep("─", 60))
    table.insert(lines, "Press 'q' to close this window.")

    return lines
end

---Open a centered floating buffer with the given lines (read-only, close with q).
---@param lines string[]
---@param filetype? string
function M.open_dap_floating_buffer(lines, filetype)
    local max_width = 0
    for _, line in ipairs(lines) do
        max_width = math.max(max_width, vim.fn.strdisplaywidth(line))
    end
    local width = math.min(math.max(62, max_width + 2), vim.o.columns - 4)
    local height = math.min(#lines, vim.o.lines - 4)

    local buf = vim.api.nvim_create_buf(false, true)
    local ft = filetype or "DapInfo"
    vim.bo[buf].filetype = ft
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].modifiable = false
    vim.bo[buf].readonly = true

    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)
    local win = vim.api.nvim_open_win(buf, true, {
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
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, silent = true })
end

---Pretty-print a value into lines (indented key-value; handles tables, avoids cycles).
---When depth is 0, inserts blank lines between sections for { / } paragraph motion.
---@param data any
---@param indent string
---@param depth number
---@param seen table
---@return string[]
function M.format_value(data, indent, depth, seen)
    indent = indent or ""
    depth = depth or 0
    seen = seen or {}
    local max_depth = 8
    local at_top = (depth == 0)

    if data == nil then
        return { indent .. "nil" }
    end
    if type(data) ~= "table" then
        if type(data) == "string" then
            return { indent .. ("%q"):format(data) }
        end
        if type(data) == "function" then
            return { indent .. "<function>" }
        end
        return { indent .. tostring(data) }
    end

    if seen[data] then
        return { indent .. "<cycle>" }
    end
    if depth >= max_depth then
        return { indent .. "{ ... }" }
    end
    seen[data] = true

    local lines = {}
    local next_indent = indent .. "  "
    local is_list = vim.islist(data) and #data > 0

    local function section_break()
        if at_top and #lines > 0 then
            table.insert(lines, "")
        end
    end

    if is_list then
        for i, v in ipairs(data) do
            section_break()
            if type(v) == "table" then
                table.insert(
                    lines,
                    indent .. string.format("┌ [%d] ─────────────────", i)
                )
                vim.list_extend(lines, M.format_value(v, next_indent, depth + 1, seen))
            else
                local pre = type(v) == "string" and ("%q"):format(v) or tostring(v)
                table.insert(lines, indent .. string.format("[%d]: %s", i, pre))
            end
        end
    end

    for k, v in pairs(data) do
        if is_list and type(k) == "number" and k >= 1 and k <= #data then
            goto continue
        end
        section_break()
        local key = type(k) == "string" and k or tostring(k)
        if type(v) == "table" then
            table.insert(lines, indent .. "▸ " .. key)
            vim.list_extend(lines, M.format_value(v, next_indent, depth + 1, seen))
        elseif type(v) == "function" then
            table.insert(lines, indent .. key .. ": <function>")
        elseif type(v) == "string" then
            table.insert(lines, indent .. key .. ": " .. ("%q"):format(v))
        else
            table.insert(lines, indent .. key .. ": " .. tostring(v))
        end
        ::continue::
    end

    return lines
end

---Format dap.session() or dap.sessions() into lines for display (pretty-printed).
---@param data table|nil
---@return string[]
function M.session_to_lines(data)
    if data == nil then
        return { "Session: (nil)" }
    end
    local sep = string.rep("─", 52)
    local lines = {
        "",
        "  DAP Session",
        "  " .. sep,
        "",
    }
    vim.list_extend(lines, M.format_value(data, "  ", 0, {}))
    table.insert(lines, "")
    return lines
end

---Deactivate interactive debug mode: remove keymaps and persistent notification.
---@param show_message boolean
function M.cleanup_interactive_mode(show_message)
    if not vim.g.dap_interactive_mode_active then
        return
    end
    vim.g.dap_interactive_mode_active = false

    -- Delete global keymaps using tracked keys
    if vim.g.dap_interactive_keys then
        for _, key in ipairs(vim.g.dap_interactive_keys) do
            pcall(vim.keymap.del, "n", key)
        end
        vim.g.dap_interactive_keys = nil
    end

    -- Clear the persistent notification if it exists
    if vim.g.dap_interactive_notif_id then
        pcall(function()
            require("mini.notify").remove(vim.g.dap_interactive_notif_id)
        end)
        vim.g.dap_interactive_notif_id = nil
    end

    if show_message then
        vim.api.nvim_echo({ { "-- interactive-debug-mode auto-exited (session terminated) --", "InfoMsg" } }, false, {})
    end
end

return M
