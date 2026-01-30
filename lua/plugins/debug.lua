-- lua/plugins/debug.lua

local function resolve_python_path()
    -- try project-local venv first
    local cwd = vim.fn.getcwd()
    local venv_paths = {
        cwd .. "/.venv/bin/python",
    }

    for _, path in ipairs(venv_paths) do
        if vim.fn.executable(path) == 1 then
            return path
        end
    end

    -- try VIRTUAL_ENV environment variable
    local virtual_env = vim.env.VIRTUAL_ENV
    if virtual_env then
        local venv_python = virtual_env .. "/bin/python"
        if vim.fn.executable(venv_python) == 1 then
            return venv_python
        end
    end

    -- try uv-managed Python
    local uv_python = vim.fn.trim(vim.fn.system("uv run which python 2>/dev/null"))
    if vim.v.shell_error == 0 and vim.fn.executable(uv_python) == 1 then
        return uv_python
    end

    -- fallback to pyenv
    local pyenv_python = vim.fn.expand("~/.pyenv/shims/python")
    if vim.fn.executable(pyenv_python) == 1 then
        return pyenv_python
    end

    -- final fallback to system python
    return "python3"
end

local function setup_dap_python_config()
    local python_path = resolve_python_path()

    -- use nvim config's venv for debugpy adapter (generalized across all projects)
    local nvim_config_debugpy = vim.fn.stdpath("config") .. "/.venv/bin/python"
    local adapter_python = nvim_config_debugpy

    -- Check if nvim config venv has `debugpy`, otherwise fall back to project python
    if vim.fn.executable(nvim_config_debugpy) == 0 then
        vim.notify("Nvim config venv not found, using project Python for adapter", vim.log.levels.WARN)
        adapter_python = python_path
    else
        local check_debugpy = vim.fn.system(nvim_config_debugpy .. " -c 'import debugpy' 2>&1")
        if vim.v.shell_error ~= 0 then
            vim.notify(
                "debugpy not in nvim venv. Install with: cd ~/.config/nvim && uv add debugpy",
                vim.log.levels.WARN
            )
            adapter_python = python_path
        end
    end

    require("dap-python").setup(adapter_python)

    require("dap").configurations.python = {
        {
            type = "python",
            request = "launch",
            name = "__main__",
            program = "${file}",
            args = function()
                local args_string = vim.fn.input("Arguments: ")
                return vim.split(args_string, " +")
            end,
            pythonPath = resolve_python_path,
            console = "integratedTerminal",
            cwd = "${workspaceFolder}",
            env = {
                PYTHONUNBUFFERED = "1",
            },
        },

        {
            type = "python",
            request = "launch",
            name = "pytest (current file)",
            module = "pytest",
            args = function()
                local args = { "${file}", "-v" }
                local extra_args = vim.fn.input("Additional pytest args: ")
                if extra_args ~= "" then
                    vim.list_extend(args, vim.split(extra_args, " +"))
                end
                return args
            end,
            pythonPath = resolve_python_path,
            console = "integratedTerminal",
            cwd = "${workspaceFolder}",
            env = {
                PYTHONUNBUFFERED = "1",
            },
        },

        {
            type = "python",
            request = "launch",
            name = "pytest (all tests)",
            module = "pytest",
            args = function()
                local args = { "-v" }
                local extra_args = vim.fn.input("Additional pytest args: ", "")
                if extra_args ~= "" then
                    vim.list_extend(args, vim.split(extra_args, " +"))
                end
                return args
            end,
            pythonPath = resolve_python_path,
            console = "integratedTerminal",
            cwd = "${workspaceFolder}",
            env = {
                PYTHONUNBUFFERED = "1",
            },
        },
        {
            type = "python",
            request = "launch",
            name = "__main__ (no-third-party step-into)",
            program = "${file}",
            pythonPath = resolve_python_path,
            args = function()
                local args_string = vim.fn.input("Arguments: ")
                return vim.split(args_string, " +")
            end,
            console = "integratedTerminal",
            cwd = "${workspaceFolder}",
            env = {
                PYTHONUNBUFFERED = "1",
            },
            justMyCode = true,
        },

        {
            type = "python",
            request = "launch",
            name = "launch module",
            module = function()
                return vim.fn.input("Module name: ")
            end,
            pythonPath = resolve_python_path,
            console = "integratedTerminal",
            cwd = "${workspaceFolder}",
        },

        {
            type = "python",
            request = "launch",
            name = "launch script",
            program = function()
                return vim.fn.input("Python script: ", vim.fn.getcwd() .. "/", "file")
            end,
            args = function()
                local args_string = vim.fn.input("Arguments: ")
                if args_string == "" then
                    return {}
                end
                return vim.split(args_string, " +")
            end,
            pythonPath = resolve_python_path,
            console = "integratedTerminal",
            cwd = "${workspaceFolder}",
            env = {
                PYTHONUNBUFFERED = "1",
            },
            justMyCode = false,
        },

        {
            type = "python",
            request = "launch",
            name = "FastAPI (uvicorn)",
            module = "uvicorn",
            args = function()
                local app_module = vim.fn.input("App module (e.g., main:app): ", "main:app")
                local port = vim.fn.input("Port: ", "8000")
                return { app_module, "--reload", "--host", "0.0.0.0", "--port", port }
            end,
            pythonPath = resolve_python_path,
            console = "integratedTerminal",
            cwd = "${workspaceFolder}",
            jinja = true,
        },
        --TODO: custom command as entrypoint
        --TODO: read targets from a makefile
        --TODO: read `overseer.nvim` actions
    }
    -- TODO: add DAP adapters for lua, rust, haskell
end

local function show_dap_info()
    local dap = require("dap")
    local lines = {
        "Debug Adapter Protocol Info",
        string.rep("─", 60),
        "",
    }

    -- Python-specific information
    local python_path = resolve_python_path()
    local nvim_config_debugpy = vim.fn.stdpath("config") .. "/.venv/bin/python"
    local adapter_python = nvim_config_debugpy

    -- determine adapter python path with same logic as setup
    if vim.fn.executable(nvim_config_debugpy) == 0 then
        adapter_python = python_path
    else
        local check_debugpy = vim.fn.system(nvim_config_debugpy .. " -c 'import debugpy' 2>&1")
        if vim.v.shell_error ~= 0 then
            adapter_python = python_path
        end
    end

    table.insert(lines, "Python:")
    table.insert(lines, string.format("  %-18s %s", "Adapter:", adapter_python))
    table.insert(
        lines,
        string.format("  %-18s %s", "Executable:", vim.fn.executable(adapter_python) == 1 and "✔" or "✘")
    )
    table.insert(lines, string.format("  %-18s %s", "Runtime:", python_path))
    table.insert(
        lines,
        string.format("  %-18s %s", "Executable:", vim.fn.executable(python_path) == 1 and "✔" or "✘")
    )
    table.insert(lines, "")

    -- Show all configured adapters
    table.insert(lines, "Configured Adapters:")
    local adapter_count = 0
    for name, _ in pairs(dap.adapters or {}) do
        adapter_count = adapter_count + 1
        table.insert(lines, string.format("  • %s", name))
    end
    if adapter_count == 0 then
        table.insert(lines, "  (No adapters configured)")
    end
    table.insert(lines, "")

    -- Show all configurations by filetype
    table.insert(lines, "Configurations by Filetype:")
    local config_count = 0
    for ft, configs in pairs(dap.configurations or {}) do
        config_count = config_count + 1
        table.insert(lines, string.format("  %s:", ft))
        for i, config in ipairs(configs) do
            table.insert(lines, string.format("    %d. %s", i, config.name))
        end
    end
    if config_count == 0 then
        table.insert(lines, "  (No configurations loaded)")
    end

    --TODO: add `dap.status`
    --TODO: add `dap.defaults` (fallbacks)
    --TODO: add `dap.providers`

    table.insert(lines, "")
    table.insert(lines, string.rep("─", 60))
    table.insert(lines, "Press 'q' to close this window.")

    local info_buf = vim.api.nvim_create_buf(false, true)
    vim.bo[info_buf].filetype = "DapInfo"
    vim.api.nvim_buf_set_lines(info_buf, 0, -1, false, lines)

    local width, height = 62, #lines
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    local win = vim.api.nvim_open_win(info_buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
    })

    vim.wo[win].wrap = false
    vim.wo[win].cursorline = true
    vim.bo[info_buf].modifiable = false
    vim.bo[info_buf].readonly = true

    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = info_buf, silent = true })
end

local function setup_dap_config()
    local dap = require("dap")
    local dapui = require("dapui")

    -- Setup DAP UI with default configuration
    dapui.setup()

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

    -- Setup Python debugging with error handling
    local ok, err = pcall(setup_dap_python_config)
    if not ok then
        vim.notify("Failed to setup Python debugging: " .. tostring(err), vim.log.levels.WARN)
    end

    -- Open UI when DAP session starts
    dap.listeners.after.event_initialized.dapui_config = dapui.open

    -- Close UI when DAP session ends
    dap.listeners.before.event_terminated.dapui_config = dapui.close
    dap.listeners.before.event_exited.dapui_config = dapui.close

    -- Create user command to show DAP info
    vim.api.nvim_create_user_command("DapInfo", function()
        show_dap_info()
    end, { desc = "Show DAP adapter and path information" })
end

return {
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
            "theHamsta/nvim-dap-virtual-text",
            "mfussenegger/nvim-dap-python",
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
            local dap = require("dap")
            local dapui = require("dapui")

            return {
                { "<leader>d1", dap.step_into, desc = "step-into" },
                { "<leader>d2", dap.step_over, desc = "step-over" },
                { "<leader>d3", dap.step_out, desc = "step-out" },
                { "<leader>d4", dap.step_back, desc = "step-back" },

                {
                    "<leader>da",
                    function()
                        vim.ui.input({ prompt = "dap repl execute" }, function(val)
                            dap.repl.execute(val)
                        end)
                    end,
                    desc = "add-repl-input",
                },
                { "<leader>dA", dap.repl.toggle, desc = "repl-toggle" },
                { "<leader>db", dap.toggle_breakpoint, desc = "breakpoint-toggle" },
                { "<leader>dB", dap.set_exception_breakpoints, desc = "breakpoint-exception" },
                { "<leader>dc", dap.continue, desc = "continue" },
                { "<leader>dC", dap.reverse_continue, desc = "reverse-continue" },
                { "<leader>dd", dapui.toggle, desc = "dap-ui-toggle" },
                {
                    "<leader>de",
                    function()
                        local ok, err = pcall(function()
                            dapui.eval(nil, { enter = true })
                        end)
                        if not ok then
                            vim.notify("DAP Eval failed: " .. tostring(err), vim.log.levels.WARN)
                        end
                    end,
                    desc = "eval",
                },
                { "<leader>df", dap.focus_frame, desc = "focus-frame" },
                {
                    "<leader>dg",
                    function()
                        vim.ui.input({ prompt = "Goto line (+/-N for relative): " }, function(input)
                            if input and input ~= "" then
                                local current_line = vim.fn.line(".")
                                local target_line

                                -- Check for relative line numbers (+N or -N)
                                if input:match("^[+-]%d+$") then
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
                    end,
                    desc = "goto-line",
                },
                { "<leader>di", dap.step_into, desc = "step-into" },
                { "<leader>dj", dap.down, desc = "down" },
                { "<leader>dk", dap.up, desc = "up" },
                { "<leader>dl", dap.run_to_cursor, desc = "run-to-line" },
                { "<leader>dL", dap.run_last, desc = "run-last-debug-session" },
                { "<leader>do", dap.step_over, desc = "step-over" },
                { "<leader>dO", dap.step_out, desc = "step-out" },
                { "<leader>dp", dap.pause, desc = "pause" },
                { "<leader>dr", dap.restart_frame, desc = "Restart" },
                { "<leader>dR", dap.restart, desc = "Restart" },
                {
                    "<leader>ds",
                    function()
                        -- TODO: floating-buffer instead of stdout
                        vim.print(dap.session())
                    end,
                    desc = "ongoing-session",
                },
                {
                    "<leader>dS",
                    function()
                        vim.print(dap.sessions())
                    end,
                    desc = "all-active-sessions",
                },
                { "<leader>dt", dap.terminate, desc = "terminate" },
                { "<leader>dv", ":DapShowLog<CR>", desc = "verbose-logs" },
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

-- focus_frame
-- pause
-- stop
-- terminate
-- disconnect
-- attach
-- restart
-- restart_frame
-- reverse_continue
-- run_last
-- run_to_cursor
