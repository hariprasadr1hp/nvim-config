-- tests/test_cycle.lua

local minitest = require("mini.test")
local Cycle = require("core.cycle")
local T = minitest.new_set()

T["Cycle:new() creates instance with first function as state"] = function()
    local function first() end
    local function second() end
    local function third() end

    local cycle = Cycle:new({ funcs = { first, second, third } })

    if cycle:get_state() ~= first then
        error("Initial state should be the first function")
    end
end

T["Cycle:get_state() returns current state"] = function()
    local function first() end
    local function second() end

    local cycle = Cycle:new({ funcs = { first, second } })

    if cycle:get_state() ~= first then
        error("get_state() should return first function")
    end
end

T["Cycle:next() moves to next function"] = function()
    local function first() end
    local function second() end
    local function third() end

    local cycle = Cycle:new({ funcs = { first, second, third } })

    cycle:next()
    if cycle:get_state() ~= second then
        error("State should be second function after next()")
    end

    cycle:next()
    if cycle:get_state() ~= third then
        error("State should be third function after second next()")
    end
end

T["Cycle:next() wraps around to first function"] = function()
    local function first() end
    local function second() end
    local function third() end

    local cycle = Cycle:new({ funcs = { first, second, third } })

    cycle:next() -- -> second
    cycle:next() -- -> third
    cycle:next() -- -> first (wrap around)

    if cycle:get_state() ~= first then
        error("State should wrap around to first function")
    end
end

T["Cycle:prev() moves to previous function"] = function()
    local function first() end
    local function second() end
    local function third() end

    local cycle = Cycle:new({ funcs = { first, second, third } })

    cycle:next() -- -> second
    cycle:next() -- -> third
    cycle:prev() -- -> second

    if cycle:get_state() ~= second then
        error("State should be second function after prev()")
    end
end

T["Cycle:prev() wraps around to last function"] = function()
    local function first() end
    local function second() end
    local function third() end

    local cycle = Cycle:new({ funcs = { first, second, third } })

    cycle:prev() -- -> third (wrap around)

    if cycle:get_state() ~= third then
        error("State should wrap around to third function")
    end
end

T["Cycle:next() and Cycle:prev() are inverse operations"] = function()
    local function first() end
    local function second() end
    local function third() end

    local cycle = Cycle:new({ funcs = { first, second, third } })

    cycle:next() -- -> second
    cycle:next() -- -> third
    cycle:prev() -- -> second
    cycle:prev() -- -> first

    if cycle:get_state() ~= first then
        error("Should return to first function after next/prev cycles")
    end
end

T["Cycle works with two functions"] = function()
    local function first() end
    local function second() end

    local cycle = Cycle:new({ funcs = { first, second } })

    cycle:next() -- -> second
    if cycle:get_state() ~= second then
        error("Should be at second function")
    end

    cycle:next() -- -> first (wrap)
    if cycle:get_state() ~= first then
        error("Should wrap to first function")
    end

    cycle:prev() -- -> second (wrap)
    if cycle:get_state() ~= second then
        error("Should wrap backwards to second function")
    end
end

T["Cycle:next() returns the new state"] = function()
    local function first() end
    local function second() end

    local cycle = Cycle:new({ funcs = { first, second } })

    local result = cycle:next()
    if result ~= second then
        error("next() should return the new state")
    end
end

T["Cycle:prev() returns the new state"] = function()
    local function first() end
    local function second() end
    local function third() end

    local cycle = Cycle:new({ funcs = { first, second, third } })

    local result = cycle:prev()
    if result ~= third then
        error("prev() should return the new state")
    end
end

return T
