-- lua/plugins/lang/rust.lua

local function setup_rust()
    MiniDeps.add({
        source = "mrcjkb/rustaceanvim",
        checkout = "v6.0.3",
    })
end

MiniDeps.now(setup_rust)
