-- lua/commands.lua

vim.api.nvim_create_user_command("SaveWithNoFormat", function()
    vim.cmd("noautocmd w")
end, { desc = "save the file without applying any formatting options" })

vim.api.nvim_create_user_command("LoadEnvFile", function()
    require("config.helpers").load_env_file()
end, { desc = "load the environmental variables from a file (`.env` by default)" })

vim.api.nvim_create_user_command("Runme", function()
    vim.cmd("! " .. require("config.helpers").eval_cmd_by_ft())
end, { desc = "evalute the buffer code (if applicable)" })

vim.api.nvim_create_user_command("MakeAsMakePrg", function()
    vim.o.makeprg = "make"
end, { desc = "defaults to `make` as the `makeprg`" })

vim.api.nvim_create_user_command("PytestAsMakePrg", function()
    vim.o.makeprg = "pytest"
end, { desc = "sets `pytest` as the `makeprg`" })

vim.api.nvim_create_user_command("GetFilePath", function()
    print(vim.fn.expand("%:p"))
end, {})

vim.api.nvim_create_user_command("GetFileName", function()
    print(vim.fn.expand("%:t"))
end, {})

vim.api.nvim_create_user_command("GetFileNameWihoutExt", function()
    print(vim.fn.expand("%:t:r"))
end, {})

vim.api.nvim_create_user_command("GetFileExt", function()
    print(vim.fn.expand("%:e"))
end, {})
