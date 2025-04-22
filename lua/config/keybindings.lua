-- lua/keybindings.lua

-- TODO: transfer the remaining keybindings from vimscript to lua

local map = vim.keymap.set
local key_opts = { noremap = true, silent = true }

-- BASIC SETUP
-------------------------------------------------------------------
-- `Y` yanks till the end of the line from the cursor
map("n", "Y", "y$", key_opts)

-- g chords
map("n", "g2", "@", key_opts)
map("n", "g3", "#", key_opts)
map("n", "g4", "$", key_opts)
map("n", "g5", "%", key_opts)
map("n", "g6", "^", key_opts)
map("n", "g9", "g$", key_opts)
map("n", "g/", "/\\v", key_opts)

-- continued visual selection while indenting
map("v", "<", "<gv", key_opts)
map("v", ">", ">gv", key_opts)

-- continued visual selection while counting
map("v", "<C-a>", "<C-a>gv", key_opts)
map("v", "<C-x>", "<C-x>gv", key_opts)

-- buffer chain
map("n", "[b", ":bprevious<CR>", key_opts)
map("n", "]b", ":bnext<CR>", key_opts)
map("n", "[B", ":bfirst<CR>", key_opts)
map("n", "]B", ":blast<CR>", key_opts)

-- tab chain
map("n", "[j", ":tabprevious<CR>", key_opts)
map("n", "]j", ":tabnext<CR>", key_opts)
map("n", "[J", ":tabfirst<CR>", key_opts)
map("n", "]J", ":tablast<CR>", key_opts)

-- alias for 'escape' to NORMAL from INSERT
-- inoremap klk <Esc>

-- Move selected line / block of text in visual mode
-- shift + k to move up
-- shift + j to move down
map("x", "J", "move '<+1<CR>gv-gv", key_opts)
map("x", "K", "move '<-2<CR>gv-gv", key_opts)

-- move lines using 'Alt', vscode-like
map("n", "<M-Up>", ":move -2<CR>", key_opts)
map("n", "<M-Down>", "move +1<CR>", key_opts)

-- visually select text for searching, mapped to //
-- using \V (no-magic)
map("x", "//", [[y/\V<C-R>=escape(@", '/\')<CR><CR>]], key_opts)

-- `bn` as escape characters
map("i", "bn", "<Esc>", key_opts)

-- TERMINAL
-------------------------------------------------------------------
-- toggle to normal-mode from terminal-mode (inside terminal)
-- to switch back, use `i` (back in terminal mode, inside terminal)
map("t", "<M-n>", "<C-\\><C-N>", key_opts)

-- SURROUND
-------------------------------------------------------------------
-- TODO: should be transeferred to mini.ai

-- `d` for double quotess
map("n", "cad", 'ca"', key_opts)
map("n", "cid", 'ci"', key_opts)
map("n", "dad", 'da"', key_opts)
map("n", "did", 'di"', key_opts)
map("n", "vad", 'va"', key_opts)
map("n", "vid", 'vi"', key_opts)
map("n", "yad", 'ya"', key_opts)
map("n", "yid", 'yi"', key_opts)

-- `q` for single quotes
map("n", "caq", "ca'", key_opts)
map("n", "ciq", "ci'", key_opts)
map("n", "daq", "da'", key_opts)
map("n", "diq", "di'", key_opts)
map("n", "vaq", "va'", key_opts)
map("n", "viq", "vi'", key_opts)
map("n", "yaq", "ya'", key_opts)
map("n", "yiq", "yi'", key_opts)

-- `x` for backticks
map("n", "cax", "ca`", key_opts)
map("n", "cix", "ci`", key_opts)
map("n", "dax", "da`", key_opts)
map("n", "dix", "di`", key_opts)
map("n", "vax", "va`", key_opts)
map("n", "vix", "vi`", key_opts)
map("n", "yax", "ya`", key_opts)
map("n", "yix", "yi`", key_opts)

-- META-KEYS
-------------------------------------------------------------------
map("n", "<M-s>", ":update<CR>", key_opts)

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
map("i", "<S-Left>", "<C-c>v", key_opts)
map("i", "<S-Right>", "<Right><C-c>v", key_opts)

-- meta(alt) keys in insert and command line mode
-- *CAUTION*: not to use <M-D> !!!
map({ "i", "c" }, "<M-h>", "<Left>", key_opts)
map({ "i", "c" }, "<M-j>", "<Down>", key_opts)
map({ "i", "c" }, "<M-k>", "<Up>", key_opts)
map({ "i", "c" }, "<M-l>", "<Right>", key_opts)
map({ "i", "c" }, "<M-Left>", "<Left>", key_opts)
map({ "i", "c" }, "<M-Right>", "<Right>", key_opts)
map({ "i", "c" }, "<M-Up>", "<Up>", key_opts)
map({ "i", "c" }, "<M-Down>", "<Down>", key_opts)

-- meta keys only for insert mode
map("i", "<M-a>", "<C-o>^", key_opts)
map("i", "<M-e>", "<C-o>$", key_opts)
map("i", "<M-u>", "<C-o>d0", key_opts)
map("i", "<M-w>", "<C-o>db", key_opts)
map("i", "<M-Left>", "<C-o>^", key_opts)
map("i", "<M-Right>", "<C-o>$", key_opts)

-- meta keys for entering a new line
map("i", "<M-o>", "<C-o>o", key_opts)
map("i", "<M-O>", "<C-o>O", key_opts)

-- place the cursor infront of the character
-- use `<M-;>` and `<M-,>` for next/prev
map("i", "<M-t>", "<C-o>f", key_opts)

-- ; and , in insert mode
map("i", "<M-;>", "<C-o>;", key_opts)
map("i", "<M-,>", "<C-o>,", key_opts)

-- meta key `s` to save/update and go to normal mode
map("i", "<M-s>", "<C-c>:update<CR>", key_opts)

-- CLIPBOARD
-------------------------------------------------------------------
-- format: <leader> (+) [a]ction (+) {{ [c]opy | [x]cut | [v]paste }} (+) register
-- ex: `<leader>acf` copies (c) contents to the register `f`

-- Basic mappings
map("n", "<leader>avv", "+P", key_opts)
map("n", "<leader>acc", 'V"+y', key_opts)
map("n", "<leader>axx", 'V"+d', key_opts)
map("v", "<leader>avv", "+P", key_opts)
map("v", "<leader>acc", '"+y', key_opts)
map("v", "<leader>axx", '"+d', key_opts)

-- Default register ("-)
map("n", "<leader>a-x", '"-d', key_opts)
map("v", "<leader>a-x", '"-d', key_opts)
map("n", "<leader>a-c", '"-y', key_opts)
map("v", "<leader>a-c", '"-y', key_opts)
map("n", "<leader>a-v", '"-P', key_opts)
map("v", "<leader>a-v", '"-P', key_opts)

-- Registers 0-9 and specials
local reg_keys = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-" }
for _, r in ipairs(reg_keys) do
    map("n", "<leader>a" .. "v" .. r, '"' .. r .. "P", key_opts)
    map("v", "<leader>a" .. "v" .. r, '"' .. r .. "P", key_opts)
end

-- Registers a-z and A-Z (except 'xcvXCV')
for _, r in
    ipairs(
        vim.fn.split("a,b,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,w,y,z,A,B,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,W,Y,Z", ",")
    )
do
    map("n", "<leader>a" .. "c" .. r, 'V"' .. r .. "y", key_opts)
    map("v", "<leader>a" .. "c" .. r, '"' .. r .. "y", key_opts)
    map("n", "<leader>a" .. "x" .. r, 'V"' .. r .. "d", key_opts)
    map("v", "<leader>a" .. "x" .. r, '"' .. r .. "d", key_opts)
    map("n", "<leader>a" .. "v" .. r, '"' .. r .. "P", key_opts)
    map("v", "<leader>a" .. "v" .. r, '"' .. r .. "P", key_opts)
end

-------------------------------------------------------------------
