-- lua/plugins/ai/completion.lua

local Switch = require("core.switch")

local function setup_minuet_config()
    local minuet = require("minuet")

    local opts = {
        blink = {
            enable_auto_complete = false,
        },
        virtualtext = {
            auto_trigger_ft = {},
            auto_trigger_ignore_ft = {},
            keymap = {
                accept = "<A-A>",
                accept_line = "<A-a>",
                accept_n_lines = "<A-z>",
                prev = "<A-[>",
                next = "<A-]>",
                dismiss = "<A-e>",
            },
            show_on_completion_menu = false,
        },

        provider = "openai_fim_compatible",
        n_completions = 1,
        context_window = 512,
        context_ratio = 0.75,
        -- only send the request every x milliseconds, use 0 to disable throttle.
        throttle = 1000,
        -- debounce the request in x milliseconds, set to 0 to disable debounce
        debounce = 400,
        ---@type "debug" | "verbose" | "warn" | "error" | false
        notify = "warn",
        provider_options = {
            openai_fim_compatible = {
                api_key = "TERM",
                name = "Ollama",
                end_point = vim.env.OLLAMA_SERVER_HOST .. "/v1/completions",
                model = vim.env.OLLAMA_DEFAULT_SERVER_MODEL,
                optional = {
                    max_tokens = 56,
                    top_p = 0.9,
                },
            },
        },
    }

    minuet.setup(opts)
end

return {
    {
        "milanglacier/minuet-ai.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
        },
        cmd = { "Minuet" },
        keys = function()
            local blink_switch = Switch:new({
                on_func = function()
                    vim.cmd("Minuet blink enable")
                end,
                off_func = function()
                    vim.cmd("Minuet blink disable")
                end,
                state = true,
            })

            local virt_switch = Switch:new({
                on_func = function()
                    vim.cmd("Minuet virtualtext enable")
                end,
                off_func = function()
                    vim.cmd("Minuet virtualtext disable")
                end,
                state = true,
            })

            return {
                {
                    "<leader>ta",
                    function()
                        blink_switch:switch()
                    end,
                    desc = "ai-completion-blink",
                },
                {
                    "<leader>tA",
                    function()
                        virt_switch:switch()
                    end,
                    desc = "ai-completion-virt",
                },
            }
        end,
        config = setup_minuet_config,
    },
}
