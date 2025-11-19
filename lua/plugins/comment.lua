-- lua/plugins/comment.lua

local opts = {
    options = {
        custom_commentstring = function()
            local ft = vim.bo.filetype
            if ft == "sparql" then
                return "# %s"
            elseif ft == "lisp" then
                return ";; %s"
            end
            -- return vim.bo.commentstring
        end,
        ignore_blank_line = false,
        start_of_line = false,
        pad_comment_parts = true,
    },

    mappings = {
        comment = "<leader>/",
        comment_line = "<leader>/",
        comment_visual = "<leader>/",
        textobject = "<leader>/",
    },

    hooks = {
        pre = function() end,
        post = function() end,
    },
}

return {
    {
        "echasnovski/mini.comment",
        version = false,
        opts = opts,
    },
}
