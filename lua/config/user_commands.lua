-- lua/config/user_commands.lua

local helpers = require("config.helpers")
local textx = require("core.textx")

local user_cmd = vim.api.nvim_create_user_command

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

user_cmd("HexColorToggle", function()
    local flag = vim.lsp.document_color.is_enabled()
    vim.lsp.document_color.enable(not flag, nil, { style = "virtual" })
    vim.cmd("edit!")
end, {
    desc = "toggle-hex-color-highlight",
})

user_cmd("TrustNvimLua", function()
    vim.secure.trust({ action = "allow", path = vim.fn.getcwd() .. "/.nvim.lua" })
end, {
    desc = "trust-local-nvim-lua-config",
})

-- Sort lines by character count (line length).
-- Usage:
--   :SortWC            -> whole buffer, shortest -> longest
--   :SortWC!           -> whole buffer, longest  -> shortest
--   :'<,'>SortWC       -> visual/range, shortest -> longest
--   :'<,'>SortWC!      -> visual/range, longest  -> shortest
user_cmd("SortWC", textx.sort_wc, {
    range = true,
    bang = true,
    desc = "Sort lines by character count (length)",
})

user_cmd("ToggleAutocmdDebug", helpers.toggle_autocmd_debug, {})
