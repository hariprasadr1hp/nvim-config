-- lua/config/tablex.lua
--
-- A small extended table/sequence utility module for Lua & Neovim.
-- Supplements Lua's standard library and vim.tbl_* with common helpers:
-- - Splitting strings
-- - Sorted copies
-- - Uniqueness filtering
-- - any/all predicates
-- - Grouping, zipping, enumerating
-- - List slicing & flattening
--
-- All functions operate on array-like tables (lists) and avoid mutating inputs.
-- Suitable for use in Neovim config and plugin development.

local M = {}

--- Split a string into a list, similar to Python's `str.split`.
---
--- - If `sep` is empty (`""`), the string is split into individual characters.
--- - If `sep` is omitted, `"\n"` is used.
--- - Empty fields are not preserved (simple pattern-based split).
---
--- @param content string  String to split.
--- @param sep? string     Separator to split on, default: "\n".
--- @return string[]       Array of split parts.
function M.split(content, sep)
    if sep == "" then
        local t = {}
        for i = 1, #content do
            t[#t + 1] = content:sub(i, i)
        end
        return t
    end

    sep = sep or "\n"
    local t = {}
    local pattern = "([^" .. sep .. "]+)"

    for s in content:gmatch(pattern) do
        t[#t + 1] = s
    end
    return t
end

--- Return a sorted copy of a list without mutating the original.
--- Equivalent to Python's `sorted(values)`.
---
--- @generic T
--- @param values T[]                     Input list.
--- @param cmp? fun(a: T, b: T): boolean  Optional comparator for table.sort.
--- @return T[]                           New sorted list.
function M.sorted(values, cmp)
    local new = {}
    for i = 1, #values do
        new[i] = values[i]
    end
    table.sort(new, cmp)
    return new
end

--- Return a list with duplicate values removed, preserving first-seen order.
---
--- @generic T
--- @param t T[]     Input list.
--- @return T[]      Unique values.
function M.unique(t)
    local seen = {}
    local out = {}
    for _, v in ipairs(t) do
        if not seen[v] then
            seen[v] = true
            out[#out + 1] = v
        end
    end
    return out
end

--- Return true if *any* element of the list satisfies `pred`.
--- Equivalent to Python's `any(pred(x) for x in list)`.
---
--- @generic T
--- @param t T[]               Input list.
--- @param pred fun(v: T): boolean
--- @return boolean
function M.any(t, pred)
    for _, v in ipairs(t) do
        if pred(v) then
            return true
        end
    end
    return false
end

--- Return true if *all* list elements satisfy `pred`.
--- Equivalent to Python's `all(...)`.
---
--- @generic T
--- @param t T[]
--- @param pred fun(v: T): boolean
--- @return boolean
function M.all(t, pred)
    for _, v in ipairs(t) do
        if not pred(v) then
            return false
        end
    end
    return true
end

--- Group list values by keys returned from `key_fn`.
---
--- Example:
--- ```lua
--- group_by({"a","bb","c"}, function(s) return #s end)
--- -- { [1] = {"a","c"}, [2] = {"bb"} }
--- ```
---
--- @generic T, K
--- @param t T[]                   Input list.
--- @param key_fn fun(v: T): K     Computes group key.
--- @return table<K, T[]>          Map of groups.
function M.group_by(t, key_fn)
    local groups = {}
    for _, v in ipairs(t) do
        local k = key_fn(v)
        local g = groups[k]
        if not g then
            g = {}
            groups[k] = g
        end
        g[#g + 1] = v
    end
    return groups
end

--- Shallow copy of a list (1-based array).
---
--- @generic T
--- @param t T[]
--- @return T[]
function M.copy(t)
    local out = {}
    for i = 1, #t do
        out[i] = t[i]
    end
    return out
end

--- Flatten a nested list structure recursively.
--- Non-table values are collected as-is.
---
--- @generic T
--- @param t table     Nested list (array-like).
--- @return T[]        Flattened list.
function M.flatten(t)
    local out = {}
    local function rec(sub)
        for _, v in ipairs(sub) do
            if type(v) == "table" then
                rec(v)
            else
                out[#out + 1] = v
            end
        end
    end
    rec(t)
    return out
end

--- Slice a list, similar to Python's `list[start:stop:step]`.
---
--- @generic T
--- @param t T[]           Input list.
--- @param first? integer  Starting index (default: 1)
--- @param last? integer   Ending index inclusive (default: #t)
--- @param step? integer   Step increment (default: 1). Supports negative.
--- @return T[]
function M.slice(t, first, last, step)
    local out = {}
    local n = #t
    first = first or 1
    last = last or n
    step = step or 1

    for i = first, last, step do
        out[#out + 1] = t[i]
    end
    return out
end

--- Enumerate list values, returning `{ index = i, value = v }` entries.
--- Equivalent to Python's `enumerate(list)`.
---
--- @generic T
--- @param t T[]
--- @return { index: integer, value: T }[]
function M.tbl_enumerate(t)
    local out = {}
    for i, v in ipairs(t) do
        out[#out + 1] = { index = i, value = v }
    end
    return out
end

--- Zip two lists together into pairs.
--- Stops at the shorter list length.
---
--- @generic A, B
--- @param a A[]
--- @param b B[]
--- @return { [1]: A, [2]: B }[]
function M.tbl_zip(a, b)
    local out = {}
    local n = math.min(#a, #b)
    for i = 1, n do
        out[#out + 1] = { a[i], b[i] }
    end
    return out
end

return M
