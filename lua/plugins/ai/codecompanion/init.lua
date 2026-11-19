-- lua/plugins/ai/codecompanion/init.lua

-- refer: https://codecompanion.olimorris.dev/

-- TODO: vector-code integration

-- Chat header (LLM role) ------------------------------------------------------

-- adapter -> resolved header; adapters are deep-copied per chat, so this is
-- effectively one entry per chat. Weak keys let closed chats be collected.
local role_cache = setmetatable({}, { __mode = "k" })

---Display name for the option's current value (handles grouped options)
---@param opt table ACP SessionConfigOption
---@return string
local function current_value_name(opt)
    for _, item in ipairs(opt.options or {}) do
        for _, val in ipairs(item.group and item.options or { item }) do
            if val.value == opt.currentValue then
                return val.name or val.value
            end
        end
    end
    return opt.currentValue
end

---Find the live ACP connection of the chat that owns this adapter
---@param adapter CodeCompanion.ACPAdapter
---@return table|nil
local function acp_connection_for(adapter)
    local ok, Chat = pcall(require, "codecompanion.interactions.chat")
    if not ok then
        return nil
    end
    for _, entry in ipairs(Chat.buf_get_chat()) do
        if entry.chat and entry.chat.adapter == adapter then
            return entry.chat.acp_connection
        end
    end
end

---Header for LLM messages, resolved once per chat (cached after the model is known)
---@param adapter CodeCompanion.HTTPAdapter|CodeCompanion.ACPAdapter
---@return string
local function llm_role(adapter)
    local cached = role_cache[adapter]
    if cached then
        return cached
    end

    local model
    if adapter.type == "acp" then
        -- ACP agents report their live model/options on the connection,
        -- falling back to `adapter.defaults` until it is established
        local defaults = vim.tbl_get(adapter, "defaults", "session_config_options") or {}
        model = defaults.model

        local conn = acp_connection_for(adapter)
        for _, opt in ipairs(conn and conn:get_config_options() or {}) do
            if opt.type == "select" and opt.currentValue then
                if opt.category == "model" or opt.id == "model" then
                    model = current_value_name(opt)
                end
            end
        end
    else
        model = vim.tbl_get(adapter, "model", "name")
    end

    local role = string.format("LLM -- %s (%s)", model or "model??", (adapter.name or "adapter??"):upper())

    -- Only freeze once resolved; ACP connections may not be ready on first render
    if model then
        role_cache[adapter] = role
    end
    return role
end

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
                pi = require("plugins.ai.codecompanion.adapters.acp_pi"),

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
                    sync_all = "󰪴 ",
                    sync_diff = " ",
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
                    -- `row`/`col` must be numbers; omit them to auto-center
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

            diff = {
                enabled = true,
                threshold_for_chat = 0, -- Set to 0 to always use the floating window
                -- word_highlights = {
                --     additions = true,
                --     deletions = true,
                -- },
            },

            inline = {
                layout = "buffer",
            },
        },

        extensions = {
            mcphub = {
                callback = "mcphub.extensions.codecompanion",
                opts = {
                    make_vars = true,
                    make_slash_commands = true,
                    make_tools = true,
                    show_result_in_chat = true,
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
                        adapter = "ollama",
                        model = vim.env.OLLAMA_MINI_MODEL,
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

        ---@module "codecompanion.integrations"
        integrations = {
            herdr = {
                enabled = false,
            },
        },

        ---@module "codecompanion.interactions"
        interactions = {
            background = {
                -- name = "ollama",
                -- model = vim.env.OLLAMA_DEFAULT_SERVER_MODEL,
                adapter = {
                    name = "ollama",
                    model = vim.env.OLLAMA_MINI_MODEL,
                },
                chat = {
                    callbacks = {
                        ["on_ready"] = {
                            actions = {
                                path = "interactions.background.builtin.chat_make_title",
                                adapter = { name = "ollama", model = vim.env.OLLAMA_MINI_MODEL },
                            },
                        },
                    },
                    opts = {
                        enabled = true,
                    },
                },
                gates = {
                    judge = {
                        adapter = {
                            name = "ollama",
                            model = vim.env.OLLAMA_MINI_MODEL,
                        },
                    },
                },
            },

            chat = {
                adapter = {
                    ---@type "ollama" | "claude_code" | "cursor" | "codex" | "opencode" | "xai" | "venice" | "gemini_cli" | "anthropic" | "pi"
                    name = "pi",
                    model = "ollama_razorback/" .. vim.env.OLLAMA_DEFAULT_SERVER_MODEL,
                    opts = {
                        completion_provider = "blink",
                    },
                },

                roles = {
                    ---@type string|fun(adapter: CodeCompanion.HTTPAdapter|CodeCompanion.ACPAdapter): string
                    llm = llm_role,

                    user = "USER",
                },

                tools = {
                    opts = {
                        ---@type "ask" | "auto" | "yolo"
                        approval_mode = "ask",
                        -- TODO: check if "ask" is applicable only for `claude`
                        -- doesn't work for `pi`
                    },

                    ["edit_file"] = {
                        opts = {
                            require_approval_before = {
                                buffer = false,
                                file = true,
                            },
                        },
                    },

                    ["run_command"] = {
                        opts = {
                            -- `protect = true` bypasses the auto-mode branch entirely,
                            -- which would leave `judge` and `safe_commands` dead
                            protect = false,
                            -- auto mode: commands not in `safe_commands` go to the
                            -- background judge (`interactions.background.gates.judge`)
                            judge = true,
                            -- approvals are cached per command string, not per tool
                            require_cmd_approval = true,
                            -- prefix-matched; anything containing `; & | < > $( `` is never safe.
                            -- Also used for shell commands from ACP agents in auto mode
                            safe_commands = {
                                "git status",
                                "git diff",
                                "ls",
                                "pwd",
                            },
                        },
                    },

                    ["web_search"] = {
                        opts = {
                            adapter = "duckduckgo",
                        },
                    },

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

                    options = {
                        modes = { n = "?" },
                        callback = "keymaps.options",
                        description = "Options",
                    },
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
                    -- `change_adapter.select_model` is a local (non-exported) function upstream,
                    -- so drive the public `codecompanion.adapters.ui` API directly
                    change_model = {
                        modes = { n = "gm" },
                        description = "Change Model",
                        ---@param chat CodeCompanion.Chat
                        callback = function(chat)
                            local is_acp = chat.adapter.type == "acp"
                            if is_acp and not chat.acp_connection then
                                return vim.notify("ACP connection not ready yet", vim.log.levels.WARN)
                            end
                            require("codecompanion.adapters.ui").select_model({
                                adapter = chat.adapter,
                                acp_models = is_acp and chat.acp_connection:get_models() or nil,
                                on_choice = function(model_id)
                                    if model_id then
                                        chat:change_model({ model = model_id })
                                    else
                                        vim.notify("No alternative models available", vim.log.levels.INFO)
                                    end
                                end,
                            })
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

            code_review = {
                opts = {
                    auto_accept = {
                        "**/*.lock",
                        "**/package-lock.json",
                        "doc/**/*.txt",
                    },
                },
            },

            inline = {
                adapter = {
                    ---@type "ollama" | "claude_code" | "cursor" | "codex" | "opencode" | "xai" | "venice" | "gemini_cli" | "anthropic"
                    name = "ollama",
                    model = vim.env.OLLAMA_DEFAULT_SERVER_MODEL,
                },

                opts = {
                    max_context_tokens = 10000,
                },
            },

            cmd = {
                adapter = {
                    name = "ollama",
                    model = vim.env.OLLAMA_DEFAULT_SERVER_MODEL,
                },
            },
        },

        opts = {
            log_level = "DEBUG",
            language = "English",
            send_code = true,
        },

        prompt_library = {
            -- TODO: commented-out content in markdown prompts should be removed
            markdown = {
                dirs = {
                    companion_dir .. "/prompts",
                    vim.fn.getcwd() .. "/.prompts",
                },
            },
        },

        rules = {
            -- only sent to HTTP adapters (an ACP agent loads its own)
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

                inline = {
                    -- TODO: add rules for inline
                    autoload = {},
                },
            },
        },

        skills = {
            -- only sent to HTTP adapters (an ACP agent loads its own)
            opts = {
                inline = {
                    autoload = {},
                },
            },
        },
    }

    companion.setup(companion_opts)
end

return {
    {
        "olimorris/codecompanion.nvim",
        version = "^20.0.0",
        cmd = {
            "CodeCompanion",
            "CodeCompanionChat",
            "CodeCompanionActions",
        },
        keys = {
            { "<leader>ai", ":CodeCompanionChat Toggle<cr>", mode = "n", desc = "ai-chat-buffer" },
            { "<leader>aI", ":CodeCompanionChat<cr>", mode = "n", desc = "new-ai-chat-buffer" },
            -- TODO: choose adapter while executing inline suggestions/corrections
            { "<leader>app", ":CodeCompanionActions refresh<cr>", mode = "n", desc = "prompts-list" },
            {
                "<leader>vc",
                ":! tail -n 500 ~/.local/state/nvim/codecompanion.log<cr>",
                mode = "n",
                desc = "chat-logs-tail",
            },

            { "<leader>ai", ":CodeCompanion<cr>", mode = "v", desc = "ai-chat-companion" },
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

-- TODO: token-limiting
-- https://codecompanion.olimorris.dev/configuration/callbacks#preventing-submission
