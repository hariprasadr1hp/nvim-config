-- lua/plugins/fuzzy.lua

local opts = {
    -- Maximum allowed value of match features (width and first match). All
    -- feature values greater than cutoff can be considered "equally bad".
    cutoff = 100,
}

local function setup_mini_fuzzy()
    require("mini.fuzzy").setup(opts)
end

MiniDeps.later(setup_mini_fuzzy)
