--- lua/core/cycle.lua
--- A class for cycling through a list of functions.

local Cycle = {}

Cycle.items = {}

--- Create a new Cycle instance.
---@param args { funcs: function[] }
---@return table
function Cycle:new(args)
    args = args or {}
    local defaults = {
        state = args.funcs[1],
    }
    local init = vim.tbl_extend("force", {}, defaults, args)
    return setmetatable(init, { __index = Cycle })
end

--- Get the current state (function).
---@return function
function Cycle:get_state()
    return self.state
end

--- Cycle to the next function in the list.
--- Wraps around to the first function after the last.
---@return function
function Cycle:next()
    for i, func in ipairs(self.funcs) do
        if func == self.state then
            self.state = self.funcs[(i % #self.funcs) + 1]
            return self.state
        end
    end
    return self.state
end

--- Cycle to the previous function in the list.
--- Wraps around to the last function before the first.
---@return function
function Cycle:prev()
    for i, func in ipairs(self.funcs) do
        if func == self.state then
            local prev_index = (i - 2) % #self.funcs + 1
            self.state = self.funcs[prev_index]
            return self.state
        end
    end
    return self.state
end

local function first()
    print("first")
end

local function second()
    print("second")
end

local function third()
    print("third")
end

return Cycle
