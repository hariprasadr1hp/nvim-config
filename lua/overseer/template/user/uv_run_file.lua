return {
    name = "uv run %",
    builder = function()
        local file = vim.fn.expand("%:p")
        return {
            cmd = { "uv", "run", "python", file },
        }
    end,
    condition = {
        filetype = { "python" },
    },
}
