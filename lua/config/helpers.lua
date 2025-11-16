-- lua/helpers.lua

local vars = require("config.variables")

local M = {}

-- Print table, as well as numbers/strings
function M.pprint(value)
    if type(value) == "table" then
        print(vim.inspect(value))
    else
        print(value)
    end
    return value
end

-- Prints (type) of table, as well as numbers/strings
function M.tprint(value)
    print(type(value))
end

-- Setting keymaps
function M.keymap_set(mode, lhs, rhs, desc, key_opts)
    local opts = vim.tbl_extend("force", {
        noremap = true,
        silent = true,
        desc = desc or (type(rhs) == "string" and rhs or nil),
    }, key_opts or {})

    vim.keymap.set(mode, lhs, rhs, opts)
end

-- Checks if it is in recording mode
---@return boolean
function M.is_recording()
    return vim.fn.reg_recording() ~= ""
end

-- Command string to execute the file, based on filetype (if defined)
---@return string | nil
function M.eval_cmd_by_ft()
    local cmds_by_ft = {
        c = " gcc " .. vim.fn.expand("%:p") .. " -o /tmp/a.out && /tmp/a.out",
        cpp = " g++ " .. vim.fn.expand("%:p") .. " -o /tmp/a.out && /tmp/a.out",
        javascript = " node " .. vim.fn.expand("%:p"),
        julia = " julia " .. vim.fn.expand("%:p"),
        lua = " lua " .. vim.fn.expand("%:p"),
        python = " python " .. vim.fn.expand("%:p"),
    }
    return cmds_by_ft[vim.bo.filetype] or nil
end

-- Load all the variables from the `.env` file (by default)
-- For custom loading, pass the filename as an argument
---@param filepath string | nil
function M.load_env_file(filepath)
    local file = io.open(filepath or ".env", "r")
    if not file then
        return
    end

    for line in file:lines() do
        -- ignore comments and empty lines
        if not line:match("^%s*#") and line:match("%S") then
            local key, value = line:match("^%s*([%w_.-]+)%s*=%s*(.*)%s*$")
            if key and value then
                -- remove surrounding quotes if any
                value = value:gsub("^[\"']", ""):gsub("[\"']$", "")
                vim.env[key] = value
            end
        end
    end

    file:close()
end

-- Read a file and return its contents as a string.
---@param path string
---@return string|nil
function M.read_file_as_str(path)
    local file, _ = io.open(path, "r")
    if not file then
        vim.notify(string.format("Error: `%s` not found!", path), vim.log.levels.ERROR)
        return nil
    end
    print("file exiists...")
    local content = file:read("*a")
    file:close()
    return content
end

-- Read and decode a JSON file.
---@param path string
---@return table|nil
function M.read_json(path)
    local content = M.read_file_as_str(path)
    if not content then
        return nil
    end

    ---@type boolean, table
    local ok, result = pcall(vim.fn.json_decode, content)
    return ok and result or nil
end

---Get the operating system name
---@return OSName
function M.get_os()
    local sys = vim.uv.os_uname().sysname

    if sys == "Darwin" then
        return "macos"
    elseif sys == "Linux" then
        return "linux"
    elseif sys == "Windows_NT" or sys:match("Windows") then
        return "windows"
    else
        return "unknown"
    end
end

---Get distro ID
---@return Distro
function M.get_distro()
    local os = M.get_os()
    if os == "macos" then
        return "macos"
    elseif os == "windows" then
        return "windows"
    elseif os == "linux" then
        local ok, lines = pcall(vim.fn.readfile, "/etc/os-release")
        if not ok or not lines then
            return "other"
        end
        local data = table.concat(lines, "\n")
        local id = data:match("ID=([%w%-_]+)")
        return id or "other"
    else
        return "other"
    end
end

--- Resolve local or remote plugin source
---@param name string
---@param local_path string
---@param remote string
---@param opts table?
---@return table
function M.use_local_or_remote_plugin_path(name, local_path, remote, opts)
    opts = opts or {}
    opts.name = name

    ---@diagnostic disable-next-line: undefined-field
    if vim.loop.fs_stat(local_path) then
        opts.dir = local_path
    else
        opts[1] = remote
    end

    return opts
end

-- Handle toggling to "automcmd debugging"
-- When toggled on, prints the triggered events
function M.toggle_autocmd_debug()
    if vars.autocmd_debug_enabled then
        vim.api.nvim_clear_autocmds({ group = vars.autocmd_debug_augroup })
        print("🔇 Autocmd debug OFF")
        vars.autocmd_debug_enabled = false
    else
        for _, event in ipairs(vars.autocmd_debug_events) do
            vim.api.nvim_create_autocmd(event, {
                group = vars.autocmd_debug_augroup,
                callback = function(args)
                    print(
                        "🔔 Autocmd:",
                        args.event,
                        "buf=" .. args.buf,
                        "file=" .. vim.api.nvim_buf_get_name(args.buf)
                    )
                end,
            })
        end
        print("🔊 Autocmd debug ON")
        vars.autocmd_debug_enabled = true
    end
end

_G.pprint = M.pprint
_G.P = M.pprint
_G.tprint = M.tprint
_G.T = M.tprint

-- load nvim-config .env variables
M.load_env_file(vim.fn.stdpath("config") .. "/.env")

return M
