-- lua/plugins/custom/buffer/actions.lua

M = {}

-- local keymap_set = require("config.helpers").keymap_set

local fzf_lua = require("fzf-lua")
-- local conform = require("conform")
-- local lint = require("lint")

local actions_lua = {
    {
        name = "format lua",
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
        name = "format: using `black`",
        action = function()
            vim.cmd("!black %")
        end,
    },

    {
        name = "tests: run `pytest`",
        action = function()
            vim.cmd("!pytest %")
        end,
    },
}

local function get_actions_sql()
    local dbt = require("dbt")

    return {
        {
            name = "dbt: jump: to `compiled` file",
            action = function()
                dbt.jump_to_compiled()
            end,
        },

        {
            name = "dbt: jump: to `run` file",
            action = function()
                dbt.jump_to_run()
            end,
        },

        {
            name = "dbt: jump: to `model` file",
            action = function()
                dbt.jump_to_model()
            end,
        },

        {
            name = "dbt: select: upstream `models`",
            action = function()
                dbt.select_upstream_models()
            end,
        },

        {
            name = "dbt: select: downstream `models`",
            action = function()
                dbt.select_downstream_models()
            end,
        },

        {
            name = "dbt: diff: `model` vs `compiled`",
            action = function()
                dbt.diff_model_vs_compiled()
            end,
        },

        {
            name = "dbt: jump: between `model` and `schema`",
            action = function()
                dbt.jump_between_model_and_schema()
            end,
        },
    }
end

local function get_actions_yaml()
    local dbt = require("dbt")

    return {
        {
            name = "dbt: jump: between `model` and `schema`",
            action = function()
                dbt.jump_between_model_and_schema()
            end,
        },
    }
end

local actions_markdown = {
    {
        name = "preview markdown",
        action = function()
            vim.cmd("MarkdownPreview")
        end,
    },
}

local actions_mermaid = {
    {
        name = "preview as `.svg`",
        action = function()
            local open_cmd = vim.fn.has("mac") == 1 and "open" or "xdg-open"
            local file = vim.fn.expand("%")
            local out = vim.fn.expand("%:r") .. ".svg"
            vim.cmd(("!mmdc -i %s -o %s && %s %s"):format(file, out, open_cmd, out))
        end,
    },
}

local actions_hurl = {
    {
        name = "run `hurl` file",
        action = function()
            vim.cmd("HurlRunner")
        end,
    },
}

local filetype_actions = {
    lua = actions_lua,
    python = actions_python,
    sql = get_actions_sql(),
    yaml = get_actions_yaml(),
    markdown = actions_markdown,
    mermaid = actions_mermaid,
    hurl = actions_hurl,
}

function M.show_actions()
    local ft = vim.bo.filetype
    local actions = filetype_actions[ft]

    if not actions then
        vim.notify(string.format("No actions defined for filetype `%s`!", ft), vim.log.levels.INFO)
        return
    end

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
