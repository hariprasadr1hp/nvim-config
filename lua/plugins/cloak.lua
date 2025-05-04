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

local function setup_cloak_config()
    require("cloak").setup(opts)

    local keymap_set = require("config.helpers").keymap_set
    keymap_set("n", "<leader>tc", "<cmd>CloakPreviewLine<CR>", "cloak-line")
    keymap_set("n", "<leader>tC", "<cmd>CloakToggle<CR>", "cloak-buffer")
end

return {
    "laytan/cloak.nvim",
    config = setup_cloak_config,
}
