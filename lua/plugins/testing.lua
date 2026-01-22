-- lua/plugins/testing.lua

local function setup_neotest_config()
    local keymap_set = require("config.helpers").keymap_set
    local neotest = require("neotest")

    local opts = {
        adapters = {
            require("neotest-python")({
                dap = { justMyCode = false },
                args = { "--log-level", "DEBUG" },
                runner = "pytest",
                python = ".venv/bin/python",
                pytest_discover_instances = true,
            }),

            require("neotest-jest")({
                estCommand = "npm test --",
                jestArguments = function(defaultArguments, _)
                    return defaultArguments
                end,
                jestConfigFile = "custom.jest.config.ts",
                env = { CI = true },
                cwd = function(_)
                    return vim.fn.getcwd()
                end,
                isTestFile = require("neotest-jest.jest-util").defaultIsTestFile,
            }),

            -- TODO: playwright testing
            -- require("neotest-playwright"),
            require("neotest-bash"),
            require("neotest-ctest"),
            require("neotest-plenary"),
        },
    }

    neotest.setup(opts)

    keymap_set("n", "<leader>cnf", function()
        pcall(neotest.run.run, vim.fn.expand("%"))
    end, "file-current")

    keymap_set("n", "<leader>cnF", function()
        -- TODO: fuzzy-select file, to run tests
        vim.ui.input({ prompt = "Enter filepath" }, function(fpath)
            pcall(neotest.run.run, fpath)
        end)
    end, "file-current")

    keymap_set("n", "<leader>cns", function()
        pcall(neotest.run.run)
    end, "symbol")

    keymap_set("n", "<leader>cnw", function()
        neotest.run.run(vim.fn.getcwd())
    end, "workspace")
end

return {
    {
        "echasnovski/mini.test",
        version = false,
        opts = {},
    },

    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "folke/lazydev.nvim",
            "nvim-neotest/neotest-python",
            "rcasia/neotest-bash",
            "haydenmeade/neotest-jest",
            "thenbe/neotest-playwright",
            "orjangj/neotest-ctest",
            "nvim-neotest/neotest-plenary",
        },
        config = setup_neotest_config,
        keys = {
            { "<leader>cc", "<cmd>Neotest summary<CR>", desc = "neotest-summary" },
            { "<leader>cno", "<cmd>Neotest output<CR>", desc = "neotest-summary" },
        },
    },

    -- for toggling tests
    -- BUG: the below plugin jumps to test files in an alphabetical order, when multiple matching
    -- test files are found.
    -- current: for `src/api/routes/login.py`, `tests/aaa/routes/test_login.py` instead of `tests/api/routes/test_login.py`
    -- expected: instead should try to prioritize matching path, as much as possible
    {
        "herisetiawan00/jtt.nvim",
        cmd = "JumpTest",
        keys = {
            { "<leader>ct", "<cmd>JumpTest<CR>", desc = "test-jump" },
        },
        config = function()
            require("jtt").setup({
                languages = {
                    dart = { mode = "suffix", test = "_test", ext = ".dart" },
                    python = { mode = "prefix", test = "test_", ext = ".py" },
                    typescript = { mode = "suffix", test = ".spec", ext = ".ts" },
                },
            })
        end,
    },
}
