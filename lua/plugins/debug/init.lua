-- lua/plugins/debug/init.lua

-- Path to temp file when running "buffer" config; cleared and deleted on session end.
local dap_buffer_temp_file = nil

local function show_dap_info()
    local util = require("plugins.debug.util")
    util.open_dap_floating_buffer(util.build_dap_info_lines(), "DapInfo")
end

local function dap_goto_line()
    local dap = require("dap")
    vim.ui.input({ prompt = "Goto line (+/-N for relative): " }, function(input)
        if input and input ~= "" then
            local current_line = vim.fn.line(".")
            local target_line

            local relative_line_num_pattern = "^[+-]%d+$"
            -- Check for relative line numbers (+N or -N)
            if input:match(relative_line_num_pattern) then
                local offset = tonumber(input)
                if offset then
                    target_line = current_line + offset
                end
            else
                -- Absolute line number
                target_line = tonumber(input)
            end

            if target_line and target_line > 0 then
                dap.goto_(target_line)
            else
                vim.notify("Invalid line number: " .. input, vim.log.levels.ERROR)
            end
        end
    end)
end

local function dap_eval_vars()
    local dapui = require("dapui")
    local ok, err = pcall(function()
        dapui.eval(nil, { enter = true })
    end)
    if not ok then
        vim.notify("DAP Eval failed: " .. tostring(err), vim.log.levels.WARN)
    end
end

local function feed_input_to_dap_repl()
    local dap = require("dap")
    vim.ui.input({ prompt = "dap repl execute" }, function(val)
        dap.repl.execute(val)
    end)
end

local function show_dap_current_session_info()
    local util = require("plugins.debug.util")
    local dap = require("dap")
    util.open_dap_floating_buffer(util.session_to_lines(dap.session()), "DapSession")
end

local function show_dap_all_sessions_info()
    local util = require("plugins.debug.util")
    local dap = require("dap")
    util.open_dap_floating_buffer(util.session_to_lines(dap.sessions()), "DapSessions")
end

local function setup_dap_config()
    local util = require("plugins.debug.util")
    local dap = require("dap")
    local dapui = require("dapui")

    -- Setup DAP UI with default configuration
    dapui.setup()

    vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "SignColumn" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "󰃤 ", texthl = "SignColumn" })

    -- Setup virtual text for inline variable display
    require("nvim-dap-virtual-text").setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
        only_first_definition = true,
        all_references = false,
        virt_text_pos = "eol",
    })

    -- Setup language-specific DAP adapters and configurations (from lang/*.lua)
    util.setup_lang_configs()

    -- Open UI when DAP session starts
    dap.listeners.after.event_initialized.dapui_config = dapui.open

    -- Close UI when DAP session ends
    dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
        dap_buffer_temp_file = util.cleanup_temp_file(dap_buffer_temp_file)
        util.cleanup_interactive_mode(true)
    end
    dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
        dap_buffer_temp_file = util.cleanup_temp_file(dap_buffer_temp_file)
        util.cleanup_interactive_mode(true)
    end

    -- Create user command to show DAP info
    -- vim.api.nvim_create_user_command("DapInfo", show_dap_info, { desc = "Show DAP adapter and path information" })
end

return {
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
            "theHamsta/nvim-dap-virtual-text",
            "mfussenegger/nvim-dap-python",
            "echasnovski/mini.notify",
        },
        config = setup_dap_config,
        cmd = {
            "DapClearBreakpoints",
            "DapContinue",
            "DapDisconnect",
            "DapEval",
            "DapNew",
            "DapPause",
            "DapRestartFrame",
            "DapSetLogLevel",
            "DapShowLog",
            "DapStepInto",
            "DapStepOut",
            "DapStepOver",
            "DapTerminate",
            "DapToggleBreakpoint",
            "DapToggleRepl",
        },
        keys = function()
            local nvim_echo = vim.api.nvim_echo
            local keymap_set = require("config.helpers").keymap_set
            local dap = require("dap")
            local dapui = require("dapui")

            return {
                { "<leader>d1", dap.step_into, desc = "step-into" },
                { "<leader>d2", dap.step_over, desc = "step-over" },
                { "<leader>d3", dap.step_out, desc = "step-out" },
                { "<leader>d4", dap.step_back, desc = "step-back" },
                { "<leader>d5", ":DapShowLog<cr>", desc = "verbose-logs" },
                { "<leader>da", feed_input_to_dap_repl, desc = "add-repl-input" },
                { "<leader>dA", dap.repl.toggle, desc = "repl-toggle" },
                { "<leader>db", dap.toggle_breakpoint, desc = "breakpoint-toggle" },
                { "<leader>dB", dap.set_exception_breakpoints, desc = "breakpoint-exception" },
                { "<leader>dc", dap.continue, desc = "continue" },
                { "<leader>dC", dap.reverse_continue, desc = "reverse-continue" },
                { "<leader>dd", dapui.toggle, desc = "dap-ui-toggle" },
                { "<leader>de", dap_eval_vars, desc = "eval" },
                { "<leader>dF", dap.focus_frame, desc = "focus-frame" },
                { "<leader>dg", dap_goto_line, desc = "goto-line" },
                { "<leader>di", dap.step_into, desc = "step-into" },
                { "<leader>dI", show_dap_info, desc = "info-dap" },
                { "<leader>dj", dap.down, desc = "down" },
                { "<leader>dk", dap.up, desc = "up" },
                { "<leader>dK", dap.step_back, desc = "step-bacK" },
                { "<leader>dl", dap.run_to_cursor, desc = "run-to-line" },
                { "<leader>dL", dap.run_last, desc = "run-last-debug-session" },
                { "<leader>do", dap.step_over, desc = "step-over" },
                { "<leader>dO", dap.step_out, desc = "step-out" },
                { "<leader>dp", dap.pause, desc = "pause" },
                { "<leader>dr", dap.restart_frame, desc = "Restart" },
                { "<leader>dR", dap.restart, desc = "Restart" },
                { "<leader>ds", show_dap_current_session_info, desc = "current-session-info" },
                { "<leader>dS", show_dap_all_sessions_info, desc = "all-sessions-info" },
                { "<leader>dt", dap.terminate, desc = "terminate" },

                {
                    "<leader>du",
                    function()
                        -- Store mode state in a more persistent location
                        if not vim.g.dap_interactive_mode_active then
                            vim.g.dap_interactive_mode_active = false
                        end

                        local function exit_mode()
                            require("plugins.debug.util").cleanup_interactive_mode(false)
                            nvim_echo({ { "-- interactive-debug-mode successfully exited!", "InfoMsg" } }, false, {})
                        end

                        local function enter_mode()
                            if vim.g.dap_interactive_mode_active then
                                nvim_echo({ { "-- interactive-debug-mode already active!", "WarningMsg" } }, false, {})
                                return
                            end
                            vim.g.dap_interactive_mode_active = true

                            local keymaps = {
                                { key = "1", fn = dap.step_into, desc = "step into" },
                                { key = "2", fn = dap.step_over, desc = "step over" },
                                { key = "3", fn = dap.step_out, desc = "step out" },
                                { key = "4", fn = dap.step_back, desc = "step back" },
                                { key = "a", fn = feed_input_to_dap_repl, desc = "input to repl" },
                                { key = "A", fn = dap.repl.toggle, desc = "toggle repl" },
                                { key = "b", fn = dap.toggle_breakpoint, desc = "toggle breakpoint" },
                                { key = "B", fn = dap.set_exception_breakpoints, desc = "exception breakpoint" },
                                { key = "C", fn = dap.reverse_continue, desc = "reverse continue" },
                                { key = "e", fn = dap_eval_vars, desc = "eval vars" },
                                { key = "F", fn = dap.focus_frame, desc = "focus frame" },
                                { key = "g", fn = dap_goto_line, desc = "goto line" },
                                { key = "i", fn = dap.step_into, desc = "step into" },
                                { key = "I", fn = show_dap_info, desc = "dap info" },
                                { key = "j", fn = dap.down, desc = "stack down" },
                                { key = "k", fn = dap.up, desc = "stack up" },
                                { key = "K", fn = dap.step_back, desc = "step back" },
                                { key = "l", fn = dap.run_to_cursor, desc = "run upto line" },
                                { key = "L", fn = dap.run_last, desc = "run last session" },
                                { key = "o", fn = dap.step_over, desc = "step over" },
                                { key = "O", fn = dap.step_out, desc = "step out" },
                                { key = "p", fn = dap.pause, desc = "pause" },
                                { key = "r", fn = dap.restart_frame, desc = "restart frame" },
                                { key = "R", fn = dap.restart, desc = "restart" },
                                { key = "q", fn = exit_mode, desc = "quit mode" },
                                { key = "s", fn = show_dap_current_session_info, desc = "current session info" },
                                { key = "S", fn = show_dap_all_sessions_info, desc = "all sessions info" },
                                { key = "t", fn = dapui.toggle, desc = "toggle ui" },
                                { key = "T", fn = dap.terminate, desc = "terminate" },
                                { key = "w", fn = dap.continue, desc = "continue" },
                                { key = "X", fn = dap.clear_breakpoints, desc = "clear breakpoints" },
                            }

                            -- Track which keys we're setting for cleanup
                            local tracked_keys = {}
                            for _, km in ipairs(keymaps) do
                                table.insert(tracked_keys, km.key)
                            end
                            vim.g.dap_interactive_keys = tracked_keys

                            -- Set global keymaps
                            for _, km in ipairs(keymaps) do
                                keymap_set("n", km.key, km.fn, km.desc)
                            end

                            -- Generate cheatsheet dynamically from keymaps
                            local cheatsheet_lines = { "Interactive Debug Mode", "" }
                            for _, km in ipairs(keymaps) do
                                table.insert(cheatsheet_lines, string.format("  %s - %s", km.key, km.desc))
                            end

                            local cheatsheet = table.concat(cheatsheet_lines, "\n")

                            -- Use MiniNotify.add() for persistent notification
                            local ok, result = pcall(function()
                                local mini_notify = require("mini.notify")
                                -- MiniNotify.add(msg, level, hl_group, data)
                                return mini_notify.add(cheatsheet, "INFO", "DiagnosticInfo", {})
                            end)

                            if ok and result then
                                vim.g.dap_interactive_notif_id = result
                            end
                        end

                        enter_mode()
                    end,
                    desc = "user-interactive",
                },

                { "<leader>dv", ":DapShowLog<cr>", desc = "verbose-logs" },
                { "<leader>dx", dap.close, desc = "close-not-terminate" },
                { "<leader>id", show_dap_info, desc = "debug-info" },
                {
                    "<leader>qb",
                    function()
                        dap.list_breakpoints(true)
                    end,
                    desc = "breakpoints-to-quickfix",
                },
                { "<leader>rdl", dap.run_last, desc = "last-debug-session" },
                { "<leader>xb", dap.clear_breakpoints, desc = "breakpoints" },
            }
        end,
    },
}

-- TODO: reflect file-modifications during an on-going debug session?
-- TODO: identifying iteration count in a loop? (for/while)
-- TODO: add DAP adapters for lua, rust, haskell
-- TODO: custom command as entrypoint
