-- lua/helpers.lua

local M = {}

-- Print tables, as well as numbers/strings
function M.pprint(value)
    if type(value) == "table" then
        print(vim.inspect(value))
    else
        print(value)
    end
    return value
end

-- Print (type) of tables, as well as numbers/strings
function M.tprint(value)
    print(type(value))
end

-- Helper function to feed keys with termcode replacements
function M.feedkeys(keys, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), mode, true)
end

-- checks if it is in recording mode
function M.is_recording()
    return vim.fn.reg_recording() ~= ""
end

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

M.load_env_file()

_G.pprint = M.pprint
_G.P = M.pprint
_G.tprint = M.tprint
_G.T = M.tprint

return M
