--- switch.lua
--- A class for toggling between two states with associated callbacks.

local Switch = {}

Switch.items = {}

--- Create a new Switch instance.
---@param args { on_func: function, off_func: function, state?: boolean }
---@return table
function Switch:new(args)
    args = args or {}
    local init = {
        state = (args.state == nil) and true or args.state,
        on_func = args.on_func,
        off_func = args.off_func,
    }
    return setmetatable(init, { __index = Switch })
end

--- Get the current state.
---@return boolean
function Switch:get_state()
    return self.state
end

--- Toggle the switch state and execute the corresponding callback.
--- Toggles to the new state, then calls on_func if now true, or off_func if now false.
function Switch:switch()
    self.state = not self.state
    if self.state then
        self.on_func()
    else
        self.off_func()
    end
end

return Switch
