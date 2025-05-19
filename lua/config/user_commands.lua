-- lua/config/user_commands.lua

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

user_cmd("DoesItComeInBlack", function()
    vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
end, { desc = "sets the background color to black" })

vim.api.nvim_create_user_command("WriteVisualSelectionAsTempFile", function()
    HP.SaveVisualSelection()
end, { range = true, desc = "write the visual selection to `~/.temp/zz_*`" })

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
