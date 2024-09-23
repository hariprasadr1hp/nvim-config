-- lua/external_plugins/telescope.lua

return {
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},

		config = function()
			local actions = require("telescope.actions")

			require("telescope").setup({
				defaults = {
					preview = {
						filesize_limit = 0.1, -- MB
					},
					mappings = {
						i = {
							["<c-enter>"] = "to_fuzzy_refine",
							["<esc>"] = actions.close,
							["<C-u>"] = false,
							-- ["<C-s>"] = actions.cycle_previewers_next,
							-- ["<C-a>"] = actions.cycle_previewers_prev,
						},
					},
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--trim", -- add this value
					},
				},
				pickers = {
					find_files = {
						-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
						find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")
		end,
	},
}

-- TODO: separate functions for showing ignore and hidden files in the fuzzy finder
