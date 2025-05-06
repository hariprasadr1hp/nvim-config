-- lua/helpers.lua

local vars = require("config.variables")

local M = {}

-- print table, as well as numbers/strings
function M.pprint(value)
    if type(value) == "table" then
        print(vim.inspect(value))
    else
        print(value)
    end
    return value
end

-- prints (type) of table, as well as numbers/strings
function M.tprint(value)
    print(type(value))
end

-- setting keymaps
function M.keymap_set(mode, lhs, rhs, desc, key_opts)
    local opts = vim.tbl_extend("force", {
        noremap = true,
        silent = true,
        desc = desc or (type(rhs) == "string" and rhs or nil),
    }, key_opts or {})

    vim.keymap.set(mode, lhs, rhs, opts)
end

-- checks if it is in recording mode
---@return boolean
function M.is_recording()
    return vim.fn.reg_recording() ~= ""
end

-- command string to execute the file, based on filetype (if defined)
---@return string | nil
function M.eval_cmd_by_ft()
    local cmds_by_ft = {
        python = " python " .. vim.fn.expand("%:p"),
        javascript = " node " .. vim.fn.expand("%:p"),
        lua = " lua " .. vim.fn.expand("%:p"),
        c = " gcc " .. vim.fn.expand("%:p") .. " -o /tmp/a.out && /tmp/a.out",
        cpp = " g++ " .. vim.fn.expand("%:p") .. " -o /tmp/a.out && /tmp/a.out",
    }
    return cmds_by_ft[vim.bo.filetype] or nil
end

-- load all the variables from the `.env` file (by default)
-- for custom loading, pass the filename as an argument
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

-- handle toggling to "automcmd debugging"
-- when toggled on, prints the triggered events
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
