-- lua/plugins/blink/sources/jinja.lua

local M = {}
M.__index = M

local types = require("blink.cmp.types")
local kind_keyword = types.CompletionItemKind.Keyword
local kind_function = types.CompletionItemKind.Function
local kind_snippet = types.CompletionItemKind.Snippet

local PLAIN = 1
local SNIPPET = 2

-- { label, alias, kind, insertText, [insertTextFormat], [doc] }
local items_data = {
    -- Block tags
    { "{% if %}", "if", kind_snippet, "{% if $1 %}\n    $2\n{% endif %}", SNIPPET, "Conditional block" },
    { "{% if/else %}", "ife", kind_snippet, "{% if $1 %}\n    $2\n{% else %}\n    $3\n{% endif %}", SNIPPET, "Conditional with else branch" },
    { "{% elif %}", "elif", kind_keyword, "{% elif $1 %}", SNIPPET },
    { "{% else %}", "else", kind_keyword, "{% else %}", PLAIN },
    { "{% for %}", "for", kind_snippet, "{% for ${1:item} in ${2:items} %}\n    $3\n{% endfor %}", SNIPPET, "Loop over a sequence" },
    { "{% for/else %}", "fore", kind_snippet, "{% for ${1:item} in ${2:items} %}\n    $3\n{% else %}\n    $4\n{% endfor %}", SNIPPET, "Loop with empty-sequence fallback" },
    { "{% block %}", "block", kind_snippet, "{% block $1 %}\n    $2\n{% endblock %}", SNIPPET, "Named block for template inheritance" },
    { "{% extends %}", "ext", kind_snippet, '{% extends "$1" %}', SNIPPET, "Inherit from a parent template" },
    { "{% include %}", "inc", kind_snippet, '{% include "$1" %}', SNIPPET, "Include another template" },
    { "{% macro %}", "macro", kind_snippet, "{% macro ${1:name}(${2:args}) %}\n    $3\n{% endmacro %}", SNIPPET, "Define a reusable macro" },
    { "{% call %}", "call", kind_snippet, "{% call ${1:macro}($2) %}\n    $3\n{% endcall %}", SNIPPET, "Call a macro with a caller block" },
    { "{% set %}", "set", kind_snippet, "{% set ${1:var} = $2 %}", SNIPPET, "Assign a variable" },
    { "{% set block %}", "setb", kind_snippet, "{% set ${1:var} %}\n    $2\n{% endset %}", SNIPPET, "Capture a block of content into a variable" },
    { "{% filter %}", "filtb", kind_snippet, "{% filter ${1:filter} %}\n    $2\n{% endfilter %}", SNIPPET, "Apply a filter to a block of content" },
    { "{% with %}", "with", kind_snippet, "{% with ${1:var} = $2 %}\n    $3\n{% endwith %}", SNIPPET, "Scoped variable assignment" },
    { "{% from import %}", "from", kind_snippet, '{% from "$1" import $2 %}', SNIPPET, "Import macros from another template" },
    { "{% import %}", "imp", kind_snippet, '{% import "$1" as $2 %}', SNIPPET, "Import a template as a module" },
    { "{% raw %}", "raw", kind_snippet, "{% raw %}\n    $1\n{% endraw %}", SNIPPET, "Output raw text, bypassing template engine" },
    { "{# comment #}", "cmt", kind_snippet, "{# $1 #}", SNIPPET, "Jinja comment — not rendered in output" },

    -- Expressions
    { "{{ expr }}", "var", kind_snippet, "{{ $1 }}", SNIPPET, "Output a variable or expression" },
    { "{{ expr | filter }}", "varf", kind_snippet, "{{ $1 | $2 }}", SNIPPET, "Output a variable with a filter applied" },

    -- Filters
    { "| lower", "lower", kind_function, "| lower", PLAIN, "Convert to lowercase" },
    { "| upper", "upper", kind_function, "| upper", PLAIN, "Convert to uppercase" },
    { "| title", "title", kind_function, "| title", PLAIN, "Title-case the string" },
    { "| capitalize", "cap", kind_function, "| capitalize", PLAIN, "Capitalize first character only" },
    { "| trim", "trim", kind_function, "| trim", PLAIN, "Strip leading/trailing whitespace" },
    { "| default()", "def", kind_function, "| default($1)", SNIPPET, "Use a fallback value when undefined or falsy" },
    { "| replace()", "rep", kind_function, '| replace("$1", "$2")', SNIPPET, "Replace all occurrences of a substring" },
    { "| join()", "join", kind_function, '| join("$1")', SNIPPET, "Join a list into a string with a separator" },
    { "| length", "len", kind_function, "| length", PLAIN, "Get length of a sequence or string" },
    { "| first", "first", kind_function, "| first", PLAIN, "Get the first item of a sequence" },
    { "| last", "last", kind_function, "| last", PLAIN, "Get the last item of a sequence" },
    { "| sort", "sort", kind_function, "| sort", PLAIN, "Sort a sequence" },
    { "| unique", "uniq", kind_function, "| unique", PLAIN, "Remove duplicates from a sequence" },
    { "| reverse", "rev", kind_function, "| reverse", PLAIN, "Reverse a sequence or string" },
    { "| list", "list", kind_function, "| list", PLAIN, "Convert to a list" },
    { "| int", "int", kind_function, "| int", PLAIN, "Convert to integer" },
    { "| float", "float", kind_function, "| float", PLAIN, "Convert to float" },
    { "| string", "str", kind_function, "| string", PLAIN, "Convert to string" },
    { "| abs", "abs", kind_function, "| abs", PLAIN, "Absolute value of a number" },
    { "| round()", "round", kind_function, "| round($1)", SNIPPET, "Round a number to N decimal places" },
    { "| tojson", "tojson", kind_function, "| tojson", PLAIN, "Serialize to a JSON string" },
    { "| escape", "esc", kind_function, "| escape", PLAIN, "HTML-escape a string" },
    { "| safe", "safe", kind_function, "| safe", PLAIN, "Mark as safe — disable auto-escaping" },
    { "| truncate()", "trunc", kind_function, "| truncate($1)", SNIPPET, "Truncate a string to N characters" },
    { "| wordcount", "wc", kind_function, "| wordcount", PLAIN, "Count words in a string" },
    { "| indent()", "indent", kind_function, "| indent($1)", SNIPPET, "Indent each line of a string by N spaces" },
    { "| groupby()", "grpby", kind_function, '| groupby("$1")', SNIPPET, "Group a sequence of dicts by an attribute" },
    { "| selectattr()", "sela", kind_function, '| selectattr("$1", "$2", $3)', SNIPPET, "Filter objects by attribute test" },
    { "| rejectattr()", "reja", kind_function, '| rejectattr("$1", "$2", $3)', SNIPPET, "Remove objects matching attribute test" },
    { "| map()", "map", kind_function, '| map(attribute="$1")', SNIPPET, "Extract an attribute or apply filter to each item" },
    { "| select()", "sel", kind_function, '| select("$1")', SNIPPET, "Keep items passing a test" },
    { "| reject()", "rej", kind_function, '| reject("$1")', SNIPPET, "Remove items passing a test" },
    { "| items", "items", kind_function, "| items", PLAIN, "Iterate over dict as (key, value) pairs" },
    { "| keys", "keys", kind_function, "| keys", PLAIN, "Get dict keys" },
    { "| values", "vals", kind_function, "| values", PLAIN, "Get dict values" },
    { "| dictsort", "dsort", kind_function, "| dictsort", PLAIN, "Sort a dict by key" },
    { "| urlencode", "urle", kind_function, "| urlencode", PLAIN, "Percent-encode a string for use in URLs" },
    { "| batch()", "batch", kind_function, "| batch($1)", SNIPPET, "Batch a sequence into chunks of N items" },
    { "| slice()", "slice", kind_function, "| slice($1)", SNIPPET, "Slice a sequence into N roughly-equal chunks" },
    { "| format()", "fmt", kind_function, "| format($1)", SNIPPET, "Apply Python-style % string formatting" },

    -- Loop variables
    { "loop.index", "lidx", kind_keyword, "loop.index", PLAIN, "Current iteration count (1-indexed)" },
    { "loop.index0", "lidx0", kind_keyword, "loop.index0", PLAIN, "Current iteration count (0-indexed)" },
    { "loop.revindex", "lridx", kind_keyword, "loop.revindex", PLAIN, "Iterations remaining, including current (1-indexed)" },
    { "loop.revindex0", "lridx0", kind_keyword, "loop.revindex0", PLAIN, "Iterations remaining, including current (0-indexed)" },
    { "loop.first", "lfirst", kind_keyword, "loop.first", PLAIN, "True on the first iteration" },
    { "loop.last", "llast", kind_keyword, "loop.last", PLAIN, "True on the last iteration" },
    { "loop.length", "llen", kind_keyword, "loop.length", PLAIN, "Total number of items in the loop" },
    { "loop.depth", "ldepth", kind_keyword, "loop.depth", PLAIN, "Nesting depth of a recursive loop (1-indexed)" },
    { "loop.depth0", "ldepth0", kind_keyword, "loop.depth0", PLAIN, "Nesting depth of a recursive loop (0-indexed)" },
    { "loop.changed()", "lchg", kind_function, "loop.changed($1)", SNIPPET, "True if the value changed since the last iteration" },
    { "loop.cycle()", "lcyc", kind_function, "loop.cycle($1)", SNIPPET, "Cycle through a sequence of values each iteration" },
}

function M.new()
    return setmetatable({}, M)
end

function M:get_completions(_, callback)
    local items = {}
    for _, kw in ipairs(items_data) do
        local label, alias, kind, insert_text, fmt, doc = kw[1], kw[2], kw[3], kw[4], kw[5], kw[6]
        table.insert(items, {
            label = alias,
            kind = kind,
            insertText = insert_text,
            insertTextFormat = fmt,
            filterText = alias .. " " .. label,
            labelDetails = { description = label },
            documentation = doc and { kind = "plaintext", value = doc } or nil,
        })
    end
    callback({
        is_incomplete_forward = false,
        is_incomplete_backward = false,
        items = items,
    })
end

return M
