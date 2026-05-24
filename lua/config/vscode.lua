-- lua/config/vscode.lua

-- REFER: [VSCode Neovim Plugin](https://github.com/vscode-neovim/vscode-neovim)

-- NOTE: default neovim settings at `lua/config/settings.lua` are loaded to vscode

----------------------------------------------------------------
-- SETTINGS ----------------------------------------------------
----------------------------------------------------------------

vim.o.hlsearch = true

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

local select = require("vim.treesitter._select")
local vsaction = require("vscode").action
local vsnotify = require("vscode").notify
-- local.vsget = require("vscode").get_config
-- local.vsset = require("vscode").update_config

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
keymap_set("x", "J", "move '<+1<cr>gv-gv", "move-select-lines-down")
keymap_set("x", "K", "move '<-2<cr>gv-gv", "move-select-lines-up")

-- visually select text for searching, mapped to //
-- using \V (no-magic)
keymap_set("x", "<leader>sv", [[y/\V<C-R>=escape(@", '/\')<cr><cr>]], "search-selected")

-- JUMPS
-------------------------------------------------------------------
-- [b] buffer chain

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
keymap_set("n", "<M-s>", ":update<cr>")

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

-- KEYBINDINGS
-------------------------------------------------------------------
--- NORMAL MODE

-- TODO: AI mode
-- keymap_set("n", "<leader>ai", function()
--     vsaction("aichat.newchataction")
-- end, "ai-chat")

keymap_set("n", "<leader>fp", function()
    local cmd = string.format("edit %s", vim.fn.stdpath("config") .. "/lua/config/vscode.lua")
    vim.cmd(cmd)
end, "vscode-nvim-config-file")
keymap_set("n", "<leader>fa", ":e AGENTS.md<cr>", "AGENTS.md")
keymap_set("n", "<leader>fe", ":e .env<cr>", ".env")

keymap_set("n", "<leader>lk", function()
    select.select_parent(1)
end, "ts-incremental-select")

keymap_set("n", "<leader>om", function()
    local cmd = string.format("edit %s", vim.fn.getcwd() .. "/Makefile")
    vim.cmd(cmd)
end, "makefile")

keymap_set("n", "<leader>pc", ":e .nvim.lua<cr>", "config-project")
keymap_set("n", "<leader>pe", ":e http-client.private.env.json<cr>", "http-client.private.env.json")

-- TODO: MCP settings
-- keymap_set("n", "<leader>oM", function()
--     vsaction("workbench.action.openMCPSettings")
-- end, "MCP-settings")

-- TODO: print messages
-- keymap_set("n", "<leader>on", ":messages<cr>", "notifications")

keymap_set("n", "<leader>tG", ":%norm! g??<cr>", "gibberish-rot13")
keymap_set("n", "<leader>th", ":set hls!<cr>", "hl-search")
keymap_set("n", "<leader>tn", ":setl nu! rnu!<cr>", "line-numbers")
keymap_set("n", "<leader>ts", ":setl spell!<cr>", "spell-check")

local normal_action_keys = {
    ["[d"] = { "editor.action.marker.prev", "prev-diagnostic" },
    ["]d"] = { "editor.action.marker.next", "next-diagnostic" },

    ["g."] = { "editor.action.sourceAction", "lsp-code-action" },
    ["gA"] = { "editor.action.sourceAction", "lsp-code-action" },
    ["gD"] = { "editor.action.goToDeclaration", "lsp-declaration" },
    ["gI"] = { "editor.action.goToImplementation", "lsp-implementation" },
    ["gr"] = { "editor.action.goToReferences", "lsp-references" },
    ["gt"] = { "editor.action.goToTypeDefinition", "lsp-typedef" },

    ["<M-x>"] = { "workbench.action.showCommands", "commands" },

    ["<leader>,"] = { "workbench.action.quickOpen", "files" },
    ["<leader>."] = { "workbench.action.quickOpen", "files" },
    ["<leader>/"] = { "editor.action.commentLine", "comment" },

    ["<leader>bb"] = { "workbench.action.quickOpen", "buffers" },
    ["<leader>bk"] = { "workbench.action.closeActiveEditor", "kill-buffer" },
    ["<leader>bK"] = { "workbench.action.closeAllEditors", "kill-all-buffer" },
    ["<leader>bN"] = { "workbench.action.files.newUntitledFile", "new-buffer" },
    ["<leader>bO"] = { "workbench.action.closeOtherEditors", "kill-other-buffers" },

    ["<leader>cf"] = { "editor.action.formatDocument", "format-buffer" },

    ["<leader>db"] = { "editor.debug.action.toggleBreakpoint", "toggle-breakpoint" },

    ["<leader>ff"] = { "workbench.action.openRecent", "recent-files" },
    ["<leader>fs"] = { "workbench.action.files.save", "save-file" },
    ["<leader>fS"] = { "workbench.action.files.saveWithoutFormatting", "save-wo-format" },

    ["<leader>hhs"] = { "git.diff.stageHunk", "stage-hunk" },
    ["<leader>hrr"] = { "workbench.action.reloadWindow", "reload-window" },
    ["<leader>ht"] = { "workbench.action.selectTheme", "select-theme" },

    ["<leader>j1"] = { "workbench.action.openEditorAtIndex1", "tab-1" },
    ["<leader>j2"] = { "workbench.action.openEditorAtIndex2", "tab-2" },
    ["<leader>j3"] = { "workbench.action.openEditorAtIndex3", "tab-3" },
    ["<leader>j4"] = { "workbench.action.openEditorAtIndex4", "tab-4" },
    ["<leader>j5"] = { "workbench.action.openEditorAtIndex5", "tab-5" },
    ["<leader>j6"] = { "workbench.action.openEditorAtIndex6", "tab-6" },
    ["<leader>j7"] = { "workbench.action.openEditorAtIndex7", "tab-7" },
    ["<leader>j8"] = { "workbench.action.openEditorAtIndex8", "tab-8" },
    ["<leader>jK"] = { "openEditors.closeAll", "kill-all-tabs" },
    ["<leader>jn"] = { "workbench.action.files.newUntitledFile", "new-tab" },

    ["<leader>la"] = { "editor.action.sourceAction", "lsp-code-action" },
    ["<leader>ld"] = { "editor.action.goToDeclaration", "lsp-declaration" },
    ["<leader>lf"] = { "editor.action.goToReferences", "lsp-references" },
    ["<leader>li"] = { "editor.action.goToImplementation", "lsp-implementation" },
    ["<leader>lo"] = { "breadcrumbs.focusAndSelect", "outline-document" },
    ["<leader>lr"] = { "editor.action.rename", "lsp-rename" },
    ["<leader>lt"] = { "editor.action.goToTypeDefinition", "lsp-typedef" },

    ["<leader>oe"] = { "workbench.action.toggleSidebarVisibility", "toggle-explorer" },
    ["<leader>oo"] = { "workbench.action.gotoSymbol", "outline-document" },
    ["<leader>ot"] = { "workbench.action.terminal.toggleTerminal", "toggle-terminal" },

    ["<leader>qr"] = { "workbench.action.reloadWindow", "reload-window" },

    ["<leader>tf"] = { "editor.toggleFold", "toggle-fold" },
    ["<leader>tr"] = { "workbench.action.files.toggleActiveEditorReadonlyInSession", "read-only" },
    ["<leader>tt"] = { "workbench.action.terminal.runSelectedText", "send-cline-to-term" },
    ["<leader>tw"] = { "editor.action.toggleWordWrap", "wrap-text" },

    ["<leader>xm"] = { "workbench.output.action.clearOutput", "clear-messages" },

    ["<leader>zf"] = { "workbench.action.editor.changeLanguageMode", "select-filetype" },
}

for k, v in pairs(normal_action_keys) do
    keymap_set("n", k, function()
        vsaction(v[1])
    end, v[2])
end

local normal_na_keys = {
    "<leader>ib",
    "<leader>id",
    "<leader>ig",
    "<leader>ip",
    "<leader>is",
    "<leader>it",
    "<leader>iT",
    "<leader>oa",
    "<leader>oA",
    "<leader>od",
    "<leader>oi",
    "<leader>ok",
    "<leader>oK",
    "<leader>ol",
    "<leader>oL",
    "<leader>oq",
    "<leader>or",
    "<leader>os",
    "<leader>oT",
    "<leader>oz",
}

for _, key in ipairs(normal_na_keys) do
    keymap_set("n", key, function()
        vsnotify("`nvim` command 🫠")
    end, "n/a")
end

-------------------------------------------------------------------
--- VISUAL MODE

keymap_set("x", "<leader>tG", "g?", "gibberish-rot13")

local visual_action_keys = {
    ["<leader>/"] = { "editor.action.commentLine", "comment" },

    ["<leader>cf"] = { "editor.action.formatDocument", "format-buffer" },

    ["<leader>tt"] = { "workbench.action.terminal.runSelectedText", "send-vselect-to-term" },
}

for k, v in pairs(visual_action_keys) do
    keymap_set("x", k, function()
        vsaction(v[1])
    end, v[2])
end

keymap_set({ "x", "o" }, ".", function()
    if vim.treesitter.get_parser(nil, nil, { error = false }) then
        select.select_parent(1)
    else
        vim.lsp.buf.selection_range(vim.v.count1)
    end
end, "increment-node-select")

keymap_set({ "x", "o" }, ",", function()
    if vim.treesitter.get_parser(nil, nil, { error = false }) then
        select.select_child(1)
    else
        vim.lsp.buf.selection_range(-vim.v.count1)
    end
end, "decrement-node-select")

----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------

_G.pprint = M.pprint
_G.P = M.pprint
_G.tprint = M.tprint
_G.T = M.tprint

-- load nvim-config .env variables
M.load_env_file(vim.fn.stdpath("config") .. "/.env")

print("neovim settings succefully loaded!")
return M
