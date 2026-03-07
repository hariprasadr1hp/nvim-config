local config = require("codecompanion.config")

local Variable = {}

-- Persistent hashmap to store original -> redacted name mappings
local redaction_map = {}
local counter = 0

-- List of arbitrary placeholder names
local placeholder_names = {
    "fred",
    "waldo",
    "corge",
    "grault",
    "foo",
    "bar",
    "baz",
    "qux",
    "quux",
    "garply",
    "plugh",
    "xyzzy",
    "thud",
    "alpha",
    "beta",
    "gamma",
    "delta",
    "epsilon",
    "zeta",
    "eta",
    "theta",
}

function Variable.new(args)
    local self = setmetatable({
        Chat = args.Chat,
        config = args.config,
        params = args.params,
        target = args.target,
    }, { __index = Variable })

    return self
end

---@param input_string string
---@return string
local function _get_redacted_string(input_string)
    -- Check if we already have a mapping for this string
    if redaction_map[input_string] then
        return redaction_map[input_string]
    end

    -- Generate a new arbitrary name
    counter = counter + 1
    local placeholder = placeholder_names[((counter - 1) % #placeholder_names) + 1]

    -- If we've cycled through all names, add a numeric suffix
    if counter > #placeholder_names then
        local suffix = math.floor((counter - 1) / #placeholder_names)
        placeholder = placeholder .. suffix
    end

    -- Store the mapping
    redaction_map[input_string] = placeholder

    return placeholder
end

---@param selected table
---@param opts? table
---@return nil
function Variable:output(selected, opts)
    selected = selected or {}
    opts = opts or {}

    local input_string = self.target or ""
    local redacted_string = _get_redacted_string(input_string)
    local xx_string = string.format("`%s`", redacted_string)

    local id = string.format("<var>%s:%s</var>", self.config.name, input_string)

    -- Add a minimal hidden message (required for variable system)
    self.Chat:add_message({
        role = config.constants.USER_ROLE,
        content = "", -- Empty content for unambiguity, just for metadata tracking
    }, { _meta = { tag = "variable" }, context = { id = id }, visible = false })

    -- Add context tracking (displays in the UI context section, not sent in the request)
    self.Chat.context:add({
        bufnr = self.Chat.bufnr,
        id = id,
        source = "plugins.ai.codecompanion.variables.xx",
        original = input_string,
        redacted = xx_string,
        opts = {
            -- Ensures this context item is visible in the UI
            visible = true,
        },
    })

    -- Find the user message that contains the variable (not the hidden message)
    local messages = self.Chat.messages
    for i = #messages, 1, -1 do
        local msg = messages[i]
        if msg.role == config.constants.USER_ROLE and msg.opts and msg.opts.visible ~= false then
            -- This is the visible user message - replace the variable syntax
            local pattern = "#" .. "{xx:" .. vim.pesc(input_string) .. "}"
            msg.content = msg.content:gsub(pattern, xx_string)
            break
        end
    end

    -- Add `xx:` variables to the buffer, under the namespace `xx`
    local xx = vim.b.xx or {}
    xx[input_string] = function()
        return redacted_string
    end
    vim.b.xx = xx
end

return Variable
