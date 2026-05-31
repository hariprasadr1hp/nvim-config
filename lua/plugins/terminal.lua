-- lua/plugins/terminal.lua

local keymap_set = require("config.helpers").keymap_set

local provider_choices = {
    "Codex [OpenAI ChatGPT]",
    "Cursor Agent",
    "Claude Code [Anthropic]",
    "Gemini [Google]",
    "Copilot [Microsoft Github]",
    "Grok [Twitter X]",
    "OpenCode",
    "Claurst",
}

local function select_provider(on_choice)
    vim.ui.select(provider_choices, {
        prompt = "Choose Provider",
        format_item = function(item)
            return item
        end,
    }, function(choice)
        if choice then
            on_choice(choice)
        end
    end)
end

local function start_ai_provider()
    select_provider(function(provider)
        local prg = ""
        if provider == "Codex [OpenAI ChatGPT]" then
            prg = "codex"
        elseif provider == "Cursor Agent" then
            prg = "cursor-agent"
        elseif provider == "Claude Code [Anthropic]" then
            prg = "claude"
        elseif provider == "Gemini [Google]" then
            prg = "gemini"
        elseif provider == "Copilot [Microsoft Github]" then
            prg = "copilot"
        elseif provider == "Grok [Twitter X]" then
            prg = "grok"
        elseif provider == "OpenCode" then
            prg = "opencode"
        elseif provider == "Claurst" then
            prg = "claurst"
        else
            vim.notify("Error: not a valid provider!", vim.log.levels.ERROR)
        end
        pcall(function()
            local cmd = string.format("FloatermNew %s", prg)
            vim.cmd(cmd)
        end)
    end)
end

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

    -- Smart toggle: checks buftype *before* toggling to decide post-action.
    --   non-terminal → terminal : startinsert (land in terminal mode)
    --   terminal → non-terminal : stopinsert  (land in normal mode)
    -- vim.schedule defers the mode change until after toggleterm has finished
    -- switching focus, since the destination window isn't active yet when
    -- toggle() returns.
    local function smart_toggle()
        local is_terminal = vim.bo.buftype == "terminal"
        toggleterm.toggle()
        vim.schedule(function()
            if is_terminal then
                vim.cmd("stopinsert")
            else
                vim.cmd("startinsert")
            end
        end)
    end
    keymap_set("n", "<M-m>", smart_toggle, "toggle-term")
    keymap_set("n", "<C-`>", smart_toggle, "toggle-term")
    keymap_set("t", "<M-m>", smart_toggle, "toggle-term")
    keymap_set("t", "<C-`>", smart_toggle, "toggle-term")

    keymap_set("n", "g4", function()
        vim.ui.input({
            prompt = "enter terminal command",
        }, function(input)
            if input then
                pcall(toggleterm.exec, string.format(" %s", input))
            end
        end)
    end, "term-exec")

    local function make_runner(target)
        return function()
            toggleterm.exec(" make " .. target)
        end
    end

    keymap_set("n", "<leader>dm", make_runner("debug"), "debug:")
    keymap_set("n", "<leader>ma", make_runner("temp"), "temp:")
    keymap_set("n", "<leader>mb", make_runner("build"), "build:")
    keymap_set("n", "<leader>mc", make_runner("clean"), "clean:")
    keymap_set("n", "<leader>md", make_runner("debug"), "debug:")
    keymap_set("n", "<leader>mf", make_runner("format"), "format:")
    keymap_set("n", "<leader>mh", make_runner("help"), "help:")
    keymap_set("n", "<leader>mL", make_runner("lint"), "lint:")
    keymap_set("n", "<leader>mm", make_runner("all"), "make")
    keymap_set("n", "<leader>mr", make_runner("run"), "run:")
    keymap_set("n", "<leader>mt", make_runner("test"), "test:")

    keymap_set("n", "<leader>tt", function()
        toggleterm.send_lines_to_terminal("single_line", false, { args = vim.v.count })
    end, "send-cline-to-term")

    keymap_set("v", "<leader>tt", function()
        toggleterm.send_lines_to_terminal("visual_lines", false, { args = vim.v.count })
    end, "send-vlines-to-term")

    keymap_set("v", "<leader>tT", function()
        toggleterm.send_lines_to_terminal("visual_selection", false, { args = vim.v.count })
    end, "send-vselect-to-term")

    local eval_cmd_by_ft = require("config.helpers").eval_cmd_by_ft

    keymap_set("n", "<leader>ee", function()
        local cmd = eval_cmd_by_ft()
        if cmd ~= nil then
            print("executing...")
            -- toggleterm.exec(cmd)
            -- TODO: input should be replaced to a float-window,
            -- displaying the contents to be executed
            vim.ui.input({
                prompt = "add additional arguments (if any)",
            }, function(input)
                pcall(function()
                    toggleterm.exec(string.format("%s %s", cmd, input))
                end)
            end)
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
            { "<leader>oa", start_ai_provider, desc = "ai-agent" },
            { "<leader>od", "<cmd>FloatermNew lazydocker<cr>", desc = "lazydocker" },
            { "<leader>oh", "<cmd>FloatermNew htop<cr>", desc = "htop" },
            { "<leader>ol", "<cmd>FloatermNew lazygit<cr>", desc = "lazygit" },
            { "<leader>or", "<cmd>FloatermNew ranger<cr>", desc = "ranger" },
            { "<leader>ot", "<cmd>FloatermToggle<cr>", desc = "floaterm" },
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

-- TODO: managing multiple terminal tabs

-- TODO: fzf-search terminals

-- TODO: but <C-`> toggles to the last active terminal
