-- lua/commands.lua

local helpers = require("config.helpers")

local user_cmd = vim.api.nvim_create_user_command
local autocmd = vim.api.nvim_create_autocmd

-- USER-COMMANDS
------------------------------------------------------------------------------------------------
user_cmd("SaveWithNoFormat", function()
    vim.cmd("noautocmd w")
end, { desc = "save the file without applying any formatting options" })

user_cmd("LoadEnvFile", function()
    helpers.load_env_file()
end, { desc = "load the environmental variables from a file (`.env` by default)" })

user_cmd("Runme", function()
    vim.cmd("! " .. require("config.helpers").eval_cmd_by_ft())
end, { desc = "evalute the buffer code (if applicable)" })

user_cmd("MakeAsMakePrg", function()
    vim.o.makeprg = "make"
end, { desc = "defaults to `make` as the `makeprg`" })

user_cmd("PytestAsMakePrg", function()
    vim.o.makeprg = "pytest"
end, { desc = "sets `pytest` as the `makeprg`" })

user_cmd("GetFilePath", function()
    print(vim.fn.expand("%:p"))
end, {})

user_cmd("GetFileName", function()
    print(vim.fn.expand("%:t"))
end, {})

user_cmd("GetFileNameWihoutExt", function()
    print(vim.fn.expand("%:t:r"))
end, {})

user_cmd("GetFileExt", function()
    print(vim.fn.expand("%:e"))
end, {})

vim.api.nvim_create_user_command("ToggleAutocmdDebug", helpers.toggle_autocmd_debug, {})

-- AUTO-COMMANDS
------------------------------------------------------------------------------------------------
autocmd("TermOpen", {
    callback = function()
        vim.schedule(function()
            vim.wo.number = true
            vim.wo.relativenumber = false
        end)
    end,
})

autocmd("TermEnter", {
    callback = function()
        vim.wo.number = true
        vim.wo.relativenumber = true
    end,
})
