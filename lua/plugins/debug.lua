-- lua/plugins/debug.lua

local function resolve_python_path()
    local uv_python = vim.fn.trim(vim.fn.system("uv venv python"))
    if vim.fn.executable(uv_python) == 1 then
        return uv_python
    end
    return vim.fn.expand("~/.pyenv/shims/python")
end

local function setup_dap_python_config()
    require("dap-python").setup(resolve_python_path())

    -- dynamic entrypoint prompt
    require("dap").configurations.python = {
        {
            type = "python",
            request = "launch",
            name = "Launch file (prompt)",
            program = function()
                return vim.fn.input("Path to script: ", vim.fn.getcwd() .. "/", "file")
            end,
            pythonPath = resolve_python_path,
        },
    }
end

local function setup_dap_config()
    local dap = require("dap")
    local dapui = require("dapui")

    setup_dap_python_config()

    dap.listeners.before.attach.dapui_config = dapui.open
    dap.listeners.before.event_terminated.dapui_config = dapui.close
    dap.listeners.before.event_exited.dapui_config = dapui.close

    -- local keymap_set = require("config.helpers").keymap_set
    -- keymap_set("n", "<leader>db", dap.toggle_breakpoint, "breakpoint")
    -- keymap_set("n", "<leader>dc", dap.continue, "continue")
    -- keymap_set("n", "<leader>dd", dapui.toggle, "dapui-toggle")
    -- keymap_set("n", "<leader>de", function()
    --     dapui.eval(nil, { enter = true })
    -- end, "eval")
    -- keymap_set("n", "<leader>di", dap.step_into, "step-into")
    -- -- keymap_set("n", "<leader>dk", dapui.close, "close")
    -- keymap_set("n", "<leader>do", dap.step_over, "step-over")
    -- keymap_set("n", "<leader>dp", dap.pause, "pause")
    -- keymap_set("n", "<leader>dr", dap.repl.toggle, "repl-toggle")
    -- keymap_set("n", "<leader>ds", dap.step_out, "step-out")
    -- keymap_set("n", "<leader>dt", dap.terminate, "terminate")
    -- keymap_set("n", "<leader>du", dap.run_to_cursor, "run-to-cursor")
    -- keymap_set("n", "<leader>dU", dap.run_last, "run-last")
    --
    -- keymap_set("n", "<leader>d1", dap.step_into, "step-into")
    -- keymap_set("n", "<leader>d2", dap.step_over, "step-over")
    -- keymap_set("n", "<leader>d3", dap.step_out, "step-out")
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
        keys = {
            {
                "<leader>db",
                function()
                    require("dap").toggle_breakpoint()
                end,
                desc = "Breakpoint",
            },
            {
                "<leader>dc",
                function()
                    require("dap").continue()
                end,
                desc = "Continue",
            },
            {
                "<leader>dd",
                function()
                    require("dapui").toggle()
                end,
                desc = "DAP UI Toggle",
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
                desc = "Eval",
            },
            {
                "<leader>di",
                function()
                    require("dap").step_into()
                end,
                desc = "Step Into",
            },
            {
                "<leader>do",
                function()
                    require("dap").step_over()
                end,
                desc = "Step Over",
            },
            {
                "<leader>dp",
                function()
                    require("dap").pause()
                end,
                desc = "Pause",
            },
            {
                "<leader>dr",
                function()
                    require("dap").repl.toggle()
                end,
                desc = "REPL Toggle",
            },
            {
                "<leader>ds",
                function()
                    require("dap").step_out()
                end,
                desc = "Step Out",
            },
            {
                "<leader>dt",
                function()
                    require("dap").terminate()
                end,
                desc = "Terminate",
            },
            {
                "<leader>du",
                function()
                    require("dap").run_to_cursor()
                end,
                desc = "Run to Cursor",
            },
            {
                "<leader>dU",
                function()
                    require("dap").run_last()
                end,
                desc = "Run Last",
            },
            {
                "<leader>d1",
                function()
                    require("dap").step_into()
                end,
                desc = "Step Into",
            },
            {
                "<leader>d2",
                function()
                    require("dap").step_over()
                end,
                desc = "Step Over",
            },
            {
                "<leader>d3",
                function()
                    require("dap").step_out()
                end,
                desc = "Step Out",
            },
        },
        config = setup_dap_config,
    },
}
