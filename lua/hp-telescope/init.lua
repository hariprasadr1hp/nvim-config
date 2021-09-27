-- visit https://github.com/nvim-telescope/telescope.nvim

local actions = require('telescope.actions')

-- Global remapping
------------------------------
-- '--color=never',
require('telescope').load_extension('media_files')
require('telescope').setup {
    defaults = {
        vimgrep_arguments = {
			'rg',
			'--no-heading',
			'--with-filename',
			'--line-number',
			'--column',
			'defaultmart-case'
		},

		-- What should the prompt prefix be
        prompt_prefix = " ",

		-- What should the selection caret be
        selection_caret = " ",

		-- What should be shown in front of every entry.
		-- (current selection excluded)
        entry_prefix = " ",

		-- The initial mode when a prompt is opened
		initial_mode = "insert",
        selection_strategy = "reset",

		-- Where first selection should be located
        sorting_strategy = "descending",

		-- How the telescope is drawn
        layout_strategy = "horizontal",

		-- Extra settings for fine-tuning how your layout looks
        layout_config = {
			horizontal = {
				mirror = false
			},
			vertical = {
				mirror = false
			}
		},

		-- sorter
		file_sorter = require'telescope.sorters'.get_fuzzy_file,
        file_ignore_patterns = {},
        generic_sorter = require'telescope.sorters'.get_generic_fuzzy_sorter,

		-- How transparent is the telescope window should be
		winblend = 0,

		-- The border chars, it gives border telescope window
        border = {},
        borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},

		-- Whether to color devicons or not
		color_devicons = true,

		-- Whether to use less with bat or less/cat if bat not installed
		use_less = true,

		-- How file paths are displayed (causing telescope to not show files)
        -- path_display = true,

		-- Set environment variables for previewer
		set_env = {['COLORTERM'] = 'truecolor'}, -- default = nil,

		-- What telescope previewer to use for files
		file_previewer = require'telescope.previewers'.vim_buffer_cat.new,

		-- What telescope previewer to use for grep and similar
		grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,

		-- What telescope previewer to use for qflist
		qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,

		-- mappings
        mappings = {
			-- insert mode
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                -- To disable a keymap, put [map] = false
                -- So, to not map "<C-n>", just put
                -- ["<c-x>"] = false,
                ["<esc>"] = actions.close,

                -- Otherwise, just set the mapping to the function that you want it to be.
                -- ["<C-i>"] = actions.select_horizontal,

                -- Add up multiple actions
                ["<CR>"] = actions.select_default + actions.center

                -- You can perform as many actions in a row as you like
                -- ["<CR>"] = actions.select_default + actions.center + my_cool_custom_action,
            },

			-- normal mode
            n = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                -- ["<C-i>"] = my_cool_custom_action,
            }
        }
    },

    require'telescope'.setup {
        extensions = {
            media_files = {
                -- filetypes whitelist
                -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
                filetypes = {"png", "webp", "jpg", "jpeg"},
                find_cmd = "rg" -- find command (defaults to `fd`)
            }
        }
    }
}

