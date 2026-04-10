-- lua/config/autocmds.lua

-- enable treesitter highlighting / indents / folds
vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        local filetype = args.match
        local lang = vim.treesitter.language.get_lang(filetype)
        if lang and vim.treesitter.language.add(lang) then
            -- indents
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

            -- folds
            -- vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
            -- vim.wo[0][0].foldmethod = "expr"

            -- highlights
            vim.treesitter.start()
        end
    end,
})
