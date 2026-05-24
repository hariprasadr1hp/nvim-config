-- lua/plugins/ai/codecompanion/init.lua

-- refer: https://codecompanion.olimorris.dev/

-- TODO: vector-code integration
-- TODO: chat-buffer session-management (lifespan, autocmds etc.,)
-- TODO: AI version control

local function setup_codecompanion_config()
    local companion = require("codecompanion")
    local companion_dir = vim.fn.stdpath("config") .. "/lua/plugins/ai/codecompanion"

    ---@module "codecompanion"
    local companion_opts = {
        adapters = {
            acp = {
                claude_code = require("plugins.ai.codecompanion.adapters.acp_claude"),
                codex = require("plugins.ai.codecompanion.adapters.acp_codex"),
                gemini_cli = require("plugins.ai.codecompanion.adapters.acp_gemini"),
                opencode = require("plugins.ai.codecompanion.adapters.acp_opencode"),
                cursor = require("plugins.ai.codecompanion.adapters.acp_cursor"),

                opts = {
                    show_model_choices = true,
                    show_defaults = true,
                    show_presets = false,
                },
            },

            http = {
                anthropic = require("plugins.ai.codecompanion.adapters.http_anthropic"),
                ollama = require("plugins.ai.codecompanion.adapters.http_ollama"),
                openai = require("plugins.ai.codecompanion.adapters.http_openai"),
                gemini = require("plugins.ai.codecompanion.adapters.http_gemini"),
                venice = require("plugins.ai.codecompanion.adapters.http_venice"),
                xai = require("plugins.ai.codecompanion.adapters.http_xai"),
                -- TODO: perplexity http adapter
                -- TODO: copilot http adapter

                opts = {
                    show_model_choices = true,
                    show_defaults = true,
                    show_presets = false,
                    -- TODO: setting proxy
                    -- https://codecompanion.olimorris.dev/configuration/adapters-http#setting-a-proxy
                    -- FIX: an option to persist/copy current chat history while switching models/adapters
                },
            },
        },

        extensions = {
            mcphub = {
                callback = "mcphub.extensions.codecompanion",
                opts = {
                    make_slash_commands = true,
                    make_tools = true,
                    make_vars = true,
                },
            },
            history = {
                -- BUG: Message history not passed to ACP adapters on chat restoration
                -- https://github.com/ravitemer/codecompanion-history.nvim/issues/63
                enabled = true,
                opts = {
                    keymap = "gh",
                    auto_save = true,
                    expiration_days = 0,
                    picker = "snacks",
                    chat_filter = function(chat_data)
                        -- local seven_days_ago = os.time() - (7 * 24 * 60 * 60)
                        -- return chat_data.updated_at >= seven_days_ago
                        return chat_data.cwd == vim.fn.getcwd()
                    end,
                    picker_keymaps = {
                        rename = { n = "r", i = "<M-r>" },
                        delete = { n = "d", i = "<M-d>" },
                        duplicate = { n = "<C-y>", i = "<C-y>" },
                    },
                    auto_generate_title = true,
                    title_generation_opts = {
                        adapter = nil,
                        model = nil,
                        refresh_every_n_prompts = 0,
                        max_refreshes = 3,
                        format_title = function(original_title)
                            return original_title
                        end,
                    },
                    continue_last_chat = false,
                    delete_on_clearing_chat = false,
                    dir_to_save = vim.fn.stdpath("data") .. "/codecompanion_history",
                    enable_logging = false,
                    summary = {
                        create_summary_keymap = "gcs",
                        browse_summaries_keymap = "gbs",

                        generation_opts = {
                            adapter = "ollama",
                            model = vim.env.OLLAMA_DEFAULT_SERVER_MODEL,
                            context_size = 90000,
                            include_references = true,
                            include_tool_outputs = true,
                            system_prompt = nil,
                            format_summary = nil,
                        },
                    },
                    memory = {
                        auto_create_memories_on_summary_generation = true,
                        vectorcode_exe = "vectorcode",
                        tool_opts = {
                            default_num = 10,
                        },
                        notify = true,
                        index_on_startup = false,
                    },
                },
            },
            attachments = {
                callback = "codecompanion._extensions.attachments",
                enabled = true,
                opts = {
                    adapters = {},
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
                    opts = {
                        completion_provider = "blink",
                    },
                },

                roles = {
                    llm = function(adapter)
                        local model = adapter.model or "unknown"
                        return string.format(
                            "LLM -- %s (%s)",
                            model["name"] or "unknown",
                            string.upper(adapter.name) or "UNKNOWN"
                        )
                    end,

                    user = "USER",
                },

                tools = {
                    groups = {
                        ["github_pr_workflow"] = {
                            description = "GitHub operations from issue to PR",
                            tools = {
                                -- File operations
                                "neovim__read_multiple_files",
                                -- "neovim__write_file",
                                -- "neovim__edit_file",

                                -- GitHub operations
                                "github__list_issues",
                                "github__get_issue",
                                "github__get_issue_comments",
                                -- "github__create_issue",
                                -- "github__create_pull_request",
                                "github__get_file_contents",
                                -- "github__create_or_update_file",
                                "github__search_code",
                            },
                        },
                    },
                },

                keymaps = {
                    fold_code = false,
                    goto_file_under_cursor = false,
                    copilot_stats = false,
                    -- BUG: Options "?" throws an error
                    -- options = {
                    --     modes = { n = "?" },
                    --     callback = "keymaps.options",
                    --     description = "Options",
                    -- },
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
                    add_code_block = {
                        modes = { n = "gc" },
                        description = "add code block",
                        callback = function()
                            return "```\n\n```"
                        end,
                    },
                    change_model = {
                        modes = { n = "gm" },
                        description = "Change Model",
                        callback = function(chat)
                            require("codecompanion.interactions.chat.keymaps.change_adapter").select_model(chat)
                        end,
                    },
                },

                slash_commands = {
                    ["dummy"] = {
                        description = "dummy",
                        callback = "plugins.ai.codecompanion.slash_commands.dummy",
                        -- callback = function(chat)
                        --     chat:add_buf_message({ content = "this is a dummy message!" })
                        -- end,
                        contains_code = false,
                    },
                },

                variables = {
                    ["xx"] = {
                        description = "redact content",
                        callback = "plugins.ai.codecompanion.variables.xx",
                    },
                    opts = {
                        contains_code = false,
                        -- has_params = false,
                        -- default_params = nil,
                    },
                },

                opts = {
                    log_level = "DEBUG",
                    --TODO: system prompt can be a function
                    system_prompt = require("plugins.ai.codecompanion.prompts.system_prompt.neovim"),
                    ---@diagnostic disable-next-line: unused-local
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
            -- TODO: completion: symbols from the shared buffer (extend buffer variable)
            chat = {
                fold_context = false,
                fold_reasoning = true,
                hide_reasoning = false,
                auto_scroll = true,
                intro_message = "Welcome to CodeCompanion ✨! Press ? for options",
                separator = "────────────────────────",
                -- FIX: how to undo an attachment?
                show_context = true,
                show_header_separator = true,
                show_settings = false, -- since setting true would disable `ga` (adapter change)
                show_token_count = true,
                show_tools_processing = true,
                start_in_insert_mode = false,
                icons = {
                    buffer_sync_all = "󰪴 ",
                    buffer_sync_diff = " ",
                    chat_context = " ",
                    chat_fold = " ",
                    tool_pending = "  ",
                    tool_in_progress = "  ",
                    tool_failure = "  ",
                    tool_success = "  ",
                },
                floating_window = {
                    ---@return number|fun(): number
                    width = function()
                        return vim.o.columns - 5
                    end,
                    ---@return number|fun(): number
                    height = function()
                        return vim.o.lines - 2
                    end,
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
                    buflisted = true,
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
            -- FIX: commented-out content in markdown prompts should be removed
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
        version = "^19.0.0",
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
            "ravitemer/codecompanion-history.nvim",
            "georgeharker/codecompanion-attachments.nvim",
        },
        config = setup_codecompanion_config,
    },
}
