-- lua/plugins/cloak.lua

local patterns = {
    {
        file_pattern = { ".env*", "dev.vars" },
        cloak_pattern = "=.+",
        replace = nil, -- Keeps the first character by default
    },
}

local opts = {
    enabled = true,
    cloak_character = "*",
    highlight_group = "Comment",
    cloak_length = nil, -- Use a number to hide the actual length of the value.
    try_all_patterns = true,
    cloak_telescope = true,
    cloak_on_leave = false,
    patterns = patterns,
}

return {
    "laytan/cloak.nvim",
    cmd = { "CloakToggle", "CloakPreviewLine" },
    keys = {
        { "<leader>tc", "<cmd>CloakPreviewLine<CR>", desc = "toggle-cloak-line" },
        { "<leader>tC", "<cmd>CloakToggle<CR>", desc = "toggle-cloak-file" },
    },

    opts = opts,
}
