local content = [[
pos  source                                  dest                                     type     properties
---  --------------------------------------  ---------------------------------------  -------  -------------------------
97   "ff0a4484-a0ba-49ec-a39d-569ddc06ba6c"  "//github.com/maxxnino/tree-sitter-zig"  "https"  (:outline ("references"))
176  "ff0a4484-a0ba-49ec-a39d-569ddc06ba6c"  "//github.com/zigtools/zls"              "https"  (:outline ("references"))
183  "ddfda8c4-81e5-4aaf-82de-94b7e998dbf7"  "//github.com/zellij-org/zellij"         "https"  (:outline ("references"))
]]

-- Converts sqlite table content to a Lua table
---@param stdout string
---@return table
local function to_table(stdout)
    local result = {}
    local headers = {}
    local is_first_line = true

    for line in stdout:gmatch("[^\r\n]+") do
        -- Parse header line to get column names
        if is_first_line then
            for header in line:gmatch("%S+") do
                table.insert(headers, header)
            end
            is_first_line = false
        -- Skip separator line
        elseif not line:match("^%-%-%-") then
            -- Parse data line (split by whitespace, handling quoted strings)
            local fields = {}
            for field in line:gmatch("%S+") do
                table.insert(fields, field)
            end

            if #fields >= #headers then
                local row = {}

                -- Map each field to its corresponding header
                for i, header in ipairs(headers) do
                    local value = fields[i]

                    -- Remove surrounding quotes if present
                    value = value:gsub('^"', ""):gsub('"$', "")

                    -- Try to convert to number if it's the first column (usually an ID/pos)
                    if i == 1 and tonumber(value) then
                        row[header] = tonumber(value)
                    else
                        row[header] = value
                    end
                end

                -- If there are extra fields beyond headers, combine them into the last column
                if #fields > #headers then
                    local extra_fields = {}
                    for i = #headers + 1, #fields do
                        table.insert(extra_fields, fields[i])
                    end
                    local last_header = headers[#headers]
                    row[last_header] = row[last_header] .. " " .. table.concat(extra_fields, " ")
                end

                table.insert(result, row)
            end
        end
    end

    return result
end

vim.print(to_table(content))
