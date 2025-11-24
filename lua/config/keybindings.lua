-- lua/keybindings.lua

local helpers = require("config.helpers")

local config_dir = vim.fn.stdpath("config")
local data_dir = vim.fn.stdpath("data")
local state_dir = vim.fn.stdpath("state")
local keymap_set = require("config.helpers").keymap_set

-- LEADER KEY-BINDINGS
-------------------------------------------------------------------
keymap_set("n", "<leader>b0", ":bfirst<CR>", "first-buffer")
keymap_set("n", "<leader>b1", ":1bnext<CR>", "buffer-1")
keymap_set("n", "<leader>b2", ":2bnext<CR>", "buffer-2")
keymap_set("n", "<leader>b3", ":3bnext<CR>", "buffer-3")
keymap_set("n", "<leader>b4", ":4bnext<CR>", "buffer-4")
keymap_set("n", "<leader>b5", ":5bnext<CR>", "buffer-5")
keymap_set("n", "<leader>b6", ":6bnext<CR>", "buffer-6")
keymap_set("n", "<leader>b7", ":7bnext<CR>", "buffer-7")
keymap_set("n", "<leader>b8", ":8bnext<CR>", "buffer-8")
keymap_set("n", "<leader>b9", ":blast<CR>", "last-buffer")
keymap_set("n", "<leader>bd", ":bd<CR>", "delete-buffer")
keymap_set("n", "<leader>bD", ":bd!<CR>", "DELETE-BUFFER")
keymap_set("n", "<leader>bf", ":bfirst<CR>", "first-buffer")
keymap_set("n", "<leader>bk", function()
    local curr_buf = vim.api.nvim_get_current_buf()
    local alt_buf = vim.fn.bufnr("#")
    if alt_buf > 0 and vim.api.nvim_buf_is_loaded(alt_buf) then
        vim.cmd("buffer #")
    else
        vim.cmd("bnext")
    end
    vim.cmd("bdelete " .. curr_buf)
end, "kill-buffer")
keymap_set("n", "<leader>bK", ":%bd | enew<CR>", "kill-all-buffers")
keymap_set("n", "<leader>bl", ":blast<CR>", "last-buffer")
keymap_set("n", "<leader>bp", ":bprevious<CR>", "prev-buffer")
keymap_set("n", "<leader>bn", ":bnext<CR>", "next-buffer")
keymap_set("n", "<leader>bN", ":enew<CR>", "new-buffer")
keymap_set("n", "<leader>bo", "%bd | e#<CR>", "only-current-buffer")
keymap_set("n", "<leader>bt", "<C-^>", "toggle-buffer")

keymap_set("n", "<leader>cm", ":make<CR>", "make-prg")

keymap_set("n", "<leader>eb", ":Runme<CR>", "eval-buffer")
keymap_set("n", "<leader>el", ":luafile %<CR>", "source-luafile")
keymap_set("n", "<leader>ev", ":source %<CR>", "source-vimfile")

keymap_set("n", "<leader>fd", ":e ~/.local/share/db_ui/connections.json<CR>", "dbui-file")
keymap_set("n", "<leader>fe", ":e .env<CR>", ".env")
keymap_set("n", "<leader>fi", ":e " .. config_dir .. "/lua/plugins/init.lua<CR>", "plugins/init.lua")
keymap_set("n", "<leader>fI", ":e " .. config_dir .. "/lua/config/init.lua<CR>", "config/init.lua")
keymap_set("n", "<leader>fl", ":e " .. config_dir .. "/lua/plugins/lspconfig.lua<CR>", "plugins/lspconfig.lua")
keymap_set("n", "<leader>fr", ":e<CR>", "reload-file")
keymap_set("n", "<leader>fs", ":update<CR>", "save-file")
keymap_set("n", "<leader>fS", ":noautocmd w<CR>", "save-wo-format")
keymap_set("n", "<leader>fw", ":e " .. config_dir .. "/lua/config/keybindings.lua<CR>", "keybindings.lua")
keymap_set("n", "<leader>fx", ":! rm -f " .. state_dir .. "/swap/*<CR>", "delete-swap-files")
keymap_set("n", "<leader>fX", ":! rm -f " .. data_dir .. "/undodir/*<CR>", "delete-undo-files")

keymap_set("n", "<leader>gC", ":e .git/config<CR>", ".git/config")
keymap_set("n", "<leader>gE", ":e .git/info/exclude<CR>", ".git/info/exclude")
keymap_set("n", "<leader>gi", ":e .gitignore<CR>", ".gitignore")

keymap_set("n", "<leader>hrr", ":echo '`emacs` command 🫠'<CR>")
keymap_set("n", "<leader>hs", vim.lsp.buf.signature_help, "lsp-signature-help")

keymap_set("n", "<leader>it", ":Inspect<CR>", "ts-inspect-element")
keymap_set("n", "<leader>iT", vim.treesitter.inspect_tree, "ts-inspect-tree")

keymap_set("n", "<leader>j0", ":tabfirst<CR>", "first-tab")
keymap_set("n", "<leader>j1", ":1tabnext<CR>", "tab-1")
keymap_set("n", "<leader>j2", ":2tabnext<CR>", "tab-2")
keymap_set("n", "<leader>j3", ":3tabnext<CR>", "tab-3")
keymap_set("n", "<leader>j4", ":4tabnext<CR>", "tab-4")
keymap_set("n", "<leader>j5", ":5tabnext<CR>", "tab-5")
keymap_set("n", "<leader>j6", ":6tabnext<CR>", "tab-6")
keymap_set("n", "<leader>j7", ":7tabnext<CR>", "tab-7")
keymap_set("n", "<leader>j8", ":8tabnext<CR>", "tab-8")
keymap_set("n", "<leader>j9", ":tablast<CR>", "last-tab")
keymap_set("n", "<leader>jK", ":tabonly<CR>", "kill-other-than-current-tab")
keymap_set("n", "<leader>jh", ":-tabmove<CR>", "move-left")
keymap_set("n", "<leader>ji", ":tabs<CR>", "info-tabs")
keymap_set("n", "<leader>jk", ":tabclose<CR>", "kill-tab")
keymap_set("n", "<leader>jl", ":+tabmove<CR>", "move-right")
keymap_set("n", "<leader>jn", ":tabnew<CR>", "new-tab")
keymap_set("n", "<leader>jO", ":tabonly<CR>", "only-current-tab")

keymap_set("n", "<leader>l0", vim.lsp.buf.outgoing_calls, "lsp-incoming-calls")
keymap_set("n", "<leader>l1", vim.lsp.buf.incoming_calls, "lsp-outgoing-calls")
keymap_set("n", "<leader>la", vim.lsp.buf.code_action, "lsp-code-Actions")
keymap_set("n", "<leader>ld", vim.lsp.buf.declaration, "lsp-declaration")
keymap_set("n", "<leader>lD", vim.lsp.buf.definition, "lsp-definition")
keymap_set("n", "<leader>lf", vim.lsp.buf.references, "lsp-references")
keymap_set("n", "<leader>lh", vim.lsp.buf.hover, "hover-docs")
keymap_set("n", "<leader>li", vim.lsp.buf.implementation, "lsp-implementations")
keymap_set("n", "<leader>ll", vim.diagnostic.open_float, "show-diagnostics")
keymap_set("n", "<leader>lq", vim.lsp.buf.workspace_symbol, "lsp-query-symbol")
keymap_set("n", "<leader>lr", vim.lsp.buf.rename, "lsp-rename")
keymap_set("n", "<leader>lR", vim.lsp.buf.references, "lsp-reFerences")
keymap_set("n", "<leader>ls", vim.lsp.buf.signature_help, "lsp-signature")
keymap_set("n", "<leader>lt", vim.lsp.buf.type_definition, "lsp-goto-typedef")
keymap_set("n", "<leader>l/", vim.lsp.buf.typehierarchy, "lsp-typehierarchy")

keymap_set("n", "<leader>om", ":e Makefile<CR>", "makefile")
keymap_set("n", "<leader>on", ":messages<CR>", "notifications")
-- TODO: show logs from "notifications" (vim.notify) only
keymap_set("n", "<leader>oN", ":messages<CR>", "notifications")

keymap_set("n", "<leader>pc", ":e .nvim.lua<CR>", "config-project")
keymap_set("n", "<leader>pe", ":e http-client.private.env.json<CR>", "http-client.private.env.json")

keymap_set("n", "<leader>njj", ":echo '`emacs` command 🫠'<CR>")
keymap_set("n", "<leader>nri", ":echo '`emacs` command 🫠'<CR>")
keymap_set("n", "<leader>nrr", ":echo '`emacs` command 🫠'<CR>")
keymap_set("n", "<leader>nrs", ":echo '`emacs` command 🫠'<CR>")

keymap_set("n", "<leader>qa", ":qa<CR>", "quit-all")
keymap_set("n", "<leader>qd", vim.diagnostic.setqflist, "diagnostics-to-quickfix")
keymap_set("n", "<leader>qk", ":cclose<CR>", "close-quickfix")
keymap_set("n", "<leader>qK", ":lclose<CR>", "close-loclist")

keymap_set("n", "<leader>qo", ":copen<CR>", "open-quickfix")
keymap_set("n", "<leader>qO", ":lopen<CR>", "open-loclist")
keymap_set("n", "<leader>qr", ":luafile " .. config_dir .. "/init.lua<CR>", "reload-config")
keymap_set("n", "<leader>qp", ":UpdateRemotePlugins<CR>", "reload-remote-plugins")
keymap_set("n", "<leader>qx", function()
    vim.fn.setqflist({})
end, "clear-quickfix")
keymap_set("n", "<leader>qX", function()
    vim.fn.setloclist(0, {})
end, "clear-loclist")

keymap_set("n", "<leader>td", function()
    local status = vim.diagnostic.is_enabled()
    vim.diagnostic.enable(not status)
    if status then
        vim.notify("diagnotics disabled!", vim.log.levels.INFO)
    else
        vim.notify("diagnostics enabled!", vim.log.levels.INFO)
    end
end, "diagnostics")
keymap_set("n", "<leader>tD", helpers.toggle_autocmd_debug, "debug-autocmds")
keymap_set("n", "<leader>tf", "zi", "folds")
keymap_set("n", "<leader>tG", ":%norm! g??<CR>", "gibberish-rot13")
keymap_set("n", "<leader>th", ":set hls!<CR>", "hl-search")
keymap_set("n", "<leader>ti", ":setl list!<CR>", "indent-guide")
keymap_set("n", "<leader>tn", ":setl nu! rnu!<CR>", "line-numbers")
keymap_set("n", "<leader>tr", ":setl ro!<CR>", "read-only")
keymap_set("n", "<leader>ts", ":setl spell!<CR>", "spell-check")
keymap_set("n", "<leader>tw", ":setl nowrap! linebreak breakindent<CR>", "wrap-text")

keymap_set("n", "<leader>w6", ":wincmd +<CR>", "increase-height")
keymap_set("n", "<leader>w7", ":wincmd -<CR>", "decrease-height")
keymap_set("n", "<leader>w9", ":wincmd <<CR>", "decrease-width")
keymap_set("n", "<leader>w0", ":wincmd ><CR>", "increase-width")
keymap_set("n", "<leader>w=", ":wincmd =<CR>", "equalize-window")
keymap_set("n", "<leader>wc", ":wincmd c<CR>", "close-window")
keymap_set("n", "<leader>wh", ":wincmd H<CR>", "window-to-left")
keymap_set("n", "<leader>wj", ":wincmd J<CR>", "window-to-bottom")
keymap_set("n", "<leader>wk", ":wincmd K<CR>", "window-to-top")
keymap_set("n", "<leader>wl", ":wincmd L<CR>", "window-to-right")
keymap_set("n", "<leader>wm", ":wincmd |<CR>", "maximize-window-width")
keymap_set("n", "<leader>wM", ":wincmd _<CR>", "maximize-window-height")
keymap_set("n", "<leader>wn", ":new<CR>", "new-window")
keymap_set("n", "<leader>wo", ":only<CR>", "only-current-window")
keymap_set("n", "<leader>wq", ":wincmd q<CR>", "quit-window")
keymap_set("n", "<leader>ws", ":wincmd s<CR>", "split-window-below")
keymap_set("n", "<leader>wv", ":wincmd v<CR>", "split-window-right")
keymap_set("n", "<leader>ww", ":wincmd w<CR>", "switch-window")
keymap_set("n", "<leader>wx", ":wincmd x<CR>", "swap-window")
keymap_set("n", "<leader>w|", ":wincmd <<CR>", "max-out-width")

keymap_set("x", "<leader>tG", "g?", "gibberish-rot13")
keymap_set("x", "<leader>sq", HP.SaveVisualSelection, "save-vselect-as-file")

-- SANE DEFAULTS
-------------------------------------------------------------------
-- `vim.lsp`
keymap_set("n", "g.", vim.lsp.buf.code_action, "code-action")
keymap_set("n", "gA", vim.lsp.buf.code_action, "code-action")
keymap_set("n", "gd", vim.lsp.buf.definition, "definition")
keymap_set("n", "gD", vim.lsp.buf.declaration, "declararion")
keymap_set("n", "gr", vim.lsp.buf.references, "references")
keymap_set("n", "gI", vim.lsp.buf.implementation, "implementation")
keymap_set("n", "gl", vim.diagnostic.open_float, "show-diagnostics")
keymap_set("n", "gt", vim.lsp.buf.type_definition, "goto-typedef")
keymap_set("n", "K", vim.lsp.buf.hover, "hover-docs")

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
keymap_set("n", "[b", ":bprevious<CR>", "prev-buffer")
keymap_set("n", "]b", ":bnext<CR>", "next-buffer")
keymap_set("n", "[B", ":bfirst<CR>", "first-buffer")
keymap_set("n", "]B", ":blast<CR>", "last-buffer")

-- [d] diagnostic chain
keymap_set("n", "]d", function()
    vim.diagnostic.jump({ count = 1, float = true })
end, "next-diagnostic")

keymap_set("n", "[d", function()
    vim.diagnostic.jump({ count = -1, float = true })
end, "prev-diagnostic")

-- [j] tab chain
keymap_set("n", "[j", ":tabprevious<CR>", "prev-tab")
keymap_set("n", "]j", ":tabnext<CR>", "next-tab")
keymap_set("n", "[J", ":tabfirst<CR>", "first-tab")
keymap_set("n", "]J", ":tablast<CR>", "last-tab")

-- TERMINAL
-------------------------------------------------------------------
-- toggle to normal-mode from terminal-mode (inside terminal)
-- to switch back, use `i` (back in terminal mode, inside terminal)
keymap_set("t", "<M-n>", "<C-\\><C-N>", "term-to-normal mode")

-- SWITCHING TABS (alias to `<leader>j<num>`)
keymap_set("n", ",0", ":tabfirst<CR>", "first-tab")
keymap_set("n", ",1", ":1tabnext<CR>", "tab-1")
keymap_set("n", ",2", ":2tabnext<CR>", "tab-2")
keymap_set("n", ",3", ":3tabnext<CR>", "tab-3")
keymap_set("n", ",4", ":4tabnext<CR>", "tab-4")
keymap_set("n", ",5", ":5tabnext<CR>", "tab-5")
keymap_set("n", ",6", ":6tabnext<CR>", "tab-6")
keymap_set("n", ",7", ":7tabnext<CR>", "tab-7")
keymap_set("n", ",8", ":8tabnext<CR>", "tab-8")
keymap_set("n", ",9", ":tablast<CR>", "last-tab")

-- SURROUND
-------------------------------------------------------------------
-- TODO: should be transeferred to mini.ai

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

-- INSERT-MODE
-------------------------------------------------------------------
-- assigned meta-keys
--  <M-@@>, @@ = [a,e,h,j,k,l,o,O,t,u,w]

-- h,j,k,l :: movement
-- o,O :: insert cursor below/above
-- a,e :: move cursor to start/end of the line
-- t :: move cirsor to the start of the character

-- shift key selection
-- starts selecting, but defaults to normal mode
keymap_set("i", "<S-Left>", "<C-c>v")
keymap_set("i", "<S-Right>", "<Right><C-c>v")

-- meta(alt) keys in insert and command line mode
-- *CAUTION*: not to use <M-D> !!!
keymap_set({ "i", "c" }, "<M-h>", "<Left>")
keymap_set({ "i", "c" }, "<M-j>", "<Down>")
keymap_set({ "i", "c" }, "<M-k>", "<Up>")
keymap_set({ "i", "c" }, "<M-l>", "<Right>")
keymap_set({ "i", "c" }, "<M-Left>", "<Left>")
keymap_set({ "i", "c" }, "<M-Right>", "<Right>")
keymap_set({ "i", "c" }, "<M-Up>", "<Up>")
keymap_set({ "i", "c" }, "<M-Down>", "<Down>")

-- meta keys only for insert mode
keymap_set("i", "<M-a>", "<C-o>^")
keymap_set("i", "<M-e>", "<C-o>$")
keymap_set("i", "<M-u>", "<C-o>d0")
keymap_set("i", "<M-w>", "<C-o>db")
keymap_set("i", "<M-Left>", "<C-o>^")
keymap_set("i", "<M-Right>", "<C-o>$")

-- meta keys for entering a new line
keymap_set("i", "<M-o>", "<C-o>o")
keymap_set("i", "<M-O>", "<C-o>O")

-- place the cursor infront of the character
-- use `<M-;>` and `<M-,>` for next/prev
keymap_set("i", "<M-t>", "<C-o>f")

-- ; and , in insert mode
keymap_set("i", "<M-;>", "<C-o>;")
keymap_set("i", "<M-,>", "<C-o>,")

-- meta key `s` to save/update and go to normal mode
keymap_set("i", "<M-s>", "<C-c>:update<CR>")

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

------------------------------------------------------------------
