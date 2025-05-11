-- lua/plugins/custom/buffer/init.lua

M = {}

local defaults_opts = {
    cmd_name = "BufferInfo",
}

M.show_buffer_info = require("plugins.custom.buffer.info").show_buffer_info

function M.setup(opts)
    opts = vim.tbl_extend("force", defaults_opts, opts)
    vim.api.nvim_create_user_command(opts.cmd_name, M.show_buffer_info, {})
end

return M
