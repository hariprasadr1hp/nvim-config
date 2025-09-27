-- lua/settings.lua

-- speed: vim.o > vim.opt > vim.cmd
-- `vim.o` for vim defaults,
-- `vim.opt` for lua syntax support
-- `vim.cmd` for only native-support

-- NETRW
-------------------------------------------------------------------
-- disable netrw at the very start
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- LEADER KEYS
-------------------------------------------------------------------
-- NOTE: Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.

vim.api.nvim_set_keymap("n", "<Space>", "<NOP>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- SEARCH
-------------------------------------------------------------------
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- Make substitution work in realtime (preview)
--vim.o.inccommand = "split"

vim.o.grepformat = "%f:%l:%c:%m"
vim.o.grepprg = "rg --vimgrep -uu"

-- INDENTATION
-------------------------------------------------------------------
-- insert 4 spaces for a tab
vim.o.tabstop = 4
vim.o.softtabstop = 4

-- change the number of space characters inserted for indentation
vim.o.shiftwidth = 4

-- converts tabs to spaces (if true)
vim.o.expandtab = true

-- auto-indent within brackets (if true)
vim.o.smartindent = true

-- MOUSE
-------------------------------------------------------------------
-- enabling mouse
vim.o.mouse = "a"

-- EDITOR
-------------------------------------------------------------------
-- relative numbering
vim.o.number = true
vim.o.relativenumber = true

-- display long lines as just one line
vim.o.wrap = false

-- when wrapped, do not hyphenate words
vim.o.linebreak = true

-- WINDOWS
-------------------------------------------------------------------
-- horizontal splits will automatically be below
vim.o.splitbelow = true

-- vertical splits will automatically be to the right
vim.o.splitright = true

-- GUI
-------------------------------------------------------------------
vim.o.errorbells = false

-- cursor (turn-off blinking)
vim.opt.guicursor = {
    "n-v-c-sm:block",
    "i-ci-ve:ver25",
    "r-cr:hor20",
    "o:hor50",
    "t:block-TermCursor",
}

-- using `vim.cmd` since lua support is not available
vim.cmd("syntax on")

-- set term gui colors (most terminals support 256 colors)
vim.opt.termguicolors = true

-- highlight cursor line
vim.opt.cursorline = false

-- colorschemes that can be light or dark will default to dark
---@type "dark" | "light"
vim.opt.background = "dark"

-- enable showing whitespace characters
vim.o.list = false

-- configure characters for spaces and other whitespace
vim.opt.listchars = {
    space = "·",
    tab = "→ ",
    trail = "•",
    extends = "❯",
    precedes = "❮",
    nbsp = "␣",
    -- eol = "↲",
}

-- always show the signcolumn, otherwise it would shift the text each time
vim.o.signcolumn = "yes:1"

-- required to keep multiple buffers open multiple buffers
vim.o.hidden = true

-- to see `` in markdown files (no pretty mode)
vim.o.conceallevel = 0

-- providing support for various icons (https://www.nerdfonts.com/)
vim.g.have_nerd_font = true

-- never scroll-off to less than `n` characters to the bottom,
-- unless it's the end of the file
vim.opt.scrolloff = 8

-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3

-- add a trailing newline at the end of the file
vim.opt.fixendofline = false

-- highlighted yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.hl.on_yank({
            higroup = "Visual",
            timeout = 300,
        })
    end,
})

-- add border to windows
vim.opt.winborder = "rounded"

-- COMPLETION
-------------------------------------------------------------------
-- Faster completion
vim.o.updatetime = 300

vim.o.completeopt = "menuone,noselect"

-- By default timeout length is 1000 ms
vim.o.timeoutlen = 500

-- Don't pass short messages to |ins-completion-menu|. refer `:h shortmess`
-- vim.opt.shortmess:append("c")

-- BACKUP
-------------------------------------------------------------------
-- recommended by coc
vim.o.backup = false
vim.o.writebackup = false

-- undodir
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.o.undofile = true

-- DICTIONARY
-------------------------------------------------------------------
-- set a dictionary file
vim.o.spelllang = "en"
vim.o.dictionary = "/usr/share/dict/american-english"

-- STARTUP
-------------------------------------------------------------------
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        if vim.fn.argc() == 0 then
            vim.cmd("enew")
        end
    end,
})

-- SHELL
-------------------------------------------------------------------
-- only set shell if it exists
local bash_path = "/opt/homebrew/bin/bash"

if vim.fn.has("mac") == 1 and vim.fn.executable(bash_path) == 1 then
    vim.opt.shell = bash_path
end

-- LOCAL CONFIG
-------------------------------------------------------------------
-- to read local project configuration inside `.nvim.lua` or `.exrc`
vim.opt.exrc = true
vim.opt.secure = true

-- CODING
-------------------------------------------------------------------
if vim.fn.has("linux") == 1 then
    vim.g.python3_host_prog = "~/.pyenv/shims/python"
elseif vim.fn.has("macunix") == 1 then
    vim.g.python3_host_prog = "~/.pyenv/shims/python"
end

-- MISCELLANEOUS
-------------------------------------------------------------------
-- treat dash separated words as a word text object"
--vim.opt.iskeyword:append("-")

-- Copy paste between vim and everything else
vim.o.clipboard = "unnamedplus"

-- CUSTOM MESSAGES
-------------------------------------------------------------------
-- vim.api.nvim_command("highlight InfoMsg guifg=#00ff00 guibg=NONE")

-------------------------------------------------------------------
