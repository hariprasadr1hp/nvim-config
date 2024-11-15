-- lua/plugins/surround.lua

local M = {}

M = {
    "kylechui/nvim-surround",
    event = { "BufReadPre", "BufNewFile" },
    version = "*",
    config = true,
}

return M
