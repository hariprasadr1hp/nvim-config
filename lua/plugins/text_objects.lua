-- lua/plugins/text_objects.lua

local M = {}

local function setup_nvim_treesitter_text_object_config()
	---@diagnostic disable-next-line: missing-fields
	require("nvim-treesitter.configs").setup({
		textobjects = {
			select = {
				enable = true,

				-- Automatically jump forward to textobj, similar to target.vim
				lookahead = true,

				keymaps = {
					["a="] = { query = "@assignment.outer", desc = "around-assignment" },
					["i="] = { query = "@assignment.inner", desc = "inner-assignment" },
					["l="] = { query = "@assignment.lhs", desc = "left-assignment" },
					["r="] = { query = "@assignment.rhs", desc = "right-assignment" },

					["ai"] = { query = "@conditional.outer", desc = "around-conditional" },
					["ii"] = { query = "@conditional.inner", desc = "inner-conditional" },

					["al"] = { query = "@loop.outer", desc = "around-loop" },
					["il"] = { query = "@loop.outer", desc = "inner-loop" },

					["af"] = { query = "@function.outer", desc = "around-function" },
					["if"] = { query = "@function.inner", desc = "inner-function" },

					["ac"] = { query = "@class.outer", desc = "around-class" },
					["ic"] = { query = "@class.inner", desc = "inner-class" },
				},
				include_surrounding_whitespace = false,
			},

			swap = {
				enable = true,
				swap_next = {
					[",na"] = "@parameter.outer",
					[",nf"] = "@function.outer",
				},

				swap_previous = {
					[",pa"] = "@parameter.outer",
					[",pf"] = "@function.outer",
				},
			},

			move = {
				enable = true,
				set_jumps = true,

				goto_previous_start = {
					["[f"] = { query = "@function.outer", desc = "prev-function" },
					["[i"] = { query = "@conditional.outer", desc = "prev-conditional" },
					["[l"] = { query = "@loop.outer", desc = "prev-loop" },
				},

				goto_previous_end = {
					["[F"] = { query = "@function.outer", desc = "prev-function" },
					["[I"] = { query = "@conditional.outer", desc = "prev-conditional" },
					["[L"] = { query = "@loop.outer", desc = "prev-loop" },
				},

				goto_next_start = {
					["]f"] = { query = "@function.outer", desc = "next-function" },
					["]i"] = { query = "@conditional.outer", desc = "next-conditional" },
					["]l"] = { query = "@loop.outer", desc = "next-loop" },
				},

				goto_next_end = {
					["]F"] = { query = "@function.outer", desc = "next-function" },
					["]I"] = { query = "@conditional.outer", desc = "next-conditional" },
					["]L"] = { query = "@loop.outer", desc = "next-loop" },
				},
			},
		},
	})
end

M = {
	"nvim-treesitter/nvim-treesitter-textobjects",
	lazy = true,
	config = function()
		setup_nvim_treesitter_text_object_config()
	end,
}

return M
