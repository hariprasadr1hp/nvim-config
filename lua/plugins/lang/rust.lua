-- lua/plugins/lang/rust.lua

local setup_rust = function()
    MiniDeps.add({
        source = "mrcjkb/rustaceanvim",
        checkout = "v6.0.3",
    })
end

MiniDeps.now(setup_rust)
