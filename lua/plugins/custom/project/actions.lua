-- lua/plugins/custom/project/actions.lua

local tblx = require("core.tablex")
local fzf_lua = require("fzf-lua")

local M = {}

local actions_cube = {}
local function get_actions_dbt()
    local dbt = require("dbt")
    return {
        {
            name = "Jump to `compiled` file [DBT]",
            action = dbt.jump_to_compiled,
        },

        {
            name = "Jump to `run` file [DBT]",
            action = dbt.jump_to_run,
        },

        {
            name = "Jump to `model` file [DBT]",
            action = dbt.jump_to_model,
        },

        {
            name = "Select upstream `models` [DBT]",
            action = dbt.select_upstream_models,
        },

        {
            name = "Select downstream `models` [DBT]",
            action = dbt.select_downstream_models,
        },

        {
            name = "Diff: `model` vs `compiled` [DBT]",
            action = dbt.diff_model_vs_compiled,
        },

        {
            name = "Jump between `model` and `schema` [DBT]",
            action = dbt.jump_between_model_and_schema,
        },

        {
            name = "List all models [DBT]",
            action = dbt.list_all_dbt_models,
        },

        {
            name = "List only enabled models [DBT]",
            action = dbt.list_only_enabled_models,
        },

        {
            name = "List all compiled sql files [DBT]",
            action = dbt.list_compiled_sql_files,
        },

        {
            name = "List all target run sql files [DBT]",
            action = dbt.list_target_run_sql_files,
        },
    }
end
local actions_dagster = {}
local actions_terraform = {}

_G.resource_actions = {
    cube = actions_cube,
    dbt = get_actions_dbt(),
    dagster = actions_dagster,
    terraform = actions_terraform,
}

local function check_cube()
    return false
end

local function check_dbt()
    if vim.env.DBT_PROJECT_DIR then
        -- FIX: still need to check if the path exists
        return true
    end
    return false
end

local function check_dagster()
    return false
end

local function check_terraform()
    return false
end

---@return string[]
local function get_project_resources()
    -- TODO: identify project resources, based on project root, env-vars etc

    local checks = {
        cube = check_cube,
        dbt = check_dbt,
        dagster = check_dagster,
        terraform = check_terraform,
    }

    return tblx.true_keys(checks)
end

function M.show_actions()
    local resources = get_project_resources()
    local actions = {}

    for _, resource in ipairs(resources) do
        table.insert(actions, resource_actions[resource])
    end

    if not actions then
        vim.notify(string.format("No project-level actions available"), vim.log.levels.INFO)
        return
    end

    -- TODO: minimize the selection-window size
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
end

if ... == nil then
    M.show_actions()
end

return M
