-- lua/plugins/comment.lua

local opts = {
    options = {
        custom_commentstring = nil,
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
