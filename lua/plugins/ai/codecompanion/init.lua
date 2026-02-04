-- lua/plugins/ai/codecompanion/init.lua

-- refer: https://codecompanion.olimorris.dev/

-- TODO: add model name besides adapter on chat
-- TODO: add a header on top for codecompanion buffers, describing model-info
-- TODO: UI updates (markdown, bgcolor, fidget-spinner etc.,)
-- TODO: Keymap to diff changes done by the language model

-- TODO: vector-code integration
-- TODO: effectively using codecompanion-workspace.json
-- TODO: chat-buffer naming
-- TODO: chat-buffer session-management (lifespan, autocmds etc.,)
-- TODO: AI version control

-- TODO: additional tools
-- TODO: additional variables
-- TODO: variable: directory
-- TODO: variable: .cursor/rules
-- TODO: variable: agents.md

local function setup_codecompanion_config()
    local companion = require("codecompanion")
    local companion_dir = vim.fn.stdpath("config") .. "/lua/plugins/ai/codecompanion"

    ---@module "codecompanion"
    local companion_opts = {
        adapters = {
            acp = {
                claude_code = require("plugins.ai.codecompanion.adapters.mcp_claude"),
                codex = require("plugins.ai.codecompanion.adapters.mcp_codex"),
                gemini_cli = require("plugins.ai.codecompanion.adapters.mcp_gemini"),
                opencode = require("plugins.ai.codecompanion.adapters.mcp_opencode"),
                cursor = require("plugins.ai.codecompanion.adapters.mcp_cursor"),

                opts = {
                    show_model_choices = true,
                    show_presets = true,
                },
            },

            http = {
                anthropic = require("plugins.ai.codecompanion.adapters.http_anthropic"),
                ollama = require("plugins.ai.codecompanion.adapters.http_ollama"),
                gemini = require("plugins.ai.codecompanion.adapters.http_gemini"),
                venice = require("plugins.ai.codecompanion.adapters.http_venice"),
                xai = require("plugins.ai.codecompanion.adapters.http_grok"),
                -- TODO: perplexity http adapter
                -- TODO: copilot http adapter

                opts = {
                    show_model_choices = true,
                    show_defaults = true,
                },
            },
        },

        ---@module "codecompanion.interactions"
        interactions = {
            chat = {
                adapter = {
                    ---@type "ollama" | "claude_code" | "cursor" | "codex" | "opencode" | "xai" | "venice" | "gemini_cli" | "anthropic"
                    name = "ollama",
                    model = vim.env.OLLAMA_DEFAULT_SERVER_MODEL,
                },

                keymaps = {
                    next_chat = {
                        modes = { n = "]c" },
                        index = 11,
                        callback = "keymaps.next_chat",
                        description = "Next chat",
                    },
                    previous_chat = {
                        modes = { n = "[c" },
                        index = 12,
                        callback = "keymaps.previous_chat",
                        description = "Previous chat",
                    },
                    fold_code = false,
                    goto_file_under_cursor = false,
                    copilot_stats = false,
                    super_diff = {
                        modes = { n = "gk" },
                        index = 22,
                        callback = "keymaps.super_diff",
                        description = "Show Super Diff",
                    },
                },

                slash_commands = {
                    ["dummy"] = {
                        description = "Insert filetype",
                        callback = "lua.plugins.ai.codecompanion.slash_commands.dummy",
                        -- callback = function(chat)
                        --     chat:add_buf_message({ content = "this is a dummy message!" })
                        -- end,
                        contains_code = false,
                    },
                },

                opts = {
                    log_level = "DEBUG",
                    ---Decorate the user message before it's sent to the LLM
                    ---@param message string
                    ---@param adapter CodeCompanion.Adapter
                    ---@param context table
                    ---@return string
                    prompt_decorator = function(message, adapter, context)
                        return string.format([[<prompt>%s</prompt>]], message)
                    end,
                },
            },

            inline = {
                -- FIX: control changes-diff
                adapter = {
                    ---@type "ollama" | "claude_code" | "cursor" | "codex" | "opencode" | "xai" | "venice" | "gemini_cli" | "anthropic"
                    name = "ollama",
                    model = vim.env.OLLAMA_DEFAULT_SERVER_MODEL,
                },
                keymaps = {
                    accept_change = {
                        modes = { n = "gca" },
                        opts = { nowait = true, noremap = true },
                        index = 1,
                        callback = "keymaps.accept_change",
                        description = "Accept change",
                    },
                    reject_change = {
                        modes = { n = "gcr" },
                        opts = { nowait = true, noremap = true },
                        index = 2,
                        callback = "keymaps.reject_change",
                        description = "Reject change",
                    },
                    always_accept = {
                        modes = { n = "gcA" },
                        opts = { nowait = true },
                        index = 3,
                        callback = "keymaps.always_accept",
                        description = "Accept and enable auto mode",
                    },
                    stop = {
                        modes = { n = "q" },
                        index = 4,
                        callback = "keymaps.stop",
                        description = "Stop request",
                    },
                },
            },

            cmd = {
                adapter = {
                    name = "ollama",
                    model = vim.env.OLLAMA_DEFAULT_SERVER_MODEL,
                },
            },

            background = {
                name = "ollama",
                model = vim.env.OLLAMA_DEFAULT_SERVER_MODEL,
            },

            -- roles = {},
        },

        rules = {
            default = {
                description = "Collection of common files for all projects",
                files = {
                    ".cursor/rules",
                    "AGENT.md",
                    "AGENTS.md",
                    { path = "CLAUDE.md", parser = "claude" },
                    { path = "CLAUDE.local.md", parser = "claude" },
                    { path = "~/.claude/CLAUDE.md", parser = "claude" },
                },
                is_preset = true,
            },

            claude = {
                description = "Memory files for Claude Code users",
                files = {
                    "~/.claude/CLAUDE.md",
                    "CLAUDE.md",
                    "CLAUDE.local.md",
                },
            },

            CodeCompanion = {
                description = "CodeCompanion plugin memory files",
                ---@return boolean
                enabled = function()
                    -- Don't show this to users who aren't working on CodeCompanion itself
                    return vim.fn.getcwd():find("codecompanion", 1, true) ~= nil
                end,
                files = {}, -- removed for brevity
            },

            opts = {
                chat = {
                    enabled = true,
                    condition = function(chat)
                        return chat.adapter.type ~= "acp"
                    end,
                },
            },
        },

        display = {
            chat = {
                auto_scroll = true,
                floating_window = {
                    width = vim.o.columns - 5,
                    height = vim.o.lines - 2,
                    row = "center",
                    col = "center",
                    relative = "editor",
                    opts = {
                        wrap = false,
                        number = false,
                        relativenumber = false,
                    },
                },
                window = {
                    -- layout = "float",
                    layout = "buffer",
                    position = "right",
                    sticky = false,
                    relative = "editor",
                    height = 0.9,
                    width = 0.4,
                    opts = {
                        breakindent = true,
                        cursorcolumn = false,
                        cursorline = false,
                        foldcolumn = "0",
                        linebreak = true,
                        list = false,
                        numberwidth = 1,
                        signcolumn = "no",
                        spell = false,
                        wrap = true,
                    },
                },
            },
            inline = {
                layout = "buffer",
            },
        },

        prompt_library = {
            -- FIX: comment-out content in markdown prompts
            markdown = {
                dirs = {
                    companion_dir .. "/prompts",
                    vim.fn.getcwd() .. "/.prompts",
                },
            },
        },

        opts = {
            log_level = "DEBUG",
            language = "English",
            send_code = true,
        },
    }

    companion.setup(companion_opts)
end

return {
    {
        "olimorris/codecompanion.nvim",
        version = "18.3.0",
        cmd = {
            "CodeCompanion",
            "CodeCompanionChat",
            "CodeCompanionActions",
        },
        keys = {
            { "<leader>ai", ":CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "ai-chat-companion" },
            { "<leader>aI", ":CodeCompanionChat<cr>", mode = "n", desc = "ai-chat-companion" },
            -- TODO: choose adapter while executing inline suggestions/corrections
            { "<leader>app", ":CodeCompanionActions refresh<cr>", mode = "n", desc = "prompts-list" },
            {
                "<leader>chl",
                ":! tail -n 500 ~/.local/state/nvim/codecompanion.log<cr>",
                mode = "n",
                desc = "chat-logs",
            },

            { "<leader>aI", ":CodeCompanion<cr>", mode = "v", desc = "ai-chat-companion" },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "ravitemer/mcphub.nvim",
            "j-hui/fidget.nvim",
        },
        config = setup_codecompanion_config,
    },
}
