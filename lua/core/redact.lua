-- lua/core/redact.lua

local Redact = {}

Redact.values = {}

---@param content_string string
---@return string
function Redact.redact(content_string)
    for value, mask_func in pairs(Redact.values) do
        -- Escape special pattern characters
        local escaped_value = string.gsub(value, "[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%1")
        content_string = string.gsub(content_string, escaped_value, mask_func(value))
    end
    return content_string
end

---@param content_string string
---@return string
function Redact.unredact(content_string)
    -- Sort by masked value length (descending) to avoid substring conflicts
    local sorted_values = {}
    for value, mask_func in pairs(Redact.values) do
        table.insert(sorted_values, { value = value, mask_func = mask_func })
    end
    table.sort(sorted_values, function(a, b)
        return #a.mask_func(a.value) > #b.mask_func(b.value)
    end)

    for _, item in ipairs(sorted_values) do
        local value = item.value
        local mask_func = item.mask_func
        local masked_value = mask_func(value)
        -- Escape special pattern characters in masked value
        local escaped_masked = string.gsub(masked_value, "[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%1")
        -- Escape % in replacement string (% needs to be doubled in replacement)
        local escaped_replacement = string.gsub(value, "%%", "%%%%")
        content_string = string.gsub(content_string, escaped_masked, escaped_replacement)
    end
    return content_string
end

---Redact multiple lines at once
---@param lines table Array of strings to redact
---@return table Array of redacted strings
function Redact.redact_lines(lines)
    local result = {}
    for i, line in ipairs(lines) do
        result[i] = Redact.redact(line)
    end
    return result
end

---Unredact multiple lines at once
---@param lines table Array of strings to unredact
---@return table Array of unredacted strings
function Redact.unredact_lines(lines)
    local result = {}
    for i, line in ipairs(lines) do
        result[i] = Redact.unredact(line)
    end
    return result
end

---Default mask function - replaces value with asterisks
---@param value string
---@return string
local function _mask_value(value)
    return string.rep("*", #value)
end

function Redact:new(args)
    args = args or {}

    -- Validate value is not empty
    if not args.value or args.value == "" then
        error("Redact: value cannot be empty")
    end

    -- Warn if overwriting existing value
    if Redact.values[args.value] then
        vim.notify(string.format("Redact: value '%s' already exists, overwriting", args.value), vim.log.levels.WARN)
    end

    local default_args = {
        value = "",
        mask_func = _mask_value,
    }
    local init = vim.tbl_extend("force", default_args, args)

    -- Ensure mask_func is a function, fallback to _mask_value
    if type(init.mask_func) ~= "function" then
        init.mask_func = _mask_value
    end

    Redact.values[init.value] = init.mask_func
    return setmetatable(init, { __index = Redact })
end

function Redact.update_mask_func(self, mask_func)
    Redact.values[self.value] = mask_func
    self.mask_func = mask_func
    return self
end

---Remove this redaction rule
function Redact:remove()
    Redact.values[self.value] = nil
    return self
end

---Clear all redaction rules
function Redact.clear_all()
    Redact.values = {}
end

return Redact
