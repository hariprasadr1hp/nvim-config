-- lua/config/vscode.lua

-- REFER: [VSCode Neovim Plugin](https://github.com/vscode-neovim/vscode-neovim)

-- NOTE: default neovim settings at `lua/config/settings.lua` are loaded to vscode

----------------------------------------------------------------
-- HELPERS FUNCTIONS -------------------------------------------
----------------------------------------------------------------

local M = {}

-- Print table, as well as numbers/strings
function M.pprint(value)
    if type(value) == "table" then
        print(vim.inspect(value))
    else
        print(value)
    end
    return value
end

-- Prints (type) of table, as well as numbers/strings
function M.tprint(value)
    print(type(value))
end

local function keymap_set(mode, lhs, rhs, desc, key_opts)
    local opts = vim.tbl_extend("force", {
        noremap = true,
        silent = true,
        desc = desc or (type(rhs) == "string" and rhs or nil),
    }, key_opts or {})

    vim.keymap.set(mode, lhs, rhs, opts)
end

-- Load all the variables from the `.env` file (by default)
-- For custom loading, pass the filename as an argument
---@param filepath string | nil
function M.load_env_file(filepath)
    local file = io.open(filepath or ".env", "r")
    if not file then
        return
    end

    for line in file:lines() do
        -- ignore comments and empty lines
        if not line:match("^%s*#") and line:match("%S") then
            local key, value = line:match("^%s*([%w_.-]+)%s*=%s*(.*)%s*$")
            if key and value then
                -- remove surrounding quotes if any
                value = value:gsub("^[\"']", ""):gsub("[\"']$", "")
                vim.env[key] = value
            end
        end
    end

    file:close()
end

----------------------------------------------------------------
-- KEYBINDINGS -------------------------------------------------
----------------------------------------------------------------

local vsaction = require("vscode").action
local vsnotify = require("vscode").notify

-- `Y` yanks till the end of the line from the cursor
keymap_set("n", "Y", "y$")

-- g chords
keymap_set("n", "g2", "@")
keymap_set("n", "g3", "#")
keymap_set("n", "g4", "$")
keymap_set("n", "g5", "%")
keymap_set("n", "g6", "^")
keymap_set("n", "g9", "g$")
keymap_set("n", "g/", "/\\v")

-- continued visual selection while indenting
keymap_set("v", "<", "<gv")
keymap_set("v", ">", ">gv")

-- continued visual selection while counting
keymap_set("v", "<C-a>", "<C-a>gv")
keymap_set("v", "<C-x>", "<C-x>gv")

-- window settings
keymap_set("n", "<C-w>m", "<C-w>|", "maximize-horizontal")
keymap_set("n", "<C-w>M", "<C-w>_", "maximize-vertical")

keymap_set("n", "<C-w><C-Left>", "<C-w>h", "goto-left-window")
keymap_set("n", "<C-w><C-Right>", "<C-w>l", "goto-right-window")
keymap_set("n", "<C-w><C-Up>", "<C-w>k", "goto-top-window")
keymap_set("n", "<C-w><C-Down>", "<C-w>j", "goto-bottom-window")

-- Move selected line / block of text in visual mode
-- shift + k to move up
-- shift + j to move down
keymap_set("x", "J", "move '<+1<CR>gv-gv", "move-select-lines-down")
keymap_set("x", "K", "move '<-2<CR>gv-gv", "move-select-lines-up")

-- visually select text for searching, mapped to //
-- using \V (no-magic)
keymap_set("x", "//", [[y/\V<C-R>=escape(@", '/\')<CR><CR>]], "search-selected")

-- JUMPS
-------------------------------------------------------------------
-- [b] buffer chain

-- [d] diagnostic chain
keymap_set("n", "]d", function()
    vsaction("editor.action.marker.prev")
end, "next-diagnostic")

keymap_set("n", "[d", function()
    vsaction("editor.action.marker.next")
end, "prev-diagnostic")

-- SURROUND
-------------------------------------------------------------------

-- `d` for double quotess
keymap_set("n", "cad", 'ca"')
keymap_set("n", "cid", 'ci"')
keymap_set("n", "dad", 'da"')
keymap_set("n", "did", 'di"')
keymap_set("n", "vad", 'va"')
keymap_set("n", "vid", 'vi"')
keymap_set("n", "yad", 'ya"')
keymap_set("n", "yid", 'yi"')

-- `q` for single quotes
keymap_set("n", "caq", "ca'")
keymap_set("n", "ciq", "ci'")
keymap_set("n", "daq", "da'")
keymap_set("n", "diq", "di'")
keymap_set("n", "vaq", "va'")
keymap_set("n", "viq", "vi'")
keymap_set("n", "yaq", "ya'")
keymap_set("n", "yiq", "yi'")

-- `x` for backticks
keymap_set("n", "cax", "ca`")
keymap_set("n", "cix", "ci`")
keymap_set("n", "dax", "da`")
keymap_set("n", "dix", "di`")
keymap_set("n", "vax", "va`")
keymap_set("n", "vix", "vi`")
keymap_set("n", "yax", "ya`")
keymap_set("n", "yix", "yi`")

-- META-KEYS
-------------------------------------------------------------------
keymap_set("n", "<M-s>", ":update<CR>")

-- CLIPBOARD
-------------------------------------------------------------------
-- format: <leader> (+) [a]ction (+) {{ [c]opy | [x]cut | [v]paste }} (+) register
-- ex: `<leader>acf` copies (c) contents to the register `f`

-- Basic mappings
keymap_set("n", "<leader>avv", "+P")
keymap_set("n", "<leader>acc", 'V"+y')
keymap_set("n", "<leader>axx", 'V"+d')
keymap_set("v", "<leader>avv", "+P")
keymap_set("v", "<leader>acc", '"+y')
keymap_set("v", "<leader>axx", '"+d')

-- Default register ("-)
keymap_set("n", "<leader>ax-", '"-d')
keymap_set("v", "<leader>ax-", '"-d')
keymap_set("n", "<leader>ac-", '"-y')
keymap_set("v", "<leader>ac-", '"-y')

-- Registers 0-9 and specials
local reg_keys = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-" }
for _, r in ipairs(reg_keys) do
    keymap_set("n", "<leader>a" .. "v" .. r, '"' .. r .. "P")
    keymap_set("v", "<leader>a" .. "v" .. r, '"' .. r .. "P")
end

-- Registers a-z and A-Z (except 'xcvXCV')
for _, r in
    ipairs(
        vim.fn.split("a,b,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,w,y,z,A,B,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,W,Y,Z", ",")
    )
do
    keymap_set("n", "<leader>a" .. "c" .. r, 'V"' .. r .. "y")
    keymap_set("v", "<leader>a" .. "c" .. r, '"' .. r .. "y")
    keymap_set("n", "<leader>a" .. "x" .. r, 'V"' .. r .. "d")
    keymap_set("v", "<leader>a" .. "x" .. r, '"' .. r .. "d")
    keymap_set("n", "<leader>a" .. "v" .. r, '"' .. r .. "P")
    keymap_set("v", "<leader>a" .. "v" .. r, '"' .. r .. "P")
end

-- LEADER-KEY BINDINGS
-------------------------------------------------------------------

keymap_set("n", "<leader>,", function()
    vsaction("workbench.action.quickOpen")
end, "files")
keymap_set("n", "<leader>.", function()
    vsaction("workbench.action.quickOpen")
end, "files")

keymap_set("n", "<leader>ai", function()
    vsaction("aichat.newchataction")
end, "ai-chat")

keymap_set("n", "<leader>ff", function()
    vsaction("workbench.action.openRecent")
end, "recent-files")
keymap_set("n", "<leader>fs", function()
    vsaction("workbench.action.files.save")
end, "save-file")

keymap_set("n", "<leader>ht", function()
    vsaction("workbench.action.selectTheme")
end, "recent-files")

keymap_set("n", "<leader>oe", function()
    vsaction("workbench.action.toggleSidebarVisibility")
end, "toggle-explorer")
keymap_set("n", "<leader>oM", function()
    vsaction("workbench.action.openMCPSettings")
end, "MCP-settings")
keymap_set("n", "<leader>on", ":messages<CR>", "notifications")
keymap_set("n", "<leader>ot", function()
    vsaction("workbench.action.terminal.toggleTerminal")
end, "toggle-terminal")

----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------

_G.pprint = M.pprint
_G.P = M.pprint
_G.tprint = M.tprint
_G.T = M.tprint
_G.vsget = require("vscode").get_config
_G.vsset = require("vscode").update_config
_G.vsnotify = vsnotify

-- load nvim-config .env variables
M.load_env_file(vim.fn.stdpath("config") .. "/.env")

print("neovim settings succefully loaded!")
return M
