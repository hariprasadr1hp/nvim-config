-- lua/plugins/harpoon.lua

local function setup_keymaps()
    local keymap_set = require("config.helpers").keymap_set
    local harpoon_list = require("harpoon"):list()
    local set_usercmd = vim.api.nvim_create_user_command

    keymap_set("n", "<leader>hla", function()
        harpoon_list:add()
    end, "harpoon-add")

    keymap_set("n", "<leader>hld", function()
        harpoon_list:remove()
    end, "harpoon-remove")

    keymap_set("n", "<leader>hlp", function()
        harpoon_list:prev()
    end, "prev-harpoon")

    keymap_set("n", "<leader>hln", function()
        harpoon_list:next()
    end, "next-harpoon")

    keymap_set("n", "<leader>hll", function()
        require("harpoon").ui:toggle_quick_menu(harpoon_list)
    end, "harpoon-list")

    for i = 1, 9 do
        keymap_set("n", "<leader>h" .. i, function()
            harpoon_list:select(i)
        end, "harpoon-" .. i)
    end

    set_usercmd("HarpoonAddToList", function()
        harpoon_list:add()
    end, {})

    set_usercmd("HarpoonClearList", function()
        harpoon_list:clear()
    end, {})

    set_usercmd("HarpoonRemoveFromList", function()
        harpoon_list:remove()
    end, {})

    set_usercmd("HarpoonShowList", function()
        require("harpoon").ui:toggle_quick_menu(harpoon_list)
    end, {})
end

local function setup_harpoon_config()
    require("harpoon"):setup()
    setup_keymaps()
end

return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = setup_harpoon_config,
}
