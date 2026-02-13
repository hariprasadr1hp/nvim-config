-- after/ftplugin/dbui.lua

local keymap_set = require("config.helpers").keymap_set
local ftplugin_helpers = require("core.ftplugin_helpers")

-- Setup reversible filetype-specific settings
ftplugin_helpers.setup_reversible_settings("dbui", {
    win_opts = {
        cursorline = true,
    },
    winhighlight = {
        active = "Normal:DBUIActiveWindowBg",
        inactive = "Normal:DBUIWindowBg",
    },
})

-- Define highlight groups (use `default`, to not override plugin themes)
-- vim.cmd("highlight default DBUIWindowBg guibg=#2a2e36")
-- vim.cmd("highlight default DBUIActiveWindowBg guibg=#3b4252")

-- Buffer-local keymaps
vim.keymap.set("n", "<Tab>", "<Plug>(DBUI_SelectLine)", { buffer = true, silent = true })
keymap_set("n", "<leader>;l", ":DBUILastQueryInfo<cr>", "dbui-last-query-info", { buffer = true })
keymap_set("n", "<leader>xq", ":DBUIHideNotifications<cr>", "dbui-hide-notifications", { buffer = true })
