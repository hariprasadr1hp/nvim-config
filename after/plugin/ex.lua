-- after/plugin/ex.lua

if vim.g.vscode then
    return
end

local M = {}

local keymap_set = require("config.helpers").keymap_set

function M.setup_keymaps()
    keymap_set("n", "gq", function()
        vim.ui.input({ prompt = "ex-cmd-str" }, function(str)
            local result = vim.fn.ExCommand(str)
            vim.cmd(result)
        end)
    end, "exec-ex-cmds")
end

function M.setup()
    M.setup_keymaps()
end

M.setup()

return M
