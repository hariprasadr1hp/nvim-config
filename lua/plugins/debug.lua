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

    -- notify user of detected paths
    vim.notify("DAP adapter using: " .. adapter_python, vim.log.levels.INFO)
    vim.notify("DAP running code with: " .. python_path, vim.log.levels.INFO)

    require("dap-python").setup(adapter_python)

    require("dap").configurations.python = {
        {
            type = "python",
            request = "launch",
            name = "Launch current file",
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
            name = "Launch current file (no-third-party step-into)",
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
            name = "Launch module",
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
            name = "Launch script",
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
        keys = {
            {
                "<leader>db",
                function()
                    require("dap").toggle_breakpoint()
                end,
                desc = "breakpoint-toggle",
            },
            {
                "<leader>dc",
                function()
                    require("dap").continue()
                end,
                desc = "continue",
            },
            {
                "<leader>dd",
                function()
                    require("dapui").toggle()
                end,
                desc = "dap-ui-toggle",
            },
            {
                "<leader>de",
                function()
                    local ok, err = pcall(function()
                        require("dapui").eval(nil, { enter = true })
                    end)
                    if not ok then
                        vim.notify("DAP Eval failed: " .. tostring(err), vim.log.levels.WARN)
                    end
                end,
                desc = "eval",
            },
            {
                "<leader>di",
                function()
                    require("dap").step_into()
                end,
                desc = "step-into",
            },
            {
                "<leader>dl",
                ":DapShowLog<CR>",
                desc = "logs",
            },
            {
                "<leader>do",
                function()
                    require("dap").step_over()
                end,
                desc = "step-over",
            },
            {
                "<leader>dp",
                function()
                    require("dap").pause()
                end,
                desc = "pause",
            },
            {
                "<leader>dr",
                function()
                    require("dap").repl.toggle()
                end,
                desc = "repl-toggle",
            },
            {
                "<leader>ds",
                function()
                    require("dap").step_out()
                end,
                desc = "step-out",
            },
            {
                "<leader>dt",
                function()
                    require("dap").terminate()
                end,
                desc = "terminate",
            },
            {
                "<leader>du",
                function()
                    require("dap").run_to_cursor()
                end,
                desc = "run-to-cursor",
            },
            {
                "<leader>dU",
                function()
                    require("dap").run_last()
                end,
                desc = "run-last",
            },
            {
                "<leader>d1",
                function()
                    require("dap").step_into()
                end,
                desc = "step-into",
            },
            {
                "<leader>d2",
                function()
                    require("dap").step_over()
                end,
                desc = "step-over",
            },
            {
                "<leader>d3",
                function()
                    require("dap").step_out()
                end,
                desc = "step-out",
            },
        },
    },
}
