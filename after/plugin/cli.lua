-- after/plugin/cli.lua

if vim.g.vscode then
    return
end

local keymap_set = require("config.helpers").keymap_set
local fzf_lua = require("fzf-lua")
local toggleterm_exec = require("toggleterm").exec

local cli_tool_choices = {
    "gcloud",
    "aws",
    "misc",
}

local function select_cli_tool(on_choice)
    vim.ui.select(cli_tool_choices, {
        prompt = "Choose CLI Tool",
        format_item = function(item)
            return item
        end,
    }, function(choice)
        if choice then
            on_choice(choice)
        end
    end)
end

local actions_gcloud = {
    {
        name = "list permissions by role",
        action = function()
            vim.ui.input({ prompt = "Enter `role`" }, function(role)
                pcall(toggleterm_exec, string.format(" gcloud iam roles describe roles/%s", role))
            end)
        end,
    },

    {
        name = "list projects",
        action = function()
            pcall(toggleterm_exec, " gcloud projects list")
        end,
    },

    {
        name = "list glossaries",
        action = function()
            vim.ui.input({ prompt = "additional arguments" }, function(args)
                pcall(toggleterm_exec, string.format(" gcloud dataplex glossaries list %s", args))
            end)
        end,
    },

    {
        name = "update",
        action = function()
            pcall(toggleterm_exec, " gcloud components update")
        end,
    },
}

local actions_misc = {}

local cli_tool_actions = {
    misc = actions_misc,
    gcloud = actions_gcloud,
}

local function run_cli_tool()
    select_cli_tool(function(cli_tool)
        local actions = cli_tool_actions[cli_tool]
        fzf_lua.fzf_exec(
            vim.tbl_map(function(action)
                return action.name
            end, actions),
            {
                prompt = "Actions> ",
                actions = {
                    ["default"] = function(selected)
                        for _, a in ipairs(actions) do
                            if a.name == selected[1] then
                                a.action()
                                return
                            end
                        end
                    end,
                },
            }
        )
    end)
end

keymap_set("n", "<leader>pr", run_cli_tool, "program-run")
