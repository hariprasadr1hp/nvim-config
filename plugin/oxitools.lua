local ok, oxitools = pcall(require, "oxitools")

if not ok then
    vim.notify("oxitools: failed to load native module: " .. tostring(oxitools), vim.log.levels.ERROR)
    return
end
