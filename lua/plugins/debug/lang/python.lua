-- lua/plugins/debug/lang/python.lua
-- Python DAP adapter and launch configurations.

local M = {}

---Resolve Python executable: .venv, VIRTUAL_ENV, uv, pyenv, then system.
---@return string
function M.resolve_python_path()
    local cwd = vim.fn.getcwd()
    local venv_paths = {
        cwd .. "/.venv/bin/python",
    }

    for _, path in ipairs(venv_paths) do
        if vim.fn.executable(path) == 1 then
            return path
        end
    end

    local virtual_env = vim.env.VIRTUAL_ENV
    if virtual_env then
        local venv_python = virtual_env .. "/bin/python"
        if vim.fn.executable(venv_python) == 1 then
            return venv_python
        end
    end

    local uv_python = vim.fn.trim(vim.fn.system("uv run which python 2>/dev/null"))
    if vim.v.shell_error == 0 and vim.fn.executable(uv_python) == 1 then
        return uv_python
    end

    local pyenv_python = vim.fn.expand("~/.pyenv/shims/python")
    if vim.fn.executable(pyenv_python) == 1 then
        return pyenv_python
    end

    return "python3"
end

---Return adapter and runtime paths (same logic as setup), for DAP info display.
---@return string adapter_path
---@return string runtime_path
function M.get_adapter_paths()
    local python_path = M.resolve_python_path()
    local nvim_config_debugpy = vim.fn.stdpath("config") .. "/.venv/bin/python"
    local adapter_python = nvim_config_debugpy

    if vim.fn.executable(nvim_config_debugpy) == 0 then
        adapter_python = python_path
    else
        local check_debugpy = vim.fn.system(nvim_config_debugpy .. " -c 'import debugpy' 2>&1")
        if vim.v.shell_error ~= 0 then
            adapter_python = python_path
        end
    end

    return adapter_python, python_path
end

---Append Python-specific lines for the DAP info window.
---@param lines string[]
function M.get_info_lines(lines)
    local adapter_python, python_path = M.get_adapter_paths()
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
end

---Setup Python DAP: adapter (debugpy) and launch configurations.
function M.setup()
    local python_path = M.resolve_python_path()
    local nvim_config_debugpy = vim.fn.stdpath("config") .. "/.venv/bin/python"
    local adapter_python = nvim_config_debugpy

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

    local resolve_python_path = M.resolve_python_path
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
        -- TODO: custom command as entrypoint
        -- TODO: read targets from a makefile
    }
end

return M
