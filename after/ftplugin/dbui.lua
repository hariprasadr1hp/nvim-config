-- after/ftplugin/dbui.lua

vim.opt.cursorline = true

vim.keymap.set("n", "<Tab>", "<Plug>(DBUI_SelectLine)", { buffer = true, silent = true })

-- Set initial window highlight
vim.wo.winhighlight = "Normal:DBUIWindowBg"

-- Set up dynamic highlight for focus
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
    buffer = 0,
    callback = function()
        vim.wo.winhighlight = "Normal:DBUIActiveWindowBg"
    end,
})

vim.api.nvim_create_autocmd("WinLeave", {
    buffer = 0,
    callback = function()
        vim.wo.winhighlight = "Normal:DBUIWindowBg"
    end,
})

-- Define highlight groups (use `default` so you don't override user themes)
vim.cmd("highlight default DBUIWindowBg guibg=#2a2e36")
vim.cmd("highlight default DBUIActiveWindowBg guibg=#3b4252")
