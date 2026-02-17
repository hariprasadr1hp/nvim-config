-- lua/core/switch.lua

local Switch = {}

Switch.items = {}

function Switch:new(args)
    args = args or {}
    local defaults = {
        state = true,
    }
    local init = vim.tbl_extend("force", {}, defaults, args)
    return setmetatable(init, { __index = Switch })
end

function Switch:get_state()
    return self.state
end

function Switch:switch()
    if self.state then
        self.on_func()
    else
        self.off_func()
    end
    self.state = not self.state
end

return Switch
