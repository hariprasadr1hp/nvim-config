-- lua/plugins/rss.lua

local function get_gcp_release_note_feeds()
    local resources = {
        "bigquery",
        "dataplex",
        "lookerstudio",
        "dataform",
        "sql",
    }

    local uri_template = "https://docs.cloud.google.com/%s/docs/release-notes"

    return {
        release_notes = vim.tbl_map(function(resource)
            return {
                string.format(uri_template, resource),
                name = string.format("%s release notes", resource),
            }
        end, resources),
    }
end

local function get_feeds()
    local feeds = {}
    feeds = vim.tbl_extend("force", {}, feeds, get_gcp_release_note_feeds())

    return feeds
end

local function show_in_w3m()
    if not vim.fn.executable("w3m") then
        vim.notify("w3m not installed")
        return
    end
    local link = require("feed").get_entry().link
    local w3m = require("feed.ui.window").new({
        relative = "editor",
        col = math.floor(vim.o.columns * 0.1),
        row = math.floor(vim.o.lines * 0.1),
        width = math.floor(vim.o.columns * 0.8),
        height = math.floor(vim.o.lines * 0.8),
        border = "rounded",
        style = "minimal",
        title = "Feed w3m",
        zindex = 10,
    })
    vim.keymap.set({ "n", "t" }, "q", "<cmd>q<cr>", { silent = true, buffer = w3m.buf })
    vim.fn.jobstart({ "w3m", link }, { term = true })
    vim.cmd("startinsert")
end

local function play_podcast()
    local link = require("feed").get_entry().link
    if link:find("mp3") then
        vim.ui.open(link)
    -- any other player like:
    -- vim.system({ "vlc.exe", link })
    else
        vim.notify("not a podcast episode")
    end
end

local function get_icon(name)
    local icons = {
        news = "📰",
        tech = "💻",
        movies = "🎬",
        games = "🎮",
        music = "🎵",
        podcast = "🎧",
        books = "📚",
        unread = "🆕",
        read = "✅",
        junk = "🚮",
        star = "⭐",
    }

    if icons[name] then
        return icons[name]
    end
    local has_mini, mini_icons = pcall(require, "mini.icons")
    if has_mini then
        local icon = mini_icons.get("filetype", name)
        if icon then
            return icon .. " "
        end
    end
    return name
end

local function setup_feed_config()
    local feed = require("feed")

    local opts = {
        feeds = get_feeds(),
        ui = {
            order = { "date", "title", "tags" },
            -- tags = {
            --     color = "String",
            --     format = function(id, db)
            --         local tags = vim.tbl_map(get_icon, db:get_tags(id))
            --         table.sort(tags)
            --         return "[" .. table.concat(tags, ", ") .. "]"
            --     end,
            -- },
            -- reading_time = {
            --     color = "Comment",
            --     format = function(id, db)
            --         local cpm = 1000 -- set to whatever you like
            --         local content = db:get(id):gsub("%s+", " ") -- reads the entry content
            --         local chars = vim.fn.strchars(content)
            --         local time = math.ceil(chars / cpm)
            --         return string.format("(%s min)", time)
            --     end,
            -- },
        },

        keys = {
            index = {
                { "p", play_podcast },
                { "w", show_in_w3m },
            },
        },
    }

    feed.setup(opts)
end

return {
    "neo451/feed.nvim",
    dependencies = {
        { "echasnovski/mini.icons", opts = {} },
        { "folke/snacks.nvim" },
    },
    cmd = "Feed",
    keys = {
        { "<leader>os", "<cmd>Feed<cr>", desc = "rss" },
    },
    config = setup_feed_config,
}
