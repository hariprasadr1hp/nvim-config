-- lua/external_plugins/comment.lua

-- TODO: Comments plugin should be replaced with https://github.com/numToStr/Comment.nvim

local M = {}

local comment_config = {
	marker_padding = true, -- Linters prefer a space between comment markers
	comment_empty = true, -- Allow commenting out empty or whitespace lines
	comment_empty_trim_whitespace = true, -- Trim whitespace on empty comments
	create_mappings = true, -- Enable key mappings
	line_mapping = "gcc", -- Normal mode mapping
	operator_mapping = "gc", -- Visual/Operator mode mapping
	comment_chunk_text_object = "ic", -- Text object for comment chunks
	hook = nil, -- Hook function before commenting
}

M = {
	"terrortylor/nvim-comment",
	config = function()
		local nvim_comment = require("nvim_comment")
		nvim_comment.setup(comment_config)
	end,
}

return M

-- FIX: `CommentToggle` on visual selection
-- right now, only toggling the last line (use `gc` for comment in vusual mode)
