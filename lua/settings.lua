-- lua/settings.lua

-- GUI
-------------------------------------------------------------------
vim.cmd('set noerrorbells')


-- COLORS
-------------------------------------------------------------------
-- move to next line with theses keys
vim.cmd('syntax on')

-- fix indentline for now
vim.cmd('set colorcolumn=9999')

-- set term giu colors most terminals support this
vim.go.termguicolors = true

-- Support 256 colors
vim.go.t_Co = "256"
vim.cmd("highlight Colorcolumn ctermbg=0 guibg=lightgrey")


-- SEARCH
-------------------------------------------------------------------
vim.cmd('set hlsearch')
vim.cmd('set incsearch')
vim.cmd('set ignorecase')
vim.cmd('set smartcase')


-- INDENTATION
-------------------------------------------------------------------
-- Insert 4 spaces for a tab
vim.cmd('set tabstop=4')
vim.cmd('set softtabstop=4')

-- Change the number of space characters inserted for indentation
vim.cmd('set shiftwidth=4')

-- Converts tabs to spaces
vim.bo.expandtab = true

-- Makes indenting smart
vim.bo.smartindent = true


-- NUMBERING
-------------------------------------------------------------------
-- relative numbering
vim.cmd("set number relativenumber")


-- WRAP
-------------------------------------------------------------------
-- Display long lines as just one line
vim.wo.wrap = false


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
vim.cmd("set undodir=~/.config/nvim/undodir")
vim.cmd("set undofile")


-- WINDOWS
-------------------------------------------------------------------
-- Horizontal splits will automatically be below
vim.o.splitbelow = true

-- Vertical splits will automatically be to the right
vim.o.splitright = true


-- DICTIONARY
-------------------------------------------------------------------
-- set a dictionary file
vim.cmd("set dictionary=/usr/share/dict/american-english")


-- MISCELLANEOUS
-------------------------------------------------------------------
-- Always show the signcolumn, otherwise it would shift the text each time
vim.wo.signcolumn = "yes"

-- Faster completion
vim.o.updatetime = 300

-- By default timeout length is 1000 ms
vim.o.timeoutlen = 500

-- Don't pass messages to |ins-completion-menu|.
vim.cmd('set shortmess+=c')

-- Required to keep multiple buffers open multiple buffers
vim.o.hidden = true

-- So that I can see `` in markdown files
vim.o.conceallevel = 0

-- treat dash separated words as a word text object"
--vim.cmd('set iskeyword+=-')

-- Copy paste between vim and everything else
vim.o.clipboard = "unnamed"

-- Make substitution work in realtime
--vim.cmd('set inccommand=split')


-- CODING
-------------------------------------------------------------------
if vim.fn.has("linux") == 1 then
	vim.g.python3_host_prog = '~/.pyenv/shims/python'
elseif vim.fn.has("macunix") == 1 then
	vim.g.python3_host_prog = '~/.pyenv/shims/python'
end


-------------------------------------------------------------------

