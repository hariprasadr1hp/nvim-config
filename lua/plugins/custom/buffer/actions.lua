-- lua/plugins/custom/buffer/actions.lua

M = {}

-- local keymap_set = require("config.helpers").keymap_set

-- local df = require("plugins.custom.buffer.dataframes")
local fzf_lua = require("fzf-lua")
local toggleterm_exec = require("toggleterm").exec
local formatters = require("conform").formatters
-- local formatters_by_ft = require("conform").formatters_by_ft
-- local lint = require("lint")

-- local jq_sibling_action = require("plugins.custom.buffer.lang.json").jq_sibling_action

local actions_lua = {
    {
        name = "Format file [lua]",
        action = function()
            vim.cmd("FormatBuffer")
        end,
    },

    {
        name = "what??",
        action = function()
            print("i love lua!!!")
        end,
    },
}

local actions_python = {
    {
        name = "uv run python %",
        action = function()
            pcall(toggleterm_exec, string.format(" uv run python %s", vim.fn.expand("%")))
        end,
    },

    {
        name = "Format using `black` [python]",
        action = function()
            vim.cmd("!black %")
        end,
    },

    {
        name = "Run `pytest` [python]",
        action = function()
            vim.cmd("!pytest %")
        end,
    },
}

local function get_actions_sql()
    local actions = {}

    if vim.env.DBT_PROJECT_DIR == nil then
        return actions
    end

    local get_actions_sql_dbt = function()
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

    actions = vim.tbl_extend("keep", actions, get_actions_sql_dbt())
    return actions
end

local function get_actions_yaml()
    local actions = {}

    if vim.env.DBT_PROJECT_DIR == nil then
        return actions
    end

    local function get_actions_yaml_dbt()
        local dbt = require("dbt")
        return {
            {
                name = "Jump between `model` and `schema` [DBT]",
                action = function()
                    dbt.jump_between_model_and_schema()
                end,
            },
        }
    end

    actions = vim.tbl_extend("keep", actions, get_actions_yaml_dbt())
    return actions
end

local actions_markdown = {
    {
        name = "Preview Markdown",
        action = function()
            -- vim.cmd("MarkdownPreview")
        end,
    },
}

local actions_json = {
    -- {
    --     name = "Run JQ on sibling nodes [JSON]",
    --     action = jq_sibling_action,
    -- },
    --
    -- {
    --     name = "Describe file [JSON]",
    --     action = df.pl_describe_current_json,
    -- },
}

local function actions_http()
    local kulala = require("kulala")

    return {
        {
            name = "Run Block [http]",
            action = kulala.run,
        },

        {
            name = "Run All Blocks [http]",
            action = kulala.run_all,
        },

        {
            name = "Inspect [http]",
            action = kulala.inspect,
        },

        {
            name = "Replay Request [http]",
            action = kulala.replay,
        },

        {
            name = "Copy as CURL [http]",
            action = kulala.copy,
        },

        {
            name = "Paste from CURL [http]",
            action = kulala.from_curl,
        },

        {
            name = "Download GraphQL Schema [http]",
            action = kulala.download_graphql_schema,
        },

        {
            name = "Export Current Buffer [http]",
            action = kulala.export,
        },

        {
            name = "Open Cookies Jar [http]",
            action = kulala.open_cookies_jar,
        },

        {
            name = "Set Env",
            action = kulala.set_selected_env,
        },

        {
            name = "ScratchPad [http]",
            action = kulala.scratchpad,
        },
    }
end

local actions_mermaid = {
    {
        name = "Preview as `.svg` [mermaid]",
        action = function()
            local open_cmd = vim.fn.has("mac") == 1 and "open" or "xdg-open"
            local file = vim.fn.expand("%")
            local out = vim.fn.expand("%:r") .. ".svg"
            vim.cmd(("!mmdc -i %s -o %s && %s %s"):format(file, out, open_cmd, out))
        end,
    },
}

local actions_turtle = {
    {
        name = "Pre-process file [turtle]",
        action = function()
            local file = vim.fn.expand("%")
            vim.cmd(("! riot %s"):format(file))
        end,
    },
}

local actions_sparql = {
    {
        name = "Run ",
        action = function() end,
    },
}

local actions_hurl = {
    {
        name = "Run file [hurl]",
        action = function()
            vim.cmd("HurlVeryVerbose")
        end,
    },

    {
        name = "Manage ENV variables [hurl]",
        action = function()
            vim.cmd("HurlManageVariable")
        end,
    },

    {
        name = "Show last response [hurl]",
        action = function()
            vim.cmd("HurlShowLastResponse")
        end,
    },
}

_G.ft_actions = {
    lua = actions_lua,
    python = actions_python,
    sql = get_actions_sql(),
    yaml = get_actions_yaml(),
    markdown = actions_markdown,
    json = actions_json,
    http = actions_http(),
    mermaid = actions_mermaid,
    turtle = actions_turtle,
    sparql = actions_sparql,
    hurl = actions_hurl,
}

function M.show_actions()
    local ft = vim.bo.filetype
    local actions = ft_actions[ft]

    if not actions then
        vim.notify(
            string.format("No actions defined for filetype `%s`!", ft == ("" or nil) and "UNKNOWN" or ft),
            vim.log.levels.INFO
        )
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
