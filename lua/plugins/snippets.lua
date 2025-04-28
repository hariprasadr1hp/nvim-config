-- lua/plugins/snippets.lua

local function setup_mini_snippets()
    local gen_loader = require("mini.snippets").gen_loader
    local opts = {
        snippets = {
            gen_loader.from_file(vim.fn.stdpath("config") .. "/snippets/global.json"),
            gen_loader.from_lang(),
        },
        mappings = {
            expand = "",
            jump_next = "<C-l>",
            jump_prev = "<C-h>",
            stop = "<C-c>",
        },
    }
    require("mini.snippets").setup(opts)
end

return {
    {
        "echasnovski/mini.snippets",
        version = false,
        config = setup_mini_snippets,
    },
}
