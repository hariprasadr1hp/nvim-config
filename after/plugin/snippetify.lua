-- after/plugin/snippetify.lua

-- Function to escape special characters for JSON strings
local function escape_json_string(str)
	str = str:gsub("\\", "\\\\")
	str = str:gsub('"', '\\"')
	str = str:gsub("\n", "\\n")
	str = str:gsub("\t", "\\t")
	return str
end

-- Function to convert visually selected text into a VSCode snippet
local function convert_to_vscode_snippet()
	-- Get the starting and ending positions of the visual selection
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")

	-- Extract the lines from the visual selection
	local lines = vim.fn.getline(start_pos[2], end_pos[2])

	-- Adjust the starting and ending columns for the selection
	local start_col = start_pos[3]
	local end_col = end_pos[3]

	-- Handle single-line or multi-line visual selections
	if #lines == 1 then
		lines[1] = string.sub(lines[1], start_col, end_col)
	else
		lines[1] = string.sub(lines[1], start_col)
		lines[#lines] = string.sub(lines[#lines], 1, end_col)
	end

	-- Escape the lines for JSON
	local escaped_lines = {}
	for i = 1, #lines do
		escaped_lines[i] = '"' .. escape_json_string(lines[i]) .. '"'
	end

	-- Create the snippet body with placeholders (you can customize as needed)
	local snippet_body = table.concat(escaped_lines, ",\n")
	local snippet_json = '{\n  "prefix": "exampleSnippet",\n  "body": ['
		.. snippet_body
		.. '],\n  "description": "Your custom snippet"\n}'

	-- Copy the snippet JSON to the clipboard
	vim.fn.setreg("+", snippet_json)
	print("Snippet JSON copied to clipboard!")
end

-- Create a command to call the function
vim.api.nvim_create_user_command("SnippetConvert", convert_to_vscode_snippet, { range = true })
