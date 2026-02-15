-- tests/test_redact.lua

local minitest = require("mini.test")
local new_set = minitest.new_set
local expect = minitest.expect

local T = new_set()

local function setup()
    package.loaded["core.redact"] = nil
    local Redact = require("core.redact")
    Redact.clear_all()
    return Redact
end

T["redact()"] = new_set()

T["redact()"]["basic redaction works"] = function()
    local Redact = setup()
    Redact:new({ value = "secret" })

    local content = "This is a secret message"
    local redacted = Redact.redact(content)

    expect.equality(redacted, "This is a ****** message")
end

T["redact()"]["multiple values"] = function()
    local Redact = setup()
    Redact:new({ value = "hello" })
    Redact:new({ value = "world" })

    local content = "hello world"
    local redacted = Redact.redact(content)

    expect.equality(redacted, "***** *****")
end

T["redact()"]["custom mask function"] = function()
    local Redact = setup()
    Redact:new({
        value = "test",
        mask_func = function(_)
            return "REDACTED"
        end,
    })

    local content = "This is a test"
    local redacted = Redact.redact(content)

    expect.equality(redacted, "This is a REDACTED")
end

T["redact()"]["handles special pattern characters"] = function()
    local Redact = setup()
    Redact:new({ value = "test.value" })
    Redact:new({ value = "test(1)" })
    Redact:new({ value = "test[a]" })

    local content = "test.value and test(1) and test[a]"
    local redacted = Redact.redact(content)

    expect.equality(redacted, "********** and ******* and *******")
end

T["unredact()"] = new_set()

T["unredact()"]["basic unredaction works"] = function()
    local Redact = setup()
    Redact:new({ value = "secret" })

    local content = "This is a secret message"
    local redacted = Redact.redact(content)
    local unredacted = Redact.unredact(redacted)

    expect.equality(unredacted, content)
end

T["unredact()"]["multiple values"] = function()
    local Redact = setup()
    Redact:new({ value = "apple" })
    Redact:new({ value = "orange" })

    local content = "apple and orange"
    local redacted = Redact.redact(content)
    local unredacted = Redact.unredact(redacted)

    expect.equality(unredacted, content)
end

T["unredact()"]["handles percent signs in value"] = function()
    local Redact = setup()
    Redact:new({ value = "100%" })

    local content = "I am 100% sure"
    local redacted = Redact.redact(content)
    local unredacted = Redact.unredact(redacted)

    expect.equality(unredacted, content)
end

T["unredact()"]["handles special characters in masked value"] = function()
    local Redact = setup()
    Redact:new({
        value = "test",
        mask_func = function(v)
            return "[REDACTED]"
        end,
    })

    local content = "This is a test"
    local redacted = Redact.redact(content)
    local unredacted = Redact.unredact(redacted)

    expect.equality(unredacted, content)
end

T["redact_lines()"] = new_set()

T["redact_lines()"]["redacts multiple lines"] = function()
    local Redact = setup()
    Redact:new({ value = "secret" })

    local lines = {
        "This is a secret",
        "Another secret here",
        "No matches here",
    }

    local redacted = Redact.redact_lines(lines)

    expect.equality(redacted[1], "This is a ******")
    expect.equality(redacted[2], "Another ****** here")
    expect.equality(redacted[3], "No matches here")
end

T["unredact_lines()"] = new_set()

T["unredact_lines()"]["unredacts multiple lines"] = function()
    local Redact = setup()
    Redact:new({ value = "secret" })

    local lines = {
        "This is a secret",
        "Another secret here",
    }

    local redacted = Redact.redact_lines(lines)
    local unredacted = Redact.unredact_lines(redacted)

    expect.equality(unredacted[1], lines[1])
    expect.equality(unredacted[2], lines[2])
end

T["new()"] = new_set()

T["new()"]["creates instance with default mask"] = function()
    local Redact = setup()
    local instance = Redact:new({ value = "test" })

    expect.equality(instance.value, "test")
    expect.equality(type(instance.mask_func), "function")
end

T["new()"]["creates instance with custom mask"] = function()
    local Redact = setup()
    local custom_mask = function(v)
        return "XXX"
    end
    local instance = Redact:new({ value = "test", mask_func = custom_mask })

    expect.equality(instance.mask_func, custom_mask)
end

T["new()"]["errors on empty value"] = function()
    local Redact = setup()

    expect.error(function()
        Redact:new({ value = "" })
    end, "value cannot be empty")
end

T["new()"]["errors on nil value"] = function()
    local Redact = setup()

    expect.error(function()
        Redact:new({})
    end, "value cannot be empty")
end

T["update_mask_func()"] = new_set()

T["update_mask_func()"]["updates mask function"] = function()
    local Redact = setup()
    local instance = Redact:new({ value = "test" })

    local new_mask = function(v)
        return "UPDATED"
    end
    instance:update_mask_func(new_mask)

    local content = "This is a test"
    local redacted = Redact.redact(content)

    expect.equality(redacted, "This is a UPDATED")
end

T["update_mask_func()"]["returns self for chaining"] = function()
    local Redact = setup()
    local instance = Redact:new({ value = "test" })

    local result = instance:update_mask_func(function(v)
        return "NEW"
    end)

    expect.equality(result, instance)
end

T["remove()"] = new_set()

T["remove()"]["removes redaction rule"] = function()
    local Redact = setup()
    local instance = Redact:new({ value = "secret" })

    local content = "This is a secret"
    local redacted_before = Redact.redact(content)
    expect.equality(redacted_before, "This is a ******")

    instance:remove()

    local redacted_after = Redact.redact(content)
    expect.equality(redacted_after, "This is a secret")
end

T["remove()"]["returns self for chaining"] = function()
    local Redact = setup()
    local instance = Redact:new({ value = "test" })

    local result = instance:remove()

    expect.equality(result, instance)
end

T["clear_all()"] = new_set()

T["clear_all()"]["clears all redaction rules"] = function()
    local Redact = setup()
    Redact:new({ value = "secret1" })
    Redact:new({ value = "secret2" })
    Redact:new({ value = "secret3" })

    local content = "secret1 secret2 secret3"
    local redacted_before = Redact.redact(content)
    expect.equality(redacted_before, "******* ******* *******")

    Redact.clear_all()

    local redacted_after = Redact.redact(content)
    expect.equality(redacted_after, "secret1 secret2 secret3")
end

T["edge cases"] = new_set()

T["edge cases"]["empty string"] = function()
    local Redact = setup()
    Redact:new({ value = "test" })

    local content = ""
    local redacted = Redact.redact(content)

    expect.equality(redacted, "")
end

T["edge cases"]["no matching values"] = function()
    local Redact = setup()
    Redact:new({ value = "secret" })

    local content = "This has no matches"
    local redacted = Redact.redact(content)

    expect.equality(redacted, "This has no matches")
end

T["edge cases"]["value appears multiple times"] = function()
    local Redact = setup()
    Redact:new({ value = "test" })

    local content = "test test test"
    local redacted = Redact.redact(content)

    expect.equality(redacted, "**** **** ****")
end

T["edge cases"]["overlapping patterns"] = function()
    local Redact = setup()
    Redact:new({ value = "abc" })
    Redact:new({ value = "abcd" })

    local content = "abcd"
    local redacted = Redact.redact(content)

    -- Either all 4 chars masked or 3 chars + 'd' depending on order
    -- We just verify it contains asterisks
    local has_asterisks = redacted:match("%*") ~= nil
    if not has_asterisks then
        error("Expected redacted string to contain asterisks, got: " .. redacted)
    end
end

return T
