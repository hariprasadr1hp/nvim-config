-- lua/plugins/custom/project/init.lua

M = {}

local defaults_opts = {
    plugins = {
        actions = { enabled = true },
    },
}

local utils = require("plugins.custom.project.utils")

M.print_env_value = utils.print_env_value
M.copy_env_value = utils.copy_env_value

function M.setup(opts)
    opts = vim.tbl_deep_extend("force", {}, defaults_opts, opts or {})
    vim.api.nvim_create_user_command("ProjectPrintEnv", M.print_env_value, {})
    vim.api.nvim_create_user_command("ProjectCopyEnv", M.copy_env_value, {})
end

return M
