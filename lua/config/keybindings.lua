-- lua/keybindings.lua

local helpers = require("config.helpers")
local tblx = require("core.tablex")

local config_dir = vim.fn.stdpath("config")
local data_dir = vim.fn.stdpath("data")
local state_dir = vim.fn.stdpath("state")
local keymap_set = require("config.helpers").keymap_set

local select = require("vim.treesitter._select")

-- LEADER KEY-BINDINGS
-------------------------------------------------------------------
--- NORMAL MODE
keymap_set("n", "<leader>;;", ":set ft?<cr>", "filetype")

keymap_set("n", "<leader>ag;", function()
    local ext = vim.fn.expand("%:e")
    local cmd = string.format("arga **/*.%s | arga *.%s", ext, ext)
    vim.cmd(cmd)
end, "argadd-current-ft-files")

keymap_set("n", "<leader>ag:", function()
    local ext = vim.fn.expand("%:e")
    local cmd = string.format("argd *.%s", ext)
    vim.cmd(cmd)
end, "argdel-current-ft-files")

keymap_set("n", "<leader>aga", ":argadd %<cr>", "argadd-cfile")
-- TODO: keymap_set("n", "<leader>agc", "", "cmd-to-argsadd")
-- TODO: keymap_set("n", "<leader>agC", "", "cmd-to-argsdel")
keymap_set("n", "<leader>agd", ":argdelete %<cr>", "argdel-cfile")
keymap_set("n", "<leader>agg", ":args<cr>", "show-args")
-- TODO: keymap_set("n", "<leader>agG", "", "argdo")

keymap_set("n", "<leader>agq", function()
    local qf = vim.fn.getqflist()
    local buflist = vim.tbl_map(function(item)
        return vim.api.nvim_buf_get_name(item.bufnr)
    end, qf)
    vim.api.nvim_cmd({ cmd = "arga", args = tblx.unique(buflist) }, {})
end, "argadd-qf-files")

-- TODO: keymap_set("n", "<leader>agQ", "", "argdel-qf-files")

-- TODO: keymap_set("n", "<leader>agQ", "", "argdelete-qf-files")
keymap_set("n", "<leader>agu", ":argdedupe<cr>", "unique-args")
keymap_set("n", "<leader>agx", ":argdelete *<cr>", "clear-args")

keymap_set("n", "<leader>b0", ":bfirst<cr>", "first-buffer")
keymap_set("n", "<leader>b1", ":1bnext<cr>", "buffer-1")
keymap_set("n", "<leader>b2", ":2bnext<cr>", "buffer-2")
keymap_set("n", "<leader>b3", ":3bnext<cr>", "buffer-3")
keymap_set("n", "<leader>b4", ":4bnext<cr>", "buffer-4")
keymap_set("n", "<leader>b5", ":5bnext<cr>", "buffer-5")
keymap_set("n", "<leader>b6", ":6bnext<cr>", "buffer-6")
keymap_set("n", "<leader>b7", ":7bnext<cr>", "buffer-7")
keymap_set("n", "<leader>b8", ":8bnext<cr>", "buffer-8")
keymap_set("n", "<leader>b9", ":blast<cr>", "last-buffer")
keymap_set("n", "<leader>bd", ":bd<cr>", "delete-buffer")
keymap_set("n", "<leader>bD", ":bd!<cr>", "DELETE-BUFFER")
keymap_set("n", "<leader>bh", ":bprevious<cr>", "prev-buffer")
keymap_set("n", "<leader>bH", ":bfirst<cr>", "last-buffer")
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
keymap_set("n", "<leader>bK", ":%bd | enew<cr>", "kill-all-buffers")
keymap_set("n", "<leader>bl", ":bnext<cr>", "next-buffer")
keymap_set("n", "<leader>bL", ":blast<cr>", "last-buffer")
keymap_set("n", "<leader>bp", ":bprevious<cr>", "prev-buffer")
keymap_set("n", "<leader>bn", ":bnext<cr>", "next-buffer")
keymap_set("n", "<leader>bN", ":enew<cr>", "new-buffer")
keymap_set("n", "<leader>bo", "%bd | e#<cr>", "only-current-buffer")
keymap_set("n", "<leader>bO", "%bd | e#<cr>", "only-current-buffer")
keymap_set("n", "<leader>bt", "<C-^>", "toggle-buffer")

-- TODO: `vars-buffer` in a buffer
keymap_set("n", "<leader>bv", function()
    vim.print(vim.fn.eval("b:"))
end, "vars-buffer")

keymap_set("n", "<leader>cm", ":make<cr>", "make-prg")

keymap_set("n", "<leader>eb", ":Runme<cr>", "eval-buffer")
keymap_set("n", "<leader>el", ":luafile %<cr>", "source-luafile")
keymap_set("n", "<leader>ev", ":source %<cr>", "source-vimfile")

keymap_set("n", "<leader>fa", ":e AGENTS.md<cr>", "AGENTS.md")
keymap_set("n", "<leader>fe", ":e .env<cr>", ".env")
keymap_set("n", "<leader>fi", ":e " .. config_dir .. "/lua/plugins/init.lua<cr>", "plugins/init.lua")
keymap_set("n", "<leader>fI", ":e " .. config_dir .. "/lua/config/init.lua<cr>", "config/init.lua")
keymap_set("n", "<leader>fll", ":e " .. state_dir .. "/lsp.log<cr>", "lsp.log")
keymap_set("n", "<leader>flr", ":e " .. data_dir .. "/rplugin.vim<cr>", "rplugin.vim")
keymap_set("n", "<leader>fr", ":e<cr>", "reload-file")
keymap_set("n", "<leader>fs", ":update<cr>", "save-file")
keymap_set("n", "<leader>fS", ":noautocmd w<cr>", "save-wo-format")
keymap_set("n", "<leader>fw", ":e " .. config_dir .. "/lua/config/keybindings.lua<cr>", "keybindings.lua")
keymap_set("n", "<leader>fx", ":! rm -f " .. state_dir .. "/swap/*<cr>", "delete-swap-files")
keymap_set("n", "<leader>fX", ":! rm -f " .. data_dir .. "/undodir/*<cr>", "delete-undo-files")

keymap_set("n", "<leader>gC", ":e .git/config<cr>", ".git/config")
keymap_set("n", "<leader>gE", ":e .git/info/exclude<cr>", ".git/info/exclude")
keymap_set("n", "<leader>gi", ":e .gitignore<cr>", ".gitignore")
-- TODO: `<leader>gly` to yank the last commit

keymap_set("n", "<leader>hc", ":checkhealth config<cr>", "check-config-health")
keymap_set("n", "<leader>hrr", ":echo '`emacs` command 🫠'<cr>", "n/a")
keymap_set("n", "<leader>hs", vim.lsp.buf.signature_help, "lsp-signature-help")

keymap_set("n", "<leader>ig", ":!pwd<cr>", "git-info")
keymap_set("n", "<leader>it", ":Inspect<cr>", "ts-inspect-element")
keymap_set("n", "<leader>iT", vim.treesitter.inspect_tree, "ts-inspect-tree")

keymap_set("n", "<leader>j0", ":tabfirst<cr>", "first-tab")
keymap_set("n", "<leader>j1", ":1tabnext<cr>", "tab-1")
keymap_set("n", "<leader>j2", ":2tabnext<cr>", "tab-2")
keymap_set("n", "<leader>j3", ":3tabnext<cr>", "tab-3")
keymap_set("n", "<leader>j4", ":4tabnext<cr>", "tab-4")
keymap_set("n", "<leader>j5", ":5tabnext<cr>", "tab-5")
keymap_set("n", "<leader>j6", ":6tabnext<cr>", "tab-6")
keymap_set("n", "<leader>j7", ":7tabnext<cr>", "tab-7")
keymap_set("n", "<leader>j8", ":8tabnext<cr>", "tab-8")
keymap_set("n", "<leader>j9", ":tablast<cr>", "last-tab")
keymap_set("n", "<leader>jH", ":tabfirst<cr>", "first-tab")
keymap_set("n", "<leader>jK", ":tabonly<cr>", "kill-other-than-current-tab")
keymap_set("n", "<leader>jh", ":-tabmove<cr>", "move-left")
keymap_set("n", "<leader>ji", ":tabs<cr>", "info-tabs")
keymap_set("n", "<leader>jk", ":tabclose<cr>", "kill-tab")
keymap_set("n", "<leader>jl", ":+tabmove<cr>", "move-right")
keymap_set("n", "<leader>jL", ":tablast<cr>", "last-tab")
keymap_set("n", "<leader>jn", ":tabnew<cr>", "new-tab")
keymap_set("n", "<leader>jo", ":tabonly<cr>", "only-current-tab")
keymap_set("n", "<leader>jO", ":tabonly<cr>", "only-current-tab")
keymap_set("n", "<leader>jv", function()
    vim.print(vim.fn.eval("t:"))
end, "vars-tab")

keymap_set("n", "<leader>l0", vim.lsp.buf.outgoing_calls, "lsp-outgoing-calls")
keymap_set("n", "<leader>l1", vim.lsp.buf.incoming_calls, "lsp-incoming-calls")
keymap_set("n", "<leader>la", vim.lsp.buf.code_action, "lsp-code-Actions")
keymap_set("n", "<leader>ld", vim.lsp.buf.declaration, "lsp-declaration")
keymap_set("n", "<leader>lD", vim.lsp.buf.definition, "lsp-definition")
keymap_set("n", "<leader>lf", vim.lsp.buf.references, "lsp-references")
keymap_set("n", "<leader>lh", vim.lsp.buf.hover, "hover-docs")
keymap_set("n", "<leader>li", vim.lsp.buf.implementation, "lsp-implementations")

keymap_set("n", "<leader>lk", function()
    select.select_parent(1)
end, "node-visual-select")

keymap_set("n", "<leader>ll", vim.diagnostic.open_float, "show-diagnostics")
keymap_set("n", "<leader>lq", vim.lsp.buf.workspace_symbol, "lsp-query-symbol")
keymap_set("n", "<leader>lr", vim.lsp.buf.rename, "lsp-rename")
-- TODO: `<leader>lR`, should "lsp-rename" only the references (outgoing)
keymap_set("n", "<leader>ls", vim.lsp.buf.signature_help, "lsp-signature")
keymap_set("n", "<leader>lt", vim.lsp.buf.type_definition, "lsp-goto-typedef")
keymap_set("n", "<leader>l/", vim.lsp.buf.typehierarchy, "lsp-typehierarchy")

keymap_set("n", "<leader>mlb", ":echo '`emacs` command 🫠'<cr>", "n/a")
keymap_set("n", "<leader>mlc", ":echo '`emacs` command 🫠'<cr>", "n/a")
keymap_set("n", "<leader>mle", ":echo '`emacs` command 🫠'<cr>", "n/a")
keymap_set("n", "<leader>mlf", ":echo '`emacs` command 🫠'<cr>", "n/a")
keymap_set("n", "<leader>mll", ":echo '`emacs` command 🫠'<cr>", "n/a")

keymap_set("n", "<leader>njj", ":echo '`emacs` command 🫠'<cr>", "n/a")
keymap_set("n", "<leader>nri", ":echo '`emacs` command 🫠'<cr>", "n/a")
keymap_set("n", "<leader>nrr", ":echo '`emacs` command 🫠'<cr>", "n/a")
keymap_set("n", "<leader>nrs", ":echo '`emacs` command 🫠'<cr>", "n/a")

keymap_set("n", "<leader>om", ":e Makefile<cr>", "makefile")
keymap_set("n", "<leader>on", ":messages<cr>", "messages")

keymap_set("n", "<leader>oz", function()
    local file = vim.fn.expand("%:p")
    local line = vim.api.nvim_win_get_cursor(0)[1]
    vim.fn.jobstart({ "zed", "--reuse", string.format("%s:%d", file, line) }, { detach = true })
end, "zed-at-cline")

keymap_set("n", "<leader>pc", ":e .nvim.lua<cr>", "config-project")
keymap_set("n", "<leader>pe", ":e http-client.private.env.json<cr>", "http-client.private.env.json")

keymap_set("n", "<leader>qa", ":qa<cr>", "quit-all")
keymap_set("n", "<leader>qd1", function()
    vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
end, "only-errors")
keymap_set("n", "<leader>qd2", function()
    vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.WARN })
end, "only-warnings")
keymap_set("n", "<leader>qd3", function()
    vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.INFO })
end, "only-info")
keymap_set("n", "<leader>qd4", function()
    vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.HINT })
end, "only-hints")
keymap_set("n", "<leader>qd5", function()
    vim.diagnostic.setqflist({
        severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN },
    })
end, "errors-and-warnings")
keymap_set("n", "<leader>qd6", function()
    vim.diagnostic.setqflist({
        severity = { vim.diagnostic.severity.INFO, vim.diagnostic.severity.HINT },
    })
end, "info-and-hints")
keymap_set("n", "<leader>qdd", vim.diagnostic.setqflist, "diagnostics-to-quickfix")
keymap_set("n", "<leader>qk", ":cclose<cr>", "close-quickfix")

keymap_set("n", "<leader>qld1", function()
    vim.diagnostic.setloclist({ severity = vim.diagnostic.severity.ERROR })
end, "only-errors")
keymap_set("n", "<leader>qld2", function()
    vim.diagnostic.setloclist({ severity = vim.diagnostic.severity.WARN })
end, "only-warnings")
keymap_set("n", "<leader>qld3", function()
    vim.diagnostic.setloclist({ severity = vim.diagnostic.severity.INFO })
end, "only-info")
keymap_set("n", "<leader>qld4", function()
    vim.diagnostic.setloclist({ severity = vim.diagnostic.severity.HINT })
end, "only-hints")
keymap_set("n", "<leader>qld5", function()
    vim.diagnostic.setloclist({
        severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN },
    })
end, "errors-and-warnings")
keymap_set("n", "<leader>qld6", function()
    vim.diagnostic.setloclist({
        severity = { vim.diagnostic.severity.INFO, vim.diagnostic.severity.HINT },
    })
end, "info-and-hints")
keymap_set("n", "<leader>qldd", vim.diagnostic.setloclist, "diagnostics-to-loclist")
keymap_set("n", "<leader>qlk", ":lclose<cr>", "close-loclist")
keymap_set("n", "<leader>qlo", ":lopen<cr>", "open-loclist")
keymap_set("n", "<leader>qlq", function()
    vim.fn.setqflist(vim.fn.getloclist(0))
end, "loclist-to-quickfix")
keymap_set("n", "<leader>qlx", function()
    vim.fn.setloclist(0, {})
    vim.cmd("lclose")
end, "clear-loclist")

keymap_set("n", "<leader>qo", ":copen<cr>", "open-quickfix")
keymap_set("n", "<leader>qr", ":echo '`emacs` command 🫠'<cr>", "n/a")
-- TODO: keymap_set("n", "<leader>qv", "", "visual-select-to-qf")
keymap_set("n", "<leader>qx", function()
    vim.fn.setqflist({})
    vim.cmd("cclose")
end, "clear-quickfix")

-- FIX: confirmation before reloading the file (when there are changes to save)
keymap_set("n", "<leader>rf", ":edit!<cr>", "reload-file")
keymap_set("n", "<leader>rp", ":UpdateRemotePlugins<cr>", "remote-plugins-reload")
keymap_set("n", "<leader>sp", "/\\%V", "pattern-in-visual-select")

-- TODO: while disabling, instead of switching diagnostics completely off,
-- turn off only the virtual text. Keep the diagnostic signs on
keymap_set("n", "<leader>td", function()
    local bufnr = vim.api.nvim_get_current_buf()
    local status = vim.diagnostic.is_enabled({ bufnr = bufnr })
    vim.diagnostic.enable(not status, { bufnr = bufnr })
    if status then
        vim.notify("diagnostics disabled for buffer " .. bufnr .. "!", vim.log.levels.INFO)
    else
        vim.notify("diagnostics enabled for buffer " .. bufnr .. "!", vim.log.levels.INFO)
    end
end, "diagnostics")
keymap_set("n", "<leader>tD", helpers.toggle_autocmd_debug, "debug-autocmds")
keymap_set("n", "<leader>tf", "zi", "folds")
keymap_set("n", "<leader>tG", ":%norm! g??<cr>", "gibberish-rot13")
keymap_set("n", "<leader>th", ":set hls!<cr>", "hl-search")
keymap_set("n", "<leader>ti", ":setl list!<cr>", "indent-guide")
keymap_set("n", "<leader>tn", ":setl nu! rnu!<cr>", "line-numbers")
keymap_set("n", "<leader>tr", ":setl ro!<cr>", "read-only")
keymap_set("n", "<leader>ts", ":setl spell!<cr>", "spell-check")
keymap_set("n", "<leader>tw", ":setl nowrap! linebreak breakindent<cr>", "wrap-text")

-- TODO: `vars-global` in a buffer
keymap_set("n", "<leader>vG", function()
    vim.print(vim.fn.eval("g:"))
end, "vars-global")

-- TODO: `<leader>w{1-5}` and `<C-w>{1-5}` to switch between windows
keymap_set("n", "<leader>w6", ":wincmd +<cr>", "increase-height")
keymap_set("n", "<leader>w7", ":wincmd -<cr>", "decrease-height")
keymap_set("n", "<leader>w9", ":wincmd <<cr>", "decrease-width")
keymap_set("n", "<leader>w0", ":wincmd ><cr>", "increase-width")
keymap_set("n", "<leader>w=", ":wincmd =<cr>", "equalize-window")
keymap_set("n", "<leader>wc", ":wincmd c<cr>", "close-window")
keymap_set("n", "<leader>wh", ":wincmd H<cr>", "window-to-left")
keymap_set("n", "<leader>wj", ":wincmd J<cr>", "window-to-bottom")
keymap_set("n", "<leader>wk", ":wincmd K<cr>", "window-to-top")
keymap_set("n", "<leader>wl", ":wincmd L<cr>", "window-to-right")
keymap_set("n", "<leader>wm", ":wincmd |<cr>", "maximize-window-width")
keymap_set("n", "<leader>wM", ":wincmd _<cr>", "maximize-window-height")
keymap_set("n", "<leader>wn", ":new<cr>", "new-window")
keymap_set("n", "<leader>wo", ":only<cr>", "only-current-window")
keymap_set("n", "<leader>wO", ":only<cr>", "only-current-window")
keymap_set("n", "<leader>wq", ":wincmd q<cr>", "quit-window")
keymap_set("n", "<leader>ws", ":wincmd s<cr>", "split-window-below")
keymap_set("n", "<leader>wv", ":wincmd v<cr>", "split-window-right")
keymap_set("n", "<leader>wV", function()
    vim.print(vim.fn.eval("w:"))
end, "vars-window")
keymap_set("n", "<leader>ww", ":wincmd w<cr>", "switch-window")
keymap_set("n", "<leader>wx", ":wincmd x<cr>", "swap-window")
keymap_set("n", "<leader>w|", ":wincmd <<cr>", "max-out-width")

keymap_set("n", "<leader>xm", ":messages clear<cr>", "clear-messages")
-- TODO: `<leader>xU` to delete file's undo history

-------------------------------------------------------------------
--- VISUAL MODE

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

-- TODO: do git operation for visual-select, not hunks
-- keymap_set("x", "<leader>gs", "", "stage-select")
-- keymap_set("x", "<leader>gu", "", "unstage-select")
-- keymap_set("x", "<leader>gR", "", "git-reset-select")

keymap_set("x", "<leader>sq", HP.SaveVisualSelection, "save-vselect-as-file")
keymap_set("x", "<leader>tG", "g?", "gibberish-rot13")

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
-- [a] args chain
keymap_set("n", "[a", ":prev<cr>", "prev-arg")
keymap_set("n", "]a", ":next<cr>", "next-arg")
keymap_set("n", "[A", ":first<cr>", "first-arg")
keymap_set("n", "]A", ":last<cr>", "last-arg")

-- [b] buffer chain
keymap_set("n", "[b", ":bprevious<cr>", "prev-buffer")
keymap_set("n", "]b", ":bnext<cr>", "next-buffer")
keymap_set("n", "[B", ":bfirst<cr>", "first-buffer")
keymap_set("n", "]B", ":blast<cr>", "last-buffer")

-- [d] diagnostic chain
keymap_set("n", "]d", function()
    vim.diagnostic.jump({ count = 1, float = true })
end, "next-diagnostic")

keymap_set("n", "[d", function()
    vim.diagnostic.jump({ count = -1, float = true })
end, "prev-diagnostic")

-- [j] tab chain
keymap_set("n", "[j", ":tabprevious<cr>", "prev-tab")
keymap_set("n", "]j", ":tabnext<cr>", "next-tab")
keymap_set("n", "[J", ":tabfirst<cr>", "first-tab")
keymap_set("n", "]J", ":tablast<cr>", "last-tab")

-- TODO: keymap_set("x", "]d", "", "next-diagnostic")

-- TERMINAL
-------------------------------------------------------------------
-- toggle to normal-mode from terminal-mode (inside terminal)
-- to switch back, use `i` (back in terminal mode, inside terminal)
keymap_set("t", "<M-n>", "<C-\\><C-N>", "term-to-normal mode")

-- SWITCHING TABS (alias to `<leader>j<num>`)
keymap_set("n", ",0", ":tabfirst<cr>", "first-tab")
keymap_set("n", ",1", ":1tabnext<cr>", "tab-1")
keymap_set("n", ",2", ":2tabnext<cr>", "tab-2")
keymap_set("n", ",3", ":3tabnext<cr>", "tab-3")
keymap_set("n", ",4", ":4tabnext<cr>", "tab-4")
keymap_set("n", ",5", ":5tabnext<cr>", "tab-5")
keymap_set("n", ",6", ":6tabnext<cr>", "tab-6")
keymap_set("n", ",7", ":7tabnext<cr>", "tab-7")
keymap_set("n", ",8", ":8tabnext<cr>", "tab-8")
keymap_set("n", ",9", ":tablast<cr>", "last-tab")

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
keymap_set("n", "<M-s>", ":update<cr>")

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
keymap_set("i", "<M-s>", "<C-c>:update<cr>")

-- CLIPBOARD
-------------------------------------------------------------------
-- format: <leader> (+) [a]ction (+) {{ [c]opy | [x]cut | [v]paste [q]macro-replay }} (+) register
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

    -- Replay as macros
    keymap_set("n", "<leader>a" .. "q" .. r, ":norm @" .. r .. "<cr>")
    keymap_set("v", "<leader>a" .. "q" .. r, ":norm @" .. r .. "<cr>")
end

------------------------------------------------------------------
