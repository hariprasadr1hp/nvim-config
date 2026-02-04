-- lua/plugins/notify.lua

local keymap_set = require("config.helpers").keymap_set

local opts = {
    content = {
        format = nil,
        sort = nil,
    },

    lsp_progress = {
        enable = true,
        level = "INFO",
        duration_last = 1000,
    },

    window = {
        config = {},
        max_width_share = 0.382,
        winblend = 25,
    },
}

local function print_notifications()
    local messages = require("mini.notify").get_all()
    for id, val in ipairs(messages) do
        print(
            string.format(
                "%s | %s | %s | %s | %s",
                os.date("%Y-%m-%dT%H:%M:%S", val.ts_add),
                val.level,
                id,
                val.data.source,
                val.msg
            )
        )
    end
end

local function setup_notify_config()
    local notify = require("mini.notify")
    notify.setup(opts)
    keymap_set("n", "<leader>oN", notify.show_history, "notify-vim")
    keymap_set("n", "<leader>vn", print_notifications, "notify-logs")
end

return {
    {
        "echasnovski/mini.notify",
        version = false,
        opts = {},
        config = setup_notify_config,
    },
}
