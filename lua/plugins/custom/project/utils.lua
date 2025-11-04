-- lua/plugins/custom/project/utils.lua

local M = {}

local fzflua = require("fzf-lua")

local function print_env_value()
    -- fuzzy search the environment variables, then print the corresponding value
    fzflua.fzf_exec(vim.tbl_keys(vim.fn.environ()), {
        prompt = "Environment variables> ",
        actions = {
            ["default"] = function(selected)
                print(selected[1] .. ": " .. vim.env[selected[1]])
            end,
        },
    })
end

local function copy_env_value()
    -- fuzzy search the environment variables, then copy the corresponding value to the clipboard
    fzflua.fzf_exec(vim.tbl_keys(vim.fn.environ()), {
        prompt = "Environment variables> ",
        actions = {
            ["default"] = function(selected)
                vim.fn.setreg("+", vim.env[selected[1]])
            end,
        },
    })
end

M = {
    print_env_value = print_env_value,
    copy_env_value = copy_env_value,
}

return M
