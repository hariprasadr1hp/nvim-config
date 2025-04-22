-- lua/plugins/harpoon.lua

local function setup_keymaps()
    local harpoon_list = require("harpoon"):list()
    local set_map = vim.keymap.set
    local set_usercmd = vim.api.nvim_create_user_command

    set_map("n", "[n", function()
        harpoon_list:prev()
    end, { desc = "prev-harpoon" })

    set_map("n", "]n", function()
        harpoon_list:next()
    end, { desc = "next-harpoon" })

    set_map("n", ",1", function()
        harpoon_list:select(1)
    end, { desc = "harpoon-1" })

    set_map("n", ",2", function()
        harpoon_list:select(2)
    end, { desc = "harpoon-2" })

    set_map("n", ",3", function()
        harpoon_list:select(3)
    end, { desc = "harpoon-3" })

    set_map("n", ",4", function()
        harpoon_list:select(4)
    end, { desc = "harpoon-4" })

    set_map("n", ",5", function()
        harpoon_list:select(5)
    end, { desc = "harpoon-5" })

    set_map("n", "<leader>hla", function()
        harpoon_list:add()
    end, { desc = "harpoon-add" })

    set_map("n", "<leader>hld", function()
        harpoon_list:remove()
    end, { desc = "harpoon-remove" })

    set_map("n", "<leader>hlp", function()
        harpoon_list:prev()
    end, { desc = "prev-harpoon" })

    set_map("n", "<leader>hln", function()
        harpoon_list:next()
    end, { desc = "next-harpoon" })

    set_map("n", "<leader>hll", function()
        require("harpoon").ui:toggle_quick_menu(harpoon_list)
    end, { desc = "harpoon-list" })

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

local setup_harpoon = function()
    MiniDeps.add({
        source = "ThePrimeagen/harpoon",
        checkout = "harpoon2",
        depends = { "nvim-lua/plenary.nvim" },
    })

    require("harpoon"):setup()
    setup_keymaps()
end

MiniDeps.later(setup_harpoon)
