-- lua/config/health.lua
-- Health check for custom Neovim configuration

local M = {}

local health = vim.health or require("health")
local start = health.start or health.report_start
local ok = health.ok or health.report_ok
local warn = health.warn or health.report_warn
local error = health.error or health.report_error
local info = health.info or health.report_info

-- Check if a command exists
local function command_exists(cmd)
    return vim.fn.executable(cmd) == 1
end

-- Check if a Lua module exists
local function module_exists(name)
    local status, _ = pcall(require, name)
    return status
end

-- Check if a plugin is loaded
local function plugin_loaded(name)
    return package.loaded[name] ~= nil
end

-- Check Neovim version
local function check_neovim_version()
    start("Neovim Version")
    local version = vim.version()
    local version_str = string.format("%d.%d.%d", version.major, version.minor, version.patch)

    if version.major >= 0 and version.minor >= 11 then
        ok(string.format("Neovim version: %s", version_str))
    -- elseif version.major >= 0 and version.minor >= 10 then
    --     warn(string.format("Neovim version: %s (0.11+ recommended)", version_str))
    else
        error(string.format("Neovim version: %s (0.11+ required)", version_str))
    end
end

-- Check required external tools
local function check_external_tools()
    start("External Dependencies")

    local tools = {
        { cmd = "git", required = true, desc = "Version control" },
        { cmd = "curl", required = false, desc = "Data Transfer" },
        { cmd = "rg", required = true, desc = "Fuzzy searching texts" },
        { cmd = "fd", required = false, desc = "Fast file finder" },
        { cmd = "node", required = true, desc = "Node.js for LSP servers" },
        { cmd = "cargo", required = true, desc = "Rust toolchain" },
        { cmd = "python3", required = true, desc = "Python support" },
        { cmd = "lazygit", required = false, desc = "Git TUI" },
        { cmd = "lazydocker", required = false, desc = "Docker TUI" },
        { cmd = "pandoc", required = false, desc = "Document converter" },
        { cmd = "w3m", required = false, desc = "Terminal Browser" },
        { cmd = "zed", required = false, desc = "Zed Editor" },
        { cmd = "jena", required = false, desc = "Semantic Web Framework" },
        { cmd = "mmdc", required = false, desc = "Mermaid CLI" },
    }

    for _, tool in ipairs(tools) do
        if command_exists(tool.cmd) then
            ok(string.format("%s: found (%s)", tool.cmd, tool.desc))
        else
            if tool.required then
                error(string.format("%s: not found (%s)", tool.cmd, tool.desc))
            else
                warn(string.format("%s: not found (%s)", tool.cmd, tool.desc))
            end
        end
    end
end

-- Check lazy.nvim plugin manager
local function check_lazy()
    start("Plugin Manager")

    if module_exists("lazy") then
        ok("lazy.nvim: installed")

        local lazy = require("lazy")
        local stats = lazy.stats()
        info(string.format("Plugins loaded: %d/%d", stats.loaded, stats.count))

        if stats.count > 0 then
            ok(string.format("Total plugins: %d", stats.count))
        end
    else
        error("lazy.nvim: not installed")
        info("Run :Lazy to install plugins")
    end
end

-- Check critical plugins
local function check_critical_plugins()
    start("Critical Plugins")

    local plugins = {
        { name = "nvim-treesitter", desc = "Syntax highlighting" },
        { name = "fzf-lua", desc = "Fuzzy finder" },
        { name = "lspconfig", desc = "LSP configuration" },
        { name = "blink.cmp", desc = "Completion engine" },
    }

    for _, plugin in ipairs(plugins) do
        if plugin_loaded(plugin.name) then
            ok(string.format("%s: loaded (%s)", plugin.name, plugin.desc))
        else
            warn(string.format("%s: not loaded (%s)", plugin.name, plugin.desc))
        end
    end
end

-- Check Treesitter parsers
local function check_treesitter()
    start("Treesitter")

    if not module_exists("nvim-treesitter") then
        warn("nvim-treesitter not installed")
        return
    end

    local ts_parsers = require("nvim-treesitter.parsers")
    local installed_parsers = ts_parsers.available_parsers()

    if #installed_parsers > 0 then
        ok(string.format("Installed parsers: %d", #installed_parsers))

        local important_parsers = { "lua", "python", "rust", "json", "yaml", "toml" }
        for _, parser in ipairs(important_parsers) do
            if ts_parsers.has_parser(parser) then
                ok(string.format("Parser '%s': installed", parser))
            else
                warn(string.format("Parser '%s': not installed", parser))
            end
        end
    else
        warn("No Treesitter parsers installed")
        info("Run :TSInstall <language> to install parsers")
    end
end

-- Check LSP servers
local function check_lsp()
    start("LSP Servers")

    if not module_exists("lspconfig") then
        warn("lspconfig not installed")
        return
    end

    local active_clients = vim.lsp.get_clients()

    if #active_clients > 0 then
        ok(string.format("Active LSP clients: %d", #active_clients))
        for _, client in ipairs(active_clients) do
            info(string.format("- %s (buffers: %s)", client.name, vim.inspect(client.attached_buffers)))
        end
    else
        info("No active LSP clients (open a file to start LSP)")
    end
end

-- Check Python environment
local function check_python()
    -- FIX: check for the uv venv in the config dir
    start("Python Environment")

    if not command_exists("python3") then
        warn("python3 not found")
        return
    end

    local python_version = vim.fn.system("python3 --version"):gsub("\n", "")
    ok(string.format("Python version: %s", python_version))

    -- Check for pynvim
    local pynvim_check = vim.fn.system("python3 -c 'import pynvim' 2>&1")
    if vim.v.shell_error == 0 then
        ok("pynvim: installed")
    else
        warn("pynvim: not installed")
        info("Install with: pip3 install pynvim")
    end
end

-- Check file permissions
local function check_permissions()
    start("File Permissions")

    local config_path = vim.fn.stdpath("config")
    local data_path = vim.fn.stdpath("data")

    if vim.fn.isdirectory(config_path) == 1 then
        ok(string.format("Config directory: %s", config_path))
    else
        error(string.format("Config directory not found: %s", config_path))
    end

    if vim.fn.isdirectory(data_path) == 1 then
        ok(string.format("Data directory: %s", data_path))
    else
        error(string.format("Data directory not found: %s", data_path))
    end
end

-- Main health check function
function M.check()
    check_neovim_version()
    check_permissions()
    check_external_tools()
    check_lazy()
    check_critical_plugins()
    check_treesitter()
    check_lsp()
    check_python()
    -- TODO: check_oxi()
    -- TODO: check_paths()
    -- TODO: check_envs()
    -- TODO: check_shopts()

    start("Summary")
    ok("Health check complete")
    info("Run :checkhealth for more detailed system checks")
end

return M
