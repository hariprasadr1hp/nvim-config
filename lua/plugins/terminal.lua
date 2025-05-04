-- lua/plugins/terminal.lua

local keymap_set = require("config.helpers").keymap_set

local function setup_floaterm_config()
    vim.g.floaterm_gitcommit = "floaterm"
    vim.g.floaterm_autoinsert = 1
    vim.g.floaterm_width = 0.99
    vim.g.floaterm_height = 0.99
    vim.g.floaterm_wintitle = 0
    vim.g.floaterm_autoclose = 1
    vim.g.floaterm_opener = "edit"
    vim.g.floaterm_keymap_toggle = "<leader>ot"
end

local function setup_toggleterm_config()
    local toggleterm = require("toggleterm")

    keymap_set("n", "<M-m>", toggleterm.toggle, "toggle-term")
    keymap_set("n", "<C-`>", toggleterm.toggle, "toggle-term")

    keymap_set("t", "<M-m>", toggleterm.toggle, "toggle-term")
    keymap_set("t", "<C-`>", toggleterm.toggle, "toggle-term")

    -- keymap_set("n", "<leader>tt", ":ToggleTermSendCurrentLine<CR>", "send-current-line-terminal")
    -- keymap_set("x", "<leader>tt", ":ToggleTermSendVisualSelection<CR>", "send-vi-select-terminal")

    local function make_runner(target)
        return function()
            toggleterm.exec(" make " .. target)
        end
    end

    keymap_set("n", "<leader>dm", make_runner("debug"), "make-debug")
    keymap_set("n", "<leader>ma", make_runner("temp"), "make-temp")
    keymap_set("n", "<leader>mc", make_runner("clean"), "make-clean")
    keymap_set("n", "<leader>md", make_runner("debug"), "make-debug")
    keymap_set("n", "<leader>mf", make_runner("format"), "make-format")
    keymap_set("n", "<leader>mm", make_runner("all"), "make-all")
    keymap_set("n", "<leader>mt", make_runner("test"), "make-test")

    keymap_set("n", "<leader>tt", function()
        toggleterm.send_lines_to_terminal("single_line", false, { args = vim.v.count })
    end, "send-cline-to-term")

    keymap_set("v", "<leader>tt", function()
        toggleterm.send_lines_to_terminal("visual_lines", false, { args = vim.v.count })
    end, "send-vlines-to-term")

    keymap_set("v", "<leader>tT", function()
        toggleterm.send_lines_to_terminal("visual_selection", false, { args = vim.v.count })
    end, "send-vlines-to-term")

    local eval_cmd_by_ft = require("config.helpers").eval_cmd_by_ft

    keymap_set("n", "<leader>ee", function()
        local cmd = eval_cmd_by_ft()
        if cmd ~= nil then
            print("executing...")
            toggleterm.exec(cmd)
        else
            print("Not sure how to execute filetype: " .. vim.bo.filetype)
        end
    end, "evaluate")
end

return {
    {
        "voldikss/vim-floaterm",
        cmd = { "FloatermToggle", "FloatermNew" },
        keys = {
            { "<leader>od", "<cmd>FloatermNew lazydocker<CR>", desc = "lazydocker" },
            { "<leader>oh", "<cmd>FloatermNew htop<CR>", desc = "htop" },
            { "<leader>ol", "<cmd>FloatermNew lazygit<CR>", desc = "lazygit" },
            { "<leader>or", "<cmd>FloatermNew ranger<CR>", desc = "ranger" },
            { "<leader>ot", "<cmd>FloatermToggle<CR>", desc = "floaterm" },
        },
        config = setup_floaterm_config,
    },
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        opts = {
            direction = "horizontal",
            shade_terminals = true,
            start_in_insert = true,
            persist_size = true,
        },
        config = setup_toggleterm_config,
    },
}
