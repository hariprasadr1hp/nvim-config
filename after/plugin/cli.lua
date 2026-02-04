-- after/plugin/cli.lua

if vim.g.vscode then
    return
end

--- Handle CLI Commands
---@class CLIModule
local M = {}

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

local function trim(s)
    return (s:gsub("%s+$", ""))
end

local function gcloud_cfg_get(expr)
    local obj = vim.system({ "gcloud", "config", "list", "--format=get(" .. expr .. ")" }, { text = true }):wait()

    if obj.code ~= 0 then
        return "" -- or return nil, obj.stderr if you prefer
    end
    -- return trim(obj.stdout or "")
    return obj.stdout or ""
end

local actions_gcloud = {
    -- {
    --     name = "list roles by user and project",
    --     action = function()
    --         local cmd =
    --             [[gcloud projects get-iam-policy --project=%s --flatten="bindings[].members" --filter="bindings.members:user:%s" --format="value(bindings.role)"]]
    --
    --         local default_project_id = gcloud_cfg_get("core.project")
    --         local default_user_id = gcloud_cfg_get("core.account")
    --
    --         vim.ui.input({
    --             prompt = "Enter `project-id`",
    --             default = default_project_id,
    --         }, function(project_id)
    --             vim.ui.input({
    --                 prompt = "Enter `user_id`",
    --                 default = default_user_id,
    --             }, function(user_id)
    --                 vim.print(cmd:format(project_id, user_id))
    --                 -- pcall(toggleterm_exec, cmd:format(project_id, user_id))
    --             end)
    --         end)
    --     end,
    -- },

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

function M.run_cli_tool()
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

function M.setup_keymaps()
    keymap_set("n", "<leader>pr", M.run_cli_tool, "program-run")
end

function M.setup()
    M.setup_keymaps()
end

M.setup()

return M
