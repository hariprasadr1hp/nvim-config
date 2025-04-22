-- lua/plugins/telescope.lua

local function setup_mappings(actions, actions_layout)
    return {
        i = {
            ["<c-enter>"] = "to_fuzzy_refine",
            ["<CR>"] = actions.select_default,
            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,

            ["<C-c>"] = actions.close,
            ["<C-l>"] = actions.complete_tag,
            ["<C-p>"] = actions.move_selection_previous,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<C-n>"] = actions.move_selection_next,
            ["<C-t>"] = actions.select_tab,
            ["<C-u>"] = false, -- reset the characters in search prompt
            ["<C-v>"] = actions.select_vertical,
            ["<C-x>"] = actions.select_horizontal,
            ["<C-/>"] = actions.which_key,

            ["<M-k>"] = actions.preview_scrolling_up,
            ["<M-j>"] = actions.preview_scrolling_down,
            ["<M-h>"] = actions.results_scrolling_up,
            ["<M-l>"] = actions.results_scrolling_down,

            ["<M-p>"] = actions_layout.toggle_preview,
            ["<M-t>"] = actions_layout.toggle_preview,

            -- ["<C-s>"] = actions.cycle_previewers_next, -- cycling through previewers
            -- ["<C-a>"] = actions.cycle_previewers_prev, -- cycling through previewers
        },
    }
end

local function setup_defaults()
    local actions = require("telescope.actions")
    local actions_layout = require("telescope.actions.layout")
    local config = require("telescope.config")

    return {
        preview = {
            filesize_limit = 0.1, -- MB limit for preview
        },
        ---@type "horizontal" | "vertical"
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {
                height = 0.99,
                width = 0.99,
                preview_cutoff = 120,
                prompt_position = "bottom",
                results_width = 0.5,
                preview_width = 0.5,
            },
        },
        mappings = config.values.default_mappings or setup_mappings(actions, actions_layout),
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--trim", -- trim lines to remove extra whitespaces
        },
    }
end

local pickers = {
    find_files = {
        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
    },
}

local function setup_extensions()
    return {
        ["ui-select"] = require("telescope.themes").get_dropdown(),
        aerial = {
            -- Set the width of the first two columns (the second
            -- is relevant only when show_columns is set to 'both')
            col1_width = 4,
            col2_width = 30,
            -- How to format the symbols
            format_symbol = function(symbol_path, filetype)
                if filetype == "json" or filetype == "yaml" then
                    return table.concat(symbol_path, ".")
                else
                    return symbol_path[#symbol_path]
                end
            end,
            -- Available modes: symbols, lines, both
            show_columns = "both",
        },
    }
end

local function load_extensions()
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")
    pcall(require("telescope").load_extension, "aerial")
end

local function setup_telescope_config()
    require("telescope").setup({
        defaults = setup_defaults(),
        pickers = pickers,
        extensions = setup_extensions(),
    })

    load_extensions()
end

local setup_telescope = function()
    MiniDeps.add({
        source = "nvim-telescope/telescope.nvim",
        checkout = "0.1.x",
        depends = {
            "nvim-lua/plenary.nvim",
        },
    })

    setup_telescope_config()
end


MiniDeps.later(setup_telescope)
