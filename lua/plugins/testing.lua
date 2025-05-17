-- lua/plugins/testing.lua

return {
    {
        "echasnovski/mini.test",
        version = false,
        opts = {},
    },
    -- for toggling tests
    -- TODO: the below plugin jumps to test files in an alphabetical order, when multiple matching
    -- test files are found.
    -- current: for `src/api/routes/login.py`, `tests/aaa/routes/test_login.py` instead of `tests/api/routes/test_login.py`
    -- expected: instead should try to prioritize matching path, as much as possible
    {
        "herisetiawan00/jtt.nvim",
        cmd = "JumpTest",
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
