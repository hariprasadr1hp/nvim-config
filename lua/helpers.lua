-- lua/helpers.lua

local M = {}

-- Print tables, as well as numbers/strings
function M.pprint(value)
	if type(value) == "table" then
		print(vim.inspect(value))
	else
		print(value)
	end
end

-- Print (type) of tables, as well as numbers/strings
function M.tprint(value)
	print(type(value))
end

-- Helper function to feed keys with termcode replacements
function M.feedkeys(keys, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), mode, true)
end

-- Whether it is in recording mode, currently
function M.is_recording()
	return vim.fn.reg_recording() ~= ""
end

function M.runme()
	local file_type = vim.bo.filetype
	if file_type == "python" then
		local cmd = string.format("! %s %%", vim.g.python3_host_prog)
		vim.cmd(cmd)
	elseif file_type == "lua" then
		vim.cmd("! lua %")
	elseif file_type == "c" then
		vim.cmd("! gcc % -o /tmp/a.out && /tmp/a.out")
	elseif file_type == "cpp" then
		vim.cmd("! g++ % -o /tmp/a.out && /tmp/a.out")
	elseif file_type == "" then
		print("ERROR: no defined filetype to evaluate!")
	else
		print(string.format("ERROR: not sure how to execute a `.%s` file :(", file_type))
	end
end

_G.pprint = M.pprint
_G.tprint = M.tprint

return M
