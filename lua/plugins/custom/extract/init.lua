-- lua/plugins/custom/extract/init.lua

M = {}

local defaults_opts = {
    plugins = {
        actions = { enabled = true },
        buffer_info = { enabled = true },
    },
}

M.get_matches = require("plugins.custom.extract.ts_extract").get_matches

local function setup(opts)
    opts = vim.tbl_deep_extend("force", {}, defaults_opts, opts or {})
end

M.setup = setup

return M
