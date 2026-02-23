-- lua/plugins/custom/window/init.lua

M = {}

local defaults_opts = {
    plugins = {
        window_resize = { enabled = true },
    },
}

M.enter_window_resize_mode = require("plugins.custom.window.resize").enter_window_resize_mode
M.exit_window_resize_mode = require("plugins.custom.window.resize").exit_window_resize_mode

local function setup(opts)
    opts = vim.tbl_deep_extend("force", {}, defaults_opts, opts or {})
    vim.api.nvim_create_user_command("WindowResizeModeEnter", M.enter_window_resize_mode, {})
    vim.api.nvim_create_user_command("WindowResizeModeExit", M.exit_window_resize_mode, {})
end

M.setup = setup

return M
