" #######################################################################

" Y yanks till the end of the line from the cursor
nnoremap Y y$


" continued visual selection while indenting
vnoremap < <gv
vnoremap > >gv


" continued visual selection while counting
vnoremap <C-a> <C-a>gv
vnoremap <C-x> <C-x>gv


" buffer chain
" nnoremap [b :bp<cr>
" nnoremap ]b :bn<cr>

" tab chain
" nnoremap [j :tabprevious<cr>
" nnoremap ]j :tabnext<cr>

" alias for 'escape' to NORMAL from INSERT
" inoremap klk <Esc>


" " Move selected line / block of text in visual mode
" " shift + k to move up
" " shift + j to move down
xnoremap K :move '<-2<cr>gv-gv
xnoremap J :move '>+1<cr>gv-gv


" move lines using 'Alt', vscode-like
nnoremap <M-Up> :move -2<cr>
nnoremap <M-Down> :move +1<cr>


" visually select text for searching, mapped to //
vnoremap // y/\V<C-R>=escape(@",'/\')<cr><cr>

