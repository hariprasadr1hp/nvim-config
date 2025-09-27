-- lua/plugins/ai/codecompanion.lua

-- refer: https://codecompanion.olimorris.dev/

local function setup_codecompanion_config()
    local companion = require("codecompanion")
    local companion_adapters = require("codecompanion.adapters")

    local opts = {
        adapters = {
            opts = {
                show_model_choices = true,
            },

            ollama = function()
                return companion_adapters.extend("ollama", {
                    env = {
                        url = vim.env.OLLAMA_SERVER_HOST,
                        -- url = vim.env.OLLAMA_LOCAL_HOST,
                    },
                    schema = {
                        model = {
                            default = vim.env.OLLAMA_DEFAULT_SERVER_MODEL,
                            -- default = vim.env.OLLAMA_DEFAULT_LOCAL_MODEL,
                        },
                    },
                })
            end,

            openai = function()
                return companion_adapters.extend("openai", {
                    env = {
                        api_key = vim.env.OPENAI_API_KEY,
                    },
                })
            end,
        },

        extensions = {
            mcphub = {
                callback = "mcphub.extensions.codecompanion",
                description = "Call tools and resources from the MCP Servers",
                opts = {
                    make_vars = true,
                    make_slash_commands = true,
                    show_result_in_chat = true,
                },
            },
        },

        ---@class CodeCompanion.Strategies
        strategies = {
            chat = {
                adapter = "ollama",
            },
            inline = {
                adapter = "ollama",
            },
            agent = {
                adapter = "ollama",
            },
        },

        opts = {
            ---@type "DEBUG" | "TRACE"
            log_level = "DEBUG",
        },
    }

    companion.setup(opts)

    -- local keymap_set = require("config.helpers").keymap_set
    -- keymap_set("n", "<leader>ai", ":CodeCompanionChat<CR>", "ai-chat")
end

return {
    {
        "olimorris/codecompanion.nvim",
        cmd = {
            "CodeCompanion",
            "CodeCompanionChat",
            "CodeCompanionActions",
            "CodeCompanionCmd",
        },
        keys = {
            { "<leader>ai", ":CodeCompanionChat<CR>", desc = "ai-chat-companion" },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "ravitemer/mcphub.nvim",
        },
        config = setup_codecompanion_config,
    },
}

-- TODO: add ACP (Agent Client Protocol) support
-- refer https://github.com/olimorris/codecompanion.nvim/discussions/2030
