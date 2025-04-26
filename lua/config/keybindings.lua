-- lua/keybindings.lua

-- TODO: transfer the remaining keybindings from vimscript to lua

local config_dir = vim.fn.stdpath("config")
local data_dir = vim.fn.stdpath("data")
local state_dir = vim.fn.stdpath("state")
local map = require("config.helpers").map

-- LEADER KEY-BINDINGS
-------------------------------------------------------------------
map("n", "<leader>bd", ":bd<CR>", "delete-buffer")
map("n", "<leader>bf", ":bfirst<CR>", "first-buffer")
map("n", "<leader>bk", ":bp | bd #<CR>", "kill-buffer")
map("n", "<leader>bK", ":%bd | enew<CR>", "kill-all-buffers")
map("n", "<leader>bl", ":blast<CR>", "last-buffer")
map("n", "<leader>bp", ":bprevious<CR>", "prev-buffer")
map("n", "<leader>bn", ":bnext<CR>", "next-buffer")
map("n", "<leader>bO", "%bd | e#<CR>", "only-buffer")
map("n", "<leader>bt", "<C-^>", "toggle-buffer")

map("n", "<leader>eb", ":Runme<CR>", "eval-buffer")
map("n", "<leader>el", ":luafile %<CR>", "source-luafile")
map("n", "<leader>ev", ":source %<CR>", "source-vimfile")

map("n", "<leader>fi", ":e " .. config_dir .. "/lua/plugins/init.lua<CR>")
map("n", "<leader>fl", ":e " .. config_dir .. "/lua/plugins/lspconfig.lua<CR>")
map("n", "<leader>fr", ":e<CR>", "reload-file")
map("n", "<leader>fs", ":update<CR>")
map("n", "<leader>fw", ":e " .. config_dir .. "/lua/config/keybindings.lua<CR>")
map("n", "<leader>fx", ":! rm -f" .. state_dir .. "/swap/*<CR>", "delete-swap-files")
map("n", "<leader>fX", ":! rm -f" .. data_dir .. "/undodir/*<CR>", "delete-undo-files")

map("n", "<leader>hrr", ":echo '`emacs` command 🫠'<CR>")
map("n", "<leader>hs", vim.lsp.buf.signature_help, "lsp-signature-help")

map("n", "<leader>it", ":Inspect<CR>", "ts-inspect-element")
map("n", "<leader>iT", vim.treesitter.inspect_tree, "ts-inspect-tree")

map("n", "<leader>j0", ":tabfirst<CR>", "first-tab")
map("n", "<leader>j1", ":1tabnext<CR>", "tab-1")
map("n", "<leader>j2", ":2tabnext<CR>", "tab-2")
map("n", "<leader>j3", ":3tabnext<CR>", "tab-3")
map("n", "<leader>j4", ":4tabnext<CR>", "tab-4")
map("n", "<leader>j5", ":5tabnext<CR>", "tab-5")
map("n", "<leader>j6", ":6tabnext<CR>", "tab-6")
map("n", "<leader>j7", ":7tabnext<CR>", "tab-7")
map("n", "<leader>j8", ":8tabnext<CR>", "tab-8")
map("n", "<leader>j9", ":tablast<CR>", "last-tab")
map("n", "<leader>jK", ":tabonly<CR>", "kill-other-than-current-tab")
map("n", "<leader>jh", ":-tabmove<CR>", "move-left")
map("n", "<leader>ji", ":tabs<CR>", "info-tabs")
map("n", "<leader>jk", ":tabclose<CR>", "kill-tab")
map("n", "<leader>jl", ":+tabmove<CR>", "move-right")
map("n", "<leader>jn", ":tabnew<CR>", "new-tab")
map("n", "<leader>jO", ":tabonly<CR>", "only-current-tab")

map("n", "<leader>la", vim.lsp.buf.code_action, "code-action")
map("n", "<leader>ld", vim.lsp.buf.definition, "definition")
map("n", "<leader>le", ":Inspect<CR>", "ts-inspect-element")
map("n", "<leader>lh", vim.lsp.buf.hover, "hover-docs")
map("n", "<leader>li", vim.treesitter.inspect_tree, "ts-inspect-tree")
map("n", "<leader>ll", vim.diagnostic.open_float, "hover-docs")
map("n", "<leader>lr", vim.lsp.buf.rename, "lsp-rename")
map("n", "<leader>ls", vim.lsp.buf.signature_help, "lsp-signature")
map("n", "<leader>lt", vim.lsp.buf.type_definition, "goto-typedef")
map("n", "<leader>lx", ":lclose<CR>", "close-loclist")

map("n", "<leader>mll", ":echo '`emacs` command 🫠'<CR>")
map("n", "<leader>mlt", ":echo '`emacs` command 🫠'<CR>")

map("n", "<leader>om", ":e Makefile<CR>", "makefile")
map("n", "<leader>on", ":messages<CR>", "notifications")

map("n", "<leader>njj", ":echo '`emacs` command 🫠'<CR>")
map("n", "<leader>nri", ":echo '`emacs` command 🫠'<CR>")
map("n", "<leader>nrr", ":echo '`emacs` command 🫠'<CR>")
map("n", "<leader>nrs", ":echo '`emacs` command 🫠'<CR>")
map("n", "<leader>ns", ":echo '`emacs` command 🫠'<CR>")

map("n", "<leader>qx", ":cclose<CR>", "close-quickfix")
map("n", "<leader>qk", ":cclose<CR>", "close-quickfix")
map("n", "<leader>qo", ":copen<CR>", "open-quickfix")
map("n", "<leader>qr", ":luafile " .. config_dir .. "/init.lua<CR>")

map("n", "<leader>tG", ":%norm! g??<CR>", "gibberish-rot13")
map("n", "<leader>th", ":set hls!<CR>", "hl-search")
map("n", "<leader>tn", ":setl nu! rnu!<CR>", "line-numbers")
map("n", "<leader>tr", ":setl ro!<CR>", "read-only")
map("n", "<leader>ts", ":setl spell!<CR>", "spell-check")
map("n", "<leader>tT", ":highlight Normal guibg=black<CR>", "bg-black")
map("n", "<leader>tw", ":setl nowrap! linebreak breakindent<CR>", "wrap-text")

map("n", "<leader>w6", ":wincmd +<CR>", "increase-height")
map("n", "<leader>w7", ":wincmd -<CR>", "decrease-height")
map("n", "<leader>w9", ":wincmd <<CR>", "decrease-width")
map("n", "<leader>w0", ":wincmd ><CR>", "increase-width")
map("n", "<leader>w=", ":wincmd =<CR>", "equalize-window")
map("n", "<leader>wc", ":wincmd c<CR>", "close-window")
map("n", "<leader>wh", ":wincmd H<CR>", "window-to-left")
map("n", "<leader>wj", ":wincmd J<CR>", "window-to-bottom")
map("n", "<leader>wk", ":wincmd K<CR>", "window-to-top")
map("n", "<leader>wl", ":wincmd L<CR>", "window-to-right")
map("n", "<leader>wm", ":wincmd |<CR>", "maximize-window")
map("n", "<leader>wn", ":new<CR>", "new-window")
map("n", "<leader>wO", ":only<CR>", "only-current-window")
map("n", "<leader>wq", ":wincmd q<CR>", "quit-window")
map("n", "<leader>ws", ":wincmd s<CR>", "split-window-below")
map("n", "<leader>wv", ":wincmd v<CR>", "split-window-right")
map("n", "<leader>ww", ":wincmd w<CR>", "switch-window")
map("n", "<leader>wx", ":wincmd x<CR>", "swap-window")
map("n", "<leader>w|", ":wincmd <<CR>", "max-out-width")

map("x", "<leader>tG", "g?", "gibberish-rot13")

-- SANE DEFAULTS
-------------------------------------------------------------------
-- `vim.lsp`
map("n", "g.", vim.lsp.buf.code_action, "code-action")
map("n", "gA", vim.lsp.buf.code_action, "code-action")
map("n", "gd", vim.lsp.buf.definition, "definition")
map("n", "gD", vim.lsp.buf.declaration, "declararion")
map("n", "gr", vim.lsp.buf.references, "references")
map("n", "gI", vim.lsp.buf.implementation, "implementation")
map("n", "gt", vim.lsp.buf.type_definition, "goto-typedef")
map("n", "K", vim.lsp.buf.hover, "hover-docs")

-- `Y` yanks till the end of the line from the cursor
map("n", "Y", "y$")

-- g chords
map("n", "g2", "@")
map("n", "g3", "#")
map("n", "g4", "$")
map("n", "g5", "%")
map("n", "g6", "^")
map("n", "g9", "g$")
map("n", "g/", "/\\v")

-- continued visual selection while indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- continued visual selection while counting
map("v", "<C-a>", "<C-a>gv")
map("v", "<C-x>", "<C-x>gv")

-- window settings
map("n", "<C-w>m", "<C-w>|")

-- alias for 'escape' to NORMAL from INSERT
-- inoremap klk <Esc>

-- Move selected line / block of text in visual mode
-- shift + k to move up
-- shift + j to move down
map("x", "J", "move '<+1<CR>gv-gv", "move-select-lines-down")
map("x", "K", "move '<-2<CR>gv-gv", "move-select-lines-up")

-- visually select text for searching, mapped to //
-- using \V (no-magic)
map("x", "//", [[y/\V<C-R>=escape(@", '/\')<CR><CR>]], "search-selected")

-- `bn` as escape characters
map("i", "bn", "<Esc>", "to-normal-mode")

-- JUMPS
-------------------------------------------------------------------
-- [b] buffer chain
map("n", "[b", ":bprevious<CR>", "prev-buffer")
map("n", "]b", ":bnext<CR>", "next-buffer")
map("n", "[B", ":bfirst<CR>", "first-buffer")
map("n", "]B", ":blast<CR>", "last-buffer")

-- [d] diagnostic chain
map("n", "]d", function()
    vim.diagnostic.jump({ count = 1, float = true })
end, "next-diagnostic")

map("n", "[d", function()
    vim.diagnostic.jump({ count = -1, float = true })
end, "prev-diagnostic")

-- [j] tab chain
map("n", "[j", ":tabprevious<CR>", "prev-tab")
map("n", "]j", ":tabnext<CR>", "next-tab")
map("n", "[J", ":tabfirst<CR>", "first-tab")
map("n", "]J", ":tablast<CR>", "last-tab")

-- TERMINAL
-------------------------------------------------------------------
-- toggle to normal-mode from terminal-mode (inside terminal)
-- to switch back, use `i` (back in terminal mode, inside terminal)
map("t", "<M-n>", "<C-\\><C-N>", "term-to-normal mode")

-- SURROUND
-------------------------------------------------------------------
-- TODO: should be transeferred to mini.ai

-- `d` for double quotess
map("n", "cad", 'ca"')
map("n", "cid", 'ci"')
map("n", "dad", 'da"')
map("n", "did", 'di"')
map("n", "vad", 'va"')
map("n", "vid", 'vi"')
map("n", "yad", 'ya"')
map("n", "yid", 'yi"')

-- `q` for single quotes
map("n", "caq", "ca'")
map("n", "ciq", "ci'")
map("n", "daq", "da'")
map("n", "diq", "di'")
map("n", "vaq", "va'")
map("n", "viq", "vi'")
map("n", "yaq", "ya'")
map("n", "yiq", "yi'")

-- `x` for backticks
map("n", "cax", "ca`")
map("n", "cix", "ci`")
map("n", "dax", "da`")
map("n", "dix", "di`")
map("n", "vax", "va`")
map("n", "vix", "vi`")
map("n", "yax", "ya`")
map("n", "yix", "yi`")

-- META-KEYS
-------------------------------------------------------------------
map("n", "<M-s>", ":update<CR>")

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
map("i", "<S-Left>", "<C-c>v")
map("i", "<S-Right>", "<Right><C-c>v")

-- meta(alt) keys in insert and command line mode
-- *CAUTION*: not to use <M-D> !!!
map({ "i", "c" }, "<M-h>", "<Left>")
map({ "i", "c" }, "<M-j>", "<Down>")
map({ "i", "c" }, "<M-k>", "<Up>")
map({ "i", "c" }, "<M-l>", "<Right>")
map({ "i", "c" }, "<M-Left>", "<Left>")
map({ "i", "c" }, "<M-Right>", "<Right>")
map({ "i", "c" }, "<M-Up>", "<Up>")
map({ "i", "c" }, "<M-Down>", "<Down>")

-- meta keys only for insert mode
map("i", "<M-a>", "<C-o>^")
map("i", "<M-e>", "<C-o>$")
map("i", "<M-u>", "<C-o>d0")
map("i", "<M-w>", "<C-o>db")
map("i", "<M-Left>", "<C-o>^")
map("i", "<M-Right>", "<C-o>$")

-- meta keys for entering a new line
map("i", "<M-o>", "<C-o>o")
map("i", "<M-O>", "<C-o>O")

-- place the cursor infront of the character
-- use `<M-;>` and `<M-,>` for next/prev
map("i", "<M-t>", "<C-o>f")

-- ; and , in insert mode
map("i", "<M-;>", "<C-o>;")
map("i", "<M-,>", "<C-o>,")

-- meta key `s` to save/update and go to normal mode
map("i", "<M-s>", "<C-c>:update<CR>")

-- CLIPBOARD
-------------------------------------------------------------------
-- format: <leader> (+) [a]ction (+) {{ [c]opy | [x]cut | [v]paste }} (+) register
-- ex: `<leader>acf` copies (c) contents to the register `f`

-- Basic mappings
map("n", "<leader>avv", "+P")
map("n", "<leader>acc", 'V"+y')
map("n", "<leader>axx", 'V"+d')
map("v", "<leader>avv", "+P")
map("v", "<leader>acc", '"+y')
map("v", "<leader>axx", '"+d')

-- Default register ("-)
map("n", "<leader>a-x", '"-d')
map("v", "<leader>a-x", '"-d')
map("n", "<leader>a-c", '"-y')
map("v", "<leader>a-c", '"-y')
map("n", "<leader>a-v", '"-P')
map("v", "<leader>a-v", '"-P')

-- Registers 0-9 and specials
local reg_keys = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-" }
for _, r in ipairs(reg_keys) do
    map("n", "<leader>a" .. "v" .. r, '"' .. r .. "P")
    map("v", "<leader>a" .. "v" .. r, '"' .. r .. "P")
end

-- Registers a-z and A-Z (except 'xcvXCV')
for _, r in
    ipairs(
        vim.fn.split("a,b,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,w,y,z,A,B,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,W,Y,Z", ",")
    )
do
    map("n", "<leader>a" .. "c" .. r, 'V"' .. r .. "y")
    map("v", "<leader>a" .. "c" .. r, '"' .. r .. "y")
    map("n", "<leader>a" .. "x" .. r, 'V"' .. r .. "d")
    map("v", "<leader>a" .. "x" .. r, '"' .. r .. "d")
    map("n", "<leader>a" .. "v" .. r, '"' .. r .. "P")
    map("v", "<leader>a" .. "v" .. r, '"' .. r .. "P")
end

------------------------------------------------------------------
