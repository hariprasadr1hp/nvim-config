-- lua/plugins/ai/codecompanion.lua

-- refer: https://codecompanion.olimorris.dev/

-- TODO: add model name besides adapter on chat
-- TODO: add a header on top for codecompanion buffers, describing model-info
-- TODO: UI updates (markdown, bgcolor, fidget-spinner etc.,)
-- TODO: swap keymaps for allow-once and allow-always (g1,g2) (1,2)
-- TODO: Keymap to diff changes done by the language model

-- TODO: linking codecompanion-workspace.json to agent.md, cursor/rules etc.,
-- TODO: vector-code integration
-- TODO: effectively using codecompanion-workspace.json
-- TODO: chat-buffer naming
-- TODO: chat-buffer session-management (lifespan, autocmds etc.,)
-- TODO: AI version control

-- TODO: additional tools
-- TODO: additional variables
-- TODO: variable: directory
-- TODO: variable: TODO-list

local function setup_codecompanion_config()
    local companion = require("codecompanion")
    local companion_adapters = require("codecompanion.adapters")

    local function setup_claude_code_acp_adapter()
        ---@type CodeCompanion.ACPAdapter.ClaudeCode
        local claude_acp_opts = {
            env = {
                CLAUDE_CODE_OAUTH_TOKEN = vim.env.CLAUDE_CODE_OAUTH_TOKEN,
            },

            -- FIX: choose between haiku and sonnet models, with default as haiku
            -- refer how the models are named for claude code
            commands = {
                default = {
                    -- https://github.com/zed-industries/claude-code-acp
                    "claude-code-acp",
                },
            },
        }

        return companion_adapters.extend("claude_code", claude_acp_opts)
    end

    -- FIX: model selection, and default model

    local function setup_codex_acp_adapter()
        ---@type CodeCompanion.ACPAdapter.Codex
        local codex_acp_opts = {
            defaults = {
                ---@type "openai-api-key" | "codex-api-key" | "chatgpt"
                auth_method = "chatgpt",
            },
            commands = {
                default = {
                    -- https://github.com/zed-industries/codex-acp
                    "codex-acp",
                },
            },
        }
        return companion_adapters.extend("codex", codex_acp_opts)
    end

    -- FIX: get gemini acp adapter working, along with model selection, and default model

    local function setup_gemini_acp_adapter()
        ---@type CodeCompanion.ACPAdapter.GeminiCLI
        local gemini_acp_opts = {
            defaults = {
                ---@type "oauth-personal" | "gemini-api-key" | "vertex-ai"
                auth_method = "oauth-personal",
            },
            schema = {
                model = {
                    ---@type "gemini-2.5-flash" | "gemini-2.5-flash-lite" | "gemini-2.5-pro"
                    default = "gemini-2.5-flash",
                },
            },
        }
        return companion_adapters.extend("gemini_cli", gemini_acp_opts)
    end

    local function setup_opencode_acp_adapter()
        ---@type CodeCompanion.ACPAdapter.OpenCode
        local opencode_acp_opts = {
            model = {
                default = vim.env.OLLAMA_DEFAULT_SERVER_MODEL,
            },
        }
        return companion_adapters.extend("opencode", opencode_acp_opts)
    end

    local function setup_ollama_http_adapter()
        ---@type CodeCompanion.HTTPAdapter.Ollama
        local ollama_http_adapter = {
            env = {
                url = vim.env.OLLAMA_SERVER_HOST,
            },
            headers = {
                ["Content-Type"] = "application/json",
                -- ["Authorization"] = string.format("Bearer %s", vim.env.OLLAMA_API_KEY),
            },
            parameters = {
                sync = true,
            },
            schema = {
                model = {
                    default = vim.env.OLLAMA_DEFAULT_SERVER_MODEL,
                },
            },
        }
        return companion_adapters.extend("ollama", ollama_http_adapter)
    end

    local function setup_cursor_acp_adapter()
        local helpers = require("codecompanion.adapters.acp.helpers")

        ---@class CodeCompanion.ACPAdapter.Cursor: CodeCompanion.ACPAdapter
        return {
            name = "cursor",
            formatted_name = "Cursor",
            type = "acp",
            roles = {
                llm = "assistant",
                user = "user",
            },
            opts = {
                vision = false,
            },
            commands = {
                -- TODO: possible to get the content under "reasoning", or is it obscured?
                default = {
                    "cursor-agent-acp",
                },
            },
            defaults = {
                mcpServers = {},
                timeout = 20000, -- 20 seconds
            },
            parameters = {
                protocolVersion = 1,
                clientCapabilities = {
                    fs = { readTextFile = true, writeTextFile = true },
                },
                clientInfo = {
                    name = "CodeCompanion.nvim",
                    version = "1.0.0",
                },
            },
            handlers = {
                ---@param self CodeCompanion.ACPAdapter
                ---@return boolean
                ---@diagnostic disable-next-line: unused-local
                setup = function(self)
                    return true
                end,

                ---@param self CodeCompanion.ACPAdapter
                ---@return boolean
                ---@diagnostic disable-next-line: unused-local
                auth = function(self)
                    -- authentication handled externally via cursor-agent CLI
                    -- via `cursor-agent login`
                    return true
                end,

                ---@param self CodeCompanion.ACPAdapter
                ---@param messages table
                ---@param capabilities table
                ---@return table
                form_messages = function(self, messages, capabilities)
                    return helpers.form_messages(self, messages, capabilities)
                end,

                ---@param self CodeCompanion.ACPAdapter
                ---@param code number
                ---@return nil
                ---@diagnostic disable-next-line: unused-local
                on_exit = function(self, code) end,
            },
        }
    end

    -- FIX: gracefully exit, when the API key is not available
    local function setup_anthropic_http_adapter()
        local api_key = vim.env.ANTHROPIC_API_KEY
        ---@type CodeCompanion.HTTPAdapter.Anthropic
        local anthropic_http_opts = {
            env = {
                api_key = api_key,
            },
        }
        return companion_adapters.extend("anthropic", anthropic_http_opts)
    end

    local function setup_gemini_http_adapter()
        ---@type CodeCompanion.HTTPAdapter.Gemini
        local gemini_http_opts = {
            defaults = {
                ---@type "oauth-personal" | "gemini-api-key" | "vertex-ai"
                auth_method = "oauth-personal",
            },
            schema = {
                model = {
                    ---@type "gemini-2.5-flash" | "gemini-2.5-flash-lite" | "gemini-2.5-pro"
                    default = "gemini-2.5-flash",
                },
            },
        }
        return companion_adapters.extend("gemini", gemini_http_opts)
    end

    local function setup_xai_http_adapter()
        ---@type CodeCompanion.HTTPAdapter.xAI
        local xai_http_opts = {
            env = {
                api_key = vim.env.XAI_API_KEY,
            },
            opts = {
                stream = true,
                vision = false,
            },
            schema = {
                model = {
                    ---@type "grok-4-1-fast-reasoning" | "grok-4-1-fast-non-reasoning"
                    default = "grok-4-1-fast-reasoning",
                },
            },
        }
        return companion_adapters.extend("xai", xai_http_opts)
    end

    local function setup_venice_http_adapter()
        ---@type CodeCompanion.HTTPAdapter.OpenAICompatible
        local venice_http_opts = {
            env = {
                url = "https://api.venice.ai/api",
                chat_url = "/v1/chat/completions",
                api_key = vim.env.VENICE_API_KEY,
            },
            schema = {
                model = {
                    default = "venice-uncensored",
                },
            },
            opts = {
                vision = false,
            },
        }
        return companion_adapters.extend("openai_compatible", venice_http_opts)
    end

    ---@module "codecompanion"
    local companion_opts = {
        adapters = {
            acp = {
                claude_code = setup_claude_code_acp_adapter,
                codex = setup_codex_acp_adapter,
                gemini_cli = setup_gemini_acp_adapter,
                opencode = setup_opencode_acp_adapter,
                cursor = setup_cursor_acp_adapter,

                opts = {
                    show_model_choices = true,
                    show_presets = true,
                },
            },

            http = {
                anthropic = setup_anthropic_http_adapter,
                ollama = setup_ollama_http_adapter,
                gemini = setup_gemini_http_adapter,
                venice = setup_venice_http_adapter,
                xai = setup_xai_http_adapter,
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
            },

            -- roles = {},
            slash_commands = {
                ["image"] = {
                    callback = "interactions.chat.slash_commands.builtin.image",
                    description = "Insert an image",
                    ---@param opts { adapter: CodeCompanion.HTTPAdapter }
                    ---@return boolean
                    enabled = function(opts)
                        return opts.adapter.opts and (opts.adapter.opts.vision == true) or false
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
                        modes = { n = "gcy" },
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
        },

        rules = {
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
        },

        opts = {
            log_level = "DEBUG",
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
            { "<leader>ai", ":CodeCompanionChat Toggle<CR>", mode = { "n", "v" }, desc = "ai-chat-companion" },
            { "<leader>aI", ":CodeCompanionChat<CR>", mode = "n", desc = "ai-chat-companion" },
            -- TODO: choose adapter while executing inline suggestions/corrections
            { "<leader>aI", ":CodeCompanion<CR>", mode = "v", desc = "ai-chat-companion" },
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
