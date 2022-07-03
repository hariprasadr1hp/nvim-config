
local function runme()
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
		print(string.format("ERROR: not sure how to execute a '%s' file :(", file_type))
	end
end


vim.api.nvim_create_user_command("Runme", runme, {})

