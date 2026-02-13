-- lua/config/init.lua

require("config.variables")
require("config.helpers")
require("config.settings")

if not vim.g.vscode then
    require("config.functions")
    require("config.user_commands")
    require("config.autocmds")
    require("config.keybindings")

    -- lazy.nvim required
    require("config.bootstrap")
    require("plugins")
end

if vim.g.neovide then
    require("config.neovide")
elseif vim.g.vscode then
    require("config.vscode")
end
