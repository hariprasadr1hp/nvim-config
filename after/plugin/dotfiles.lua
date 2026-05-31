-- after/plugin/dotfiles.lua

if vim.g.vscode then
    return
end

local keymap_set = require("config.helpers").keymap_set

local M = {}

local get_os = require("config.helpers").get_os

---@class OSPath
---@field macos string | nil
---@field linux string | nil

---@param paths OSPath
---@return string | nil
local function os_path(paths)
    local os = get_os()
    if os == "linux" then
        return paths["linux"] or nil
    elseif os == "macos" then
        return paths["macos"] or nil
    else
        return nil
    end
end

---@class GlobalFpath
---@field name string
---@field alias string | nil
---@field fpath string

---@return GlobalFpath[]
local function get_global_fpaths()
    return {
        { name = "acli", alias = "atlassian-cli", fpath = "~/.config/acli/jira_config.yaml" },
        { name = "aichat", alias = nil, fpath = "~/.config/aichat/config.yaml" },
        { name = "claude", alias = nil, fpath = "~/.claude/settings.json" },
        { name = "claurst", alias = nil, fpath = "~/.claurst/settings.json" },
        { name = "cntb", alias = "contabo-cli", fpath = "~/.cntb.yaml" },
        { name = "codex", alias = nil, fpath = "~/.codex/config.toml" },
        { name = "cursor", alias = nil, fpath = "~/.cursor/cli-config.json" },
        { name = "dbui", alias = nil, fpath = "~/.local/share/db_ui/connections.json" },
        {
            name = "espanso",
            alias = nil,
            fpath = os_path({
                macos = "~/Library/Application Support/espanso/match/base.yml",
                linux = "~/.config/espanso/match/base.yml",
            }),
        },
        { name = "hammerspoon", alias = nil, fpath = "~/.hammerspoon/init.lua" },
        { name = "gcloud", alias = nil, fpath = "~/.config/gcloud/configurations/config_default" },
        { name = "gemini", alias = nil, fpath = "~/.gemini/settings.json" },
        { name = "ghostty", alias = nil, fpath = "~/.config/ghostty/config" },
        { name = "gh", alias = "github-cli", fpath = "~/.config/gh/config.yml" },
        { name = "gitconfig", alias = nil, fpath = "~/.gitconfig" },
        { name = "hunspell", alias = nil, fpath = "~/.config/hunspell/hunspell_personal" },
        { name = "kitty", alias = nil, fpath = "~/.config/kitty/kitty.conf" },
        { name = "lazygit", alias = nil, fpath = "~/.config/lazygit/config.yml" },
        { name = "lazydocker", alias = nil, fpath = "~/.config/lazydocker/config.yml" },
        { name = "lazysql", alias = nil, fpath = "~/.config/lazysql/config.toml" },
        { name = "mcphub-servers", alias = nil, fpath = "~/.config/mcphub/servers.json" },
        { name = "nix", alias = nil, fpath = "~/.config/nix/flake.nix" },
        { name = "opencode", alias = nil, fpath = "~/.config/opencode/opencode.jsonc" },
        {
            name = "poetry",
            alias = nil,
            fpath = os_path({
                macos = "~/Library/Application Support/pypoetry/config.toml",
                linux = "~/.config/pypoetry/config.toml",
            }),
        },
        {
            name = "osaurus",
            alias = nil,
            fpath = os_path({
                macos = "~/.osaurus/ChatConfiguration.json",
            }),
        },
        { name = "sqlfluff", alias = nil, fpath = "~/.sqlfluff" },
        { name = "sqls", alias = nil, fpath = "~/.config/sqls/config.yml" },
        { name = "starship", alias = nil, fpath = "~/.config/starship/starship.toml" },
        { name = "wezterm", alias = nil, fpath = "~/.config/wezterm/wezterm.lua" },
        { name = "zellij", alias = nil, fpath = "~/.config/zellij/config.kdl" },
    }
end

function M.pick_dotfiles()
    -- Filter valid dotfiles first to avoid nil holes in the table
    local valid_dotfiles = {}
    for _, entry in ipairs(get_global_fpaths()) do
        local fpath = entry.fpath
        local name = entry.alias or entry.name
        if fpath then
            local expanded_path = vim.fn.expand(fpath)
            if vim.fn.filereadable(expanded_path) == 1 then
                table.insert(valid_dotfiles, { name = name or entry.name, path = expanded_path })
            else
                vim.notify(string.format("Path for `%s` not found!", name))
            end
        end
    end

    vim.ui.select(valid_dotfiles, {
        prompt = "Select Dotfile",
        format_item = function(item)
            if item then
                return item.name
            end
            return ""
        end,
    }, function(choice)
        if choice and choice.path then
            vim.cmd.edit(choice.path)
        end
    end)
end

vim.api.nvim_create_user_command("Dotfiles", M.pick_dotfiles, { desc = "Fuzzy find and open dotfiles" })

keymap_set("n", "<leader>fc", M.pick_dotfiles, "dotfiles")

return M
