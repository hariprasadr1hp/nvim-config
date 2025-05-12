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
        name = "format with black",
        action = function()
            vim.cmd("!black %")
        end,
    },

    {
        name = "run pytest",
        action = function()
            vim.cmd("!pytest %")
        end,
    },
}

local actions_markdown = {
    {
        name = "preview markdown",
        action = function()
            vim.cmd("MarkdownPreview")
        end,
    },
}

local filetype_actions = {
    lua = actions_lua,
    python = actions_python,
    markdown = actions_markdown,
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
