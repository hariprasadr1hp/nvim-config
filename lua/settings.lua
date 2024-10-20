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

-- GUI
-------------------------------------------------------------------
vim.o.errorbells = false

-- COLORS
-------------------------------------------------------------------
-- using `vim.cmd` since lua support is not available
vim.cmd("syntax on")

-- set term gui colors (most terminals support 256 colors)
vim.opt.termguicolors = true

-- enable showing whitespace characters
vim.o.list = true

-- configure characters for spaces and other whitespace
vim.o.listchars = "space:·,tab:→ "

-- SEARCH
-------------------------------------------------------------------
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- INDENTATION
-------------------------------------------------------------------
-- Insert 4 spaces for a tab
vim.o.tabstop = 4
vim.o.softtabstop = 4

-- Change the number of space characters inserted for indentation
vim.o.shiftwidth = 4

-- Converts tabs to spaces (if true)
vim.o.expandtab = false

-- Makes indenting smart (if true)
vim.o.smartindent = true

-- NUMBERING
-------------------------------------------------------------------
-- relative numbering
vim.o.number = true
vim.o.relativenumber = true

-- WRAP
-------------------------------------------------------------------
-- Display long lines as just one line
vim.o.wrap = false

-- MOUSE
-------------------------------------------------------------------
-- Enabling mouse
vim.o.mouse = "a"

-- BACKUP
-------------------------------------------------------------------
-- recommended by coc
vim.o.backup = false
vim.o.writebackup = false

-- undodir
vim.opt.undodir = vim.fn.expand("~/.config/nvim/.undodir")
vim.o.undofile = true

-- WINDOWS
-------------------------------------------------------------------
-- Horizontal splits will automatically be below
vim.o.splitbelow = true

-- Vertical splits will automatically be to the right
vim.o.splitright = true

-- DICTIONARY
-------------------------------------------------------------------
-- set a dictionary file
vim.o.dictionary = "/usr/share/dict/american-english"

-- MISCELLANEOUS
-------------------------------------------------------------------
-- Always show the signcolumn, otherwise it would shift the text each time
vim.wo.signcolumn = "yes"

-- Faster completion
vim.o.updatetime = 300

vim.o.completeopt = "menuone,noselect"

-- By default timeout length is 1000 ms
vim.o.timeoutlen = 500

-- Don't pass short messages to |ins-completion-menu|. refer `:h shortmess`
-- vim.opt.shortmess:append("c")

-- Required to keep multiple buffers open multiple buffers
vim.o.hidden = true

-- to see `` in markdown files (no pretty mode)
vim.o.conceallevel = 0

-- treat dash separated words as a word text object"
--vim.cmd("set iskeyword+=-")
--vim.opt.iskeyword:append("-")

-- Copy paste between vim and everything else
vim.o.clipboard = "unnamedplus"

-- Make substitution work in realtime
--vim.o.inccommand = "split"

-- providing support for various icons (https://www.nerdfonts.com/)
vim.g.have_nerd_font = true

-- never scroll-off to less than `n` characters to the bottom,
-- unless it's the end of the file
vim.opt.scrolloff = 8

-- add a trailing newline at the end of the file
vim.opt.fixendofline = false

-- STARTUP
-------------------------------------------------------------------
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if vim.fn.argc() == 0 then
			vim.cmd("enew")
		end
	end,
})

-- CODING
-------------------------------------------------------------------
if vim.fn.has("linux") == 1 then
	vim.g.python3_host_prog = "~/.pyenv/shims/python"
elseif vim.fn.has("macunix") == 1 then
	vim.g.python3_host_prog = "~/.pyenv/shims/python"
end

-- CUSTOM MESSAGES
-------------------------------------------------------------------
-- vim.api.nvim_command("highlight InfoMsg guifg=#00ff00 guibg=NONE")

-------------------------------------------------------------------
