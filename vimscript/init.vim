"#######################################################################
" mappings
" let mapleader = "\<Space>"

" Y yanks till the end of the line from the cursor
nnoremap Y y$


" continued visual selection while indenting
vnoremap < <gv
vnoremap > >gv


" continued visual selection while counting
vnoremap <C-a> <C-a>gv
vnoremap <C-x> <C-x>gv


" buffer chain
nnoremap [b :bp<CR>
nnoremap ]b :bn<CR>

" tab chain
nnoremap [t :tabprevious<CR>
nnoremap ]t :tabnext<CR>

" alias for 'escape' to NORMAL from INSERT
" inoremap klk <Esc>


" " Move selected line / block of text in visual mode
" " shift + k to move up
" " shift + j to move down
xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv


" move lines using 'Alt', vscode-like
nnoremap <M-Up> :move -2<CR>
nnoremap <M-Down> :move +1<CR>


" visually select text for searching, mapped to //
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
 
