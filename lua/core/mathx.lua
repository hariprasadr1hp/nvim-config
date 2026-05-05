--- lua/core/mathx.lua
--- Extensions to the built-in math module.

local M = {}

--- Add two numbers.
---@param a number
---@param b number
---@return number
function M.add(a, b)
    return a + b
end

--- Subtract b from a.
---@param a number
---@param b number
---@return number
function M.sub(a, b)
    return a - b
end

--- Multiply two numbers.
---@param a number
---@param b number
---@return number
function M.mul(a, b)
    return a * b
end

--- Divide a by b.
---@param a number
---@param b number
---@return number
function M.div(a, b)
    return a / b
end

--- Modulo (remainder of a / b).
---@param a number
---@param b number
---@return number
function M.mod(a, b)
    return a % b
end

--- Sign of x.
--- Returns 1 for x>0, -1 for x<0, 0 for x==0.
---@param x number
---@return number
function M.sign(x)
    if x > 0 then
        return 1
    elseif x < 0 then
        return -1
    else
        return 0
    end
end

--- Fractional part of x.
---@param x number
---@return number
function M.fract(x)
    return x - math.floor(x)
end

--- Clamp x to the range [min, max].
---@param x number
---@param min number
---@param max number
---@return number
function M.clamp(x, min, max)
    if x < min then
        return min
    elseif x > max then
        return max
    else
        return x
    end
end

--- Clamp x to [0, 1].
---@param x number
---@return number
function M.clamp01(x)
    return M.clamp(x, 0, 1)
end

--- Linear interpolation between a and b.
--- Equivalent to: a + (b - a) * t
---@param a number
---@param b number
---@param t number  -- usually between 0 and 1
---@return number
function M.lerp(a, b, t)
    return a + (b - a) * t
end

--- Inverse linear interpolation.
--- Given x between a and b, returns t in [0,1].
---@param a number
---@param b number
---@param x number
---@return number
function M.inv_lerp(a, b, x)
    return (x - a) / (b - a)
end

--- Remap x from range [a1, b1] to [a2, b2].
---@param x number
---@param a1 number
---@param b1 number
---@param a2 number
---@param b2 number
---@return number
function M.remap(x, a1, b1, a2, b2)
    return a2 + (b2 - a2) * ((x - a1) / (b1 - a1))
end

--- Smoothstep interpolation between edge0 and edge1.
--- Returns 0 below edge0, 1 above edge1, and smooth in-between.
---@param edge0 number
---@param edge1 number
---@param x number
---@return number
function M.smoothstep(edge0, edge1, x)
    local t = M.clamp((x - edge0) / (edge1 - edge0), 0, 1)
    return t * t * (3 - 2 * t)
end

--- Round to nearest integer (handles negatives sensibly).
---@param x number
---@return number
function M.round(x)
    if x >= 0 then
        return math.floor(x + 0.5)
    else
        return math.ceil(x - 0.5)
    end
end

--- Round to n decimal places.
---@param x number
---@param decimals integer
---@return number
function M.roundn(x, decimals)
    local m = 10 ^ decimals
    return M.round(x * m) / m
end

--- Check if two floats are approximately equal.
---@param a number
---@param b number
---@param eps number|nil
---@return boolean
function M.approx(a, b, eps)
    eps = eps or 1e-9
    return math.abs(a - b) < eps
end

--- Wrap x into [min, max).
---@param x number
---@param min number
---@param max number
---@return number
function M.wrap(x, min, max)
    local range = max - min
    if range == 0 then
        return min
    end
    x = (x - min) % range
    if x < 0 then
        x = x + range
    end
    return x + min
end

-- Fold the values from left to right, based on the combining function and the accumulator
---@generic T, A
---@param func fun(acc: A, item: T): A
---@param acc A
---@param values T[]
---@return A
function M.reduce(func, acc, values)
    for i = 1, #values do
        acc = func(acc, values[i])
    end
    return acc
end

return M
