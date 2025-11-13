-- lua/plugins/custom/extract/ts_extract.lua

local ts = require("vim.treesitter")
local tsq = require("vim.treesitter").query

---@class TSCaptureOpts
---@field bufnr? integer                 # Buffer number; defaults to 0 (current).
---@field lang string                    # Treesitter language, e.g. "hurl".
---@field query_name? string             # Name under queries/<lang>/<name>.scm (ignored if query_string is set).
---@field query_string? string           # Inline query source; takes precedence over query_name.
---@field capture_names string | string[]        # Capture(s) to collect, e.g. "variables" or { "variables", "templates" }.
---@field start_row? integer             # Start row (0-based, inclusive). Default 0.
---@field end_row? integer               # End row (0-based, exclusive). Default -1 (until EOF).

---@alias TSGroupedMatch table<string, string[]>  -- capture_name -> list of texts for this match
---@alias TSGroupedMatches TSGroupedMatch[]       -- array of per-match buckets

local M = {}

--- Safely get a Treesitter parser for a buffer and language.
--- Returns either a parser or an error message (for logging).
---@param bufnr? integer
---@param lang string
---@return vim.treesitter.LanguageTree|nil parser
---@return string|nil err
local function get_parser(bufnr, lang)
    bufnr = bufnr or 0
    local ok, parser_or_err = pcall(ts.get_parser, bufnr, lang)
    if not ok or not parser_or_err then
        return nil, ("TS parser error for %s: %s"):format(lang, tostring(parser_or_err))
    end
    return parser_or_err, nil
end

--- Resolve a Query object from either an inline string or a named query file.
--- If `query_string` is provided, it takes precedence over `query_name`.
---@param lang string
---@param query_name? string
---@param query_string? string
---@return table|nil query
local function resolve_query(lang, query_name, query_string)
    if query_string and query_string ~= "" then
        local ok, qry = pcall(tsq.parse, lang, query_string)
        if ok then
            return qry
        end
        vim.notify(("Query parse error: %s"):format(qry), vim.log.levels.ERROR)
        return nil
    end
    local ok, qry = pcall(tsq.get, lang, query_name)
    if ok and qry then
        return qry
    end
    vim.notify(("Failed to load query %q for %s"):format(tostring(query_name), lang), vim.log.levels.ERROR)
    return nil
end

--- Capture grouped matches for the requested capture names.
--- Each returned element is a "bucket" for one match:
---  output_ex: { variables = {...}, templates = {...}, ... }
---
--- `opts` example:
--- ```lua
--- opts = {
---   bufnr = 0,                      -- default current buf
---   lang = "hurl",                  -- required
---   query_name = "variables",       -- optional if query_string is set
---   query_string = nil,             -- optional raw query source
---   capture = "variables",          -- which @-name to capture
---   start_row = 0, end_row = -1,    -- range; -1 = end of buffer
---   unique = true,                  -- dedupe results
---   sorted = true,                  -- sort ascending
--- }
--- ```
---@param opts TSCaptureOpts
---@return TSGroupedMatches
function M.get_matches(opts)
    opts = opts or {}
    local lang = assert(opts.lang, "`opts.lang` is required")
    local bufnr = opts.bufnr or 0
    local start_row = opts.start_row or 0
    local end_row = opts.end_row or -1
    assert((opts.query_name or opts.query_string), "require either of `opts.query_string` or `opts.query_name`!")

    -- Normalize the `capture_names` into a set for O(1) membership checks.
    local capture_names = opts.capture_names
    if type(capture_names) == "string" then
        capture_names = { capture_names }
    end

    local wanted = {}
    for _, name in ipairs(capture_names) do
        wanted[name] = true
    end

    -- Get parser and syntax tree root.
    local parser, perr = get_parser(bufnr, lang)
    if not parser then
        if perr then
            vim.notify(perr, vim.log.levels.ERROR)
        end
        return {}
    end

    local tree = parser:parse()
    if not tree then
        return {}
    end
    local root = tree[1]:root()

    -- Load query (from string or by name).
    local query = resolve_query(lang, opts.query_name, opts.query_string)
    if not query then
        return {}
    end

    ---@type TSGroupedMatches
    local results = {}

    for _, match, _ in query:iter_matches(root, bufnr, start_row, end_row) do
        ---@type TSGroupedMatch
        local bucket = {}

        -- `match` maps capture_id -> TSNode | TSNode[]
        for captured_id, captured_data in pairs(match) do
            local capture_name = query.captures[captured_id]
            if wanted[capture_name] then
                -- Normalize: a capture can be a single node or a list of nodes (for +/* quantifiers).
                local nodes
                if type(captured_data) == "table" then
                    nodes = captured_data
                else
                    nodes = { captured_data }
                end
                for _, node in ipairs(nodes) do
                    if node and type(node) == "userdata" then
                        ---@cast node TSNode  -- (requires neodev.nvim for Neovim TS types)
                        local ok, text = pcall(ts.get_node_text, node, bufnr)
                        if ok and text ~= "" then
                            bucket[capture_name] = bucket[capture_name] or {}
                            table.insert(bucket[capture_name], text)
                        end
                    end
                end
            end
        end
        table.insert(results, bucket)
    end

    return results
end

return M
