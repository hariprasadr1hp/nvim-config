-- lua/plugins/custom/buffer/init.lua

M = {}

local defaults_opts = {
    plugins = {
        actions = { enabled = true },
        buffer_info = { enabled = true },
    },
}

M.show_actions = require("plugins.custom.buffer.actions").show_actions
M.show_buffer_info = require("plugins.custom.buffer.info").show_buffer_info

local function setup(opts)
    opts = vim.tbl_deep_extend("force", {}, defaults_opts, opts or {})
    vim.api.nvim_create_user_command("BufferActions", M.show_actions, {})
    vim.api.nvim_create_user_command("BufferInfo", M.show_buffer_info, {})
end

M.setup = setup

return M
