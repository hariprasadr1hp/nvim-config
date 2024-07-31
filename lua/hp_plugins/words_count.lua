local M = {}

function words_count()
	local words = 0
	for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
		for _ in string.gmatch(line, "%S+") do
            words = words + 1
        end
    end
    print("Word count: " .. words)
end

vim.api.nvim_create_user_command(
    'WordCount',
    function()
		M.words_count()
		-- return "42"
	end,
    { nargs = 0 }
)

return M
