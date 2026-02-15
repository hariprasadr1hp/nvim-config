-- lua/plugins/ai/mcphub/init.lua

local function setup_mcphub()
    local mcphub = require("mcphub")

    local opts = {
        config = vim.fn.expand("~/.config/mcphub/servers.json"),
        port = 37373,
        shutdown_delay = 5 * 60 * 1000,
        use_bundled_binary = false,
        mcp_request_timeout = 60000,

        global_env = function(context)
            local env = {
                "DBUS_SESSION_BUS_ADDRESS",
                PROJECT_ROOT = vim.fn.getcwd(),
            }

            if context.is_workspace_mode then
                env.WORKSPACE_ROOT = context.workspace_root
                env.WORKSPACE_PORT = tostring(context.port)
            end
            env.CONFIG_FILES = table.concat(context.config_files, ":")
            return env
        end,

        workspace = {
            enabled = true,
            look_for = {
                ".mcphub/servers.json",
                ".vscode/mcp.json",
                ".cursor/mcp.json",
            },
            reload_on_dir_changed = true,
            port_range = { min = 40000, max = 41000 },
            get_port = nil,
        },

        ---@return boolean | string | nil
        auto_approve = function(params)
            -- true - Auto-approve the call
            -- false - Show confirmation prompt
            -- string - Deny with error message
            -- nil - Show confirmation prompt (same as false)
            local approve = true
            local prompt_to_approve = true
            if vim.g.codecompanion_auto_tool_mode == true then
                return approve
            end

            if params.server_name == "github" and params.tool_name == "get_issue" then
                return approve
            end

            if params.arguments.repo == "private" then
                return "You can't access my private repo"
            end

            if params.tool_name == "read_file" then
                local path = params.arguments.path or ""
                if path:match("^" .. vim.fn.getcwd()) then
                    return prompt_to_approve
                end
            end

            if params.is_auto_approved_in_server then
                return approve
            end
        end,

        auto_toggle_mcp_servers = true,
        extensions = {},

        native_servers = {},
        builtin_tools = {
            edit_file = {
                parser = {
                    track_issues = true,
                    extract_inline_content = true,
                },
                locator = {
                    fuzzy_threshold = 0.8,
                    enable_fuzzy_matching = true,
                },
                ui = {
                    go_to_origin_on_complete = true,
                    keybindings = {
                        accept = ".",
                        reject = ",",
                        next = "n",
                        prev = "p",
                        accept_all = "ga",
                        reject_all = "gr",
                    },
                },
            },
        },

        ui = {
            window = {
                width = 0.8,
                height = 0.8,
                relative = "editor",
                zindex = 50,
                border = "rounded",
            },
            wo = {
                winhl = "Normal:MCPHubNormal,FloatBorder:MCPHubBorder",
            },
        },

        json_decode = nil,
        on_ready = function(hub) end,
        on_error = function(err) end,

        log = {
            level = vim.log.levels.WARN,
            to_file = false,
            file_path = nil,
            prefix = "MCPHub",
        },
    }

    mcphub.setup(opts)

    mcphub.add_tool("greet", require("plugins.ai.mcphub.tools.greet"))
    mcphub.add_prompt("parrot", require("plugins.ai.mcphub.prompts.parrot"))
    mcphub.add_prompt("git_commit_message", require("plugins.ai.mcphub.prompts.git_commit_message"))
    mcphub.add_prompt("review_code", require("plugins.ai.mcphub.prompts.review_code"))
    mcphub.add_prompt("explain_code", require("plugins.ai.mcphub.prompts.explain_code"))
end

return {
    "ravitemer/mcphub.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    cmd = "MCPHub",
    keys = {
        { "<leader>oM", "<cmd>MCPHub<cr>", desc = "MCPHub" },
    },
    build = "bundled_build.lua",
    config = setup_mcphub,
}
