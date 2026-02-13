-- lua/plugins/roam.lua

return {
    "chipsenkbeil/org-roam.nvim",
    tag = "0.2.0",
    ft = { "org" },
    dependencies = {
        {
            "nvim-orgmode/orgmode",
            tag = "0.7.0",
            ft = { "org" },
            config = function()
                -- FIX: do not hijack angular brackets functionality
                require("orgmode").setup({
                    org_agenda_files = vim.env.ORG_DIR .. "/agenda",
                    mappings = {
                        global = {
                            org_agenda = false,
                            org_capture = false,
                        },
                    },
                })
            end,
        },
    },
    config = function()
        require("org-roam").setup({
            directory = (vim.env.ORG_DIR .. "/roam") or "~/my/org/roam/",
            org_files = {
                vim.env.ORG_DIR .. "/journal",
                vim.env.ORG_DIR .. "/misc",
            },
            bindings = {
                prefix = "<leader>nr",
            },
        })
    end,
}
