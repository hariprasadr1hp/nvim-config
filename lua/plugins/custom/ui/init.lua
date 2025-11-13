-- lua/plugins/custom/ui/init.lua

M = {}

local defaults_opts = {
    plugins = {
        actions = { enabled = true },
    },
}

local utils = require("plugins.custom.ui.utils")

M.create_floating_window = utils.create_floating_window

local function setup(opts)
    opts = vim.tbl_deep_extend("force", {}, defaults_opts, opts or {})
end

M.setup = setup

return M
