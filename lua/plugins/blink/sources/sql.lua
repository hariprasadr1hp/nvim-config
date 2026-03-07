-- lua/blink/sources/sql.lua

local M = {}
M.__index = M

local types = require("blink.cmp.types")
local kind_keyword = types.CompletionItemKind.Keyword
local kind_function = types.CompletionItemKind.Function
local kind_snippet = types.CompletionItemKind.Snippet

local PLAIN = 1
local SNIPPET = 2

-- { label, alias, kind, insertText, [insertTextFormat], [doc] }
local keywords = {
    -- Joins
    {
        "left join",
        "lj",
        kind_keyword,
        "left join $1 on $2",
        SNIPPET,
        "Left outer join — includes all rows from the left table",
    },
    {
        "right join",
        "rj",
        kind_keyword,
        "right join $1 on $2",
        SNIPPET,
        "Right outer join — includes all rows from the right table",
    },
    {
        "inner join",
        "ij",
        kind_keyword,
        "inner join $1 on $2",
        SNIPPET,
        "Inner join — only matching rows from both tables",
    },
    {
        "full outer join",
        "foj",
        kind_keyword,
        "full outer join $1 on $2",
        SNIPPET,
        "Full outer join — all rows from both tables",
    },
    { "cross join", "cj", kind_keyword, "cross join $1", SNIPPET, "Cartesian product of both tables" },

    -- Clauses
    { "group by", "gb", kind_keyword, "group by $1", SNIPPET },
    { "order by", "ob", kind_keyword, "order by $1", SNIPPET },
    { "partition by", "pb", kind_keyword, "over (partition by $1)", SNIPPET },
    { "having", "hv", kind_keyword, "having", PLAIN },
    { "where", "wh", kind_keyword, "where", PLAIN },
    { "limit", "lm", kind_keyword, "limit $1", SNIPPET },
    { "offset", "of", kind_keyword, "offset $1", SNIPPET },

    -- Set operations
    { "union all", "ua", kind_keyword, "union all", PLAIN, "Combines results of two queries, keeping duplicates" },
    { "union", "un", kind_keyword, "union", PLAIN, "Combines results of two queries, removing duplicates" },
    { "intersect", "ix", kind_keyword, "intersect", PLAIN },
    { "except", "ex", kind_keyword, "except", PLAIN },
    { "distinct", "dst", kind_keyword, "distinct ($1)", SNIPPET },

    -- CASE expression
    { "case when", "cw", kind_snippet, "case when $1 then $2 else $3 end", SNIPPET, "Conditional CASE expression" },

    -- DML templates
    { "insert into", "ins", kind_snippet, "insert into ${1:table} (${2:cols}) values (${3:vals})", SNIPPET },
    { "update set", "upd", kind_snippet, "update ${1:table} set ${2:col} = ${3:val} where ${4:cond}", SNIPPET },
    { "delete from", "del", kind_snippet, "delete from ${1:table} where ${2:cond}", SNIPPET },
    { "create table as", "ctas", kind_snippet, "create table ${1:table} as\n$2", SNIPPET },

    -- Window functions
    {
        "row_number() over",
        "rn",
        kind_function,
        "row_number() over (partition by $1 order by $2)",
        SNIPPET,
        "Assigns sequential row numbers within a partition",
    },
    { "rank() over", "rank", kind_function, "rank() over (partition by $1 order by $2)", SNIPPET },
    { "dense_rank() over", "drank", kind_function, "dense_rank() over (partition by $1 order by $2)", SNIPPET },
    { "lag() over", "lag", kind_function, "lag($1, $2) over (partition by $3 order by $4)", SNIPPET },
    { "lead() over", "lead", kind_function, "lead($1, $2) over (partition by $3 order by $4)", SNIPPET },
    { "sum() over", "sumov", kind_function, "sum($1) over (partition by $2 order by $3)", SNIPPET },
    { "avg() over", "avgov", kind_function, "avg($1) over (partition by $2 order by $3)", SNIPPET },
    { "min() over", "minov", kind_function, "min($1) over (partition by $2 order by $3)", SNIPPET },
    { "max() over", "maxov", kind_function, "max($1) over (partition by $2 order by $3)", SNIPPET },
    { "count() over", "cntov", kind_function, "count($1) over (partition by $2 order by $3)", SNIPPET },
    {
        "first_value() over",
        "fval",
        kind_function,
        "first_value($1) over (partition by $2 order by $3)",
        SNIPPET,
        "First value in the window frame",
    },
    {
        "last_value() over",
        "lval",
        kind_function,
        "last_value($1) over (partition by $2 order by $3 rows between unbounded preceding and unbounded following)",
        SNIPPET,
        "Last value in the window frame — needs explicit frame clause",
    },
    {
        "nth_value() over",
        "nthval",
        kind_function,
        "nth_value($1, $2) over (partition by $3 order by $4)",
        SNIPPET,
        "Nth value in the window frame",
    },
    {
        "ntile() over",
        "ntile",
        kind_function,
        "ntile($1) over (partition by $2 order by $3)",
        SNIPPET,
        "Divide rows into N ranked buckets",
    },
    {
        "percent_rank() over",
        "prank",
        kind_function,
        "percent_rank() over (partition by $1 order by $2)",
        SNIPPET,
        "Relative rank as a fraction between 0 and 1",
    },
    {
        "cume_dist() over",
        "cdist",
        kind_function,
        "cume_dist() over (partition by $1 order by $2)",
        SNIPPET,
        "Cumulative distribution: fraction of rows <= current",
    },
    {
        "rows between",
        "rowsb",
        kind_snippet,
        "rows between ${1:unbounded preceding} and ${2:current row}",
        SNIPPET,
        "Explicit window frame clause",
    },

    -- Aggregate functions
    { "count(*)", "cnt", kind_function, "count(*)", PLAIN },
    { "count(distinct)", "cntd", kind_function, "count(distinct $1)", SNIPPET },
    { "extract()", "ext", kind_function, "extract($1 from $2)", SNIPPET },
}

function M.new()
    return setmetatable({}, M)
end

function M:get_completions(_, callback)
    local items = {}
    for _, kw in ipairs(keywords) do
        local label, alias, kind, insert_text, fmt, doc = kw[1], kw[2], kw[3], kw[4], kw[5], kw[6]
        table.insert(items, {
            label = alias,
            kind = kind,
            insertText = insert_text,
            insertTextFormat = fmt,
            filterText = alias .. " " .. label, -- fuzzy match on both
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
