-- tests/test_switch.lua

local minitest = require("mini.test")
local Switch = require("core.switch")
local T = minitest.new_set()

T["Switch:new() creates instance with default state"] = function()
    local counter = { on = 0, off = 0 }
    local switch = Switch:new({
        on_func = function()
            counter.on = counter.on + 1
        end,
        off_func = function()
            counter.off = counter.off + 1
        end,
    })

    if switch:get_state() ~= true then
        error("Default state should be true")
    end
end

T["Switch:new() accepts custom initial state"] = function()
    local counter = { on = 0, off = 0 }
    local switch = Switch:new({
        on_func = function()
            counter.on = counter.on + 1
        end,
        off_func = function()
            counter.off = counter.off + 1
        end,
        state = false,
    })

    if switch:get_state() ~= false then
        error("Custom initial state should be false")
    end
end

T["Switch:get_state() returns current state"] = function()
    local switch = Switch:new({
        on_func = function() end,
        off_func = function() end,
        state = true,
    })

    if switch:get_state() ~= true then
        error("get_state() should return true")
    end
end

T["Switch:switch() toggles from true to false and calls off_func"] = function()
    local counter = { on = 0, off = 0 }
    local switch = Switch:new({
        on_func = function()
            counter.on = counter.on + 1
        end,
        off_func = function()
            counter.off = counter.off + 1
        end,
        state = true,
    })

    switch:switch()

    if switch:get_state() ~= false then
        error("State should be false after switch")
    end
    if counter.off ~= 1 then
        error("off_func should be called once, got " .. counter.off)
    end
    if counter.on ~= 0 then
        error("on_func should not be called, got " .. counter.on)
    end
end

T["Switch:switch() toggles from false to true and calls on_func"] = function()
    local counter = { on = 0, off = 0 }
    local switch = Switch:new({
        on_func = function()
            counter.on = counter.on + 1
        end,
        off_func = function()
            counter.off = counter.off + 1
        end,
        state = false,
    })

    switch:switch()

    if switch:get_state() ~= true then
        error("State should be true after switch")
    end
    if counter.on ~= 1 then
        error("on_func should be called once, got " .. counter.on)
    end
    if counter.off ~= 0 then
        error("off_func should not be called, got " .. counter.off)
    end
end

T["Switch:switch() toggles multiple times correctly"] = function()
    local counter = { on = 0, off = 0 }
    local switch = Switch:new({
        on_func = function()
            counter.on = counter.on + 1
        end,
        off_func = function()
            counter.off = counter.off + 1
        end,
        state = true,
    })

    switch:switch() -- true -> false
    switch:switch() -- false -> true
    switch:switch() -- true -> false

    if switch:get_state() ~= false then
        error("State should be false after 3 switches")
    end
    if counter.off ~= 2 then
        error("off_func should be called twice, got " .. counter.off)
    end
    if counter.on ~= 1 then
        error("on_func should be called once, got " .. counter.on)
    end
end

return T
