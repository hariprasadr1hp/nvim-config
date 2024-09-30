" assigned meta-keys
" <M-@@>, @@ = [a,e,h,j,k,l,o,O,t,u,w]

" h,j,k,l :: movement
" o,O :: insert cursor below/above
" a,e :: move cursor to start/end of the line
" t :: move cirsor to the start of the character

" shift key selection
" starts selecting, but defaults to normal mode
inoremap <S-Left> <C-c>v
inoremap <S-Right> <Right><C-c>v


" meta(alt) keys in insert and command line mode
" *WARNING*: not to use <M-D> !!!
noremap! <M-h> <Left>
noremap! <M-j> <Down>
noremap! <M-k> <Up>
noremap! <M-l> <Right>
noremap! <M-Left> <Left>
noremap! <M-Right> <Right>
noremap! <M-Up> <Up>
noremap! <M-Down> <Down>


" meta keys only for insert mode
inoremap <M-a> <C-o>^
inoremap <M-e> <C-o>$
inoremap <M-u> <C-o>d0
inoremap <M-w> <C-o>db


" meta keys for entering a new line
inoremap <M-o> <C-o>o
inoremap <M-O> <C-o>O


" place the cursor infront of the character
" use `<M-;>` and `<M-,>` for next/prev
inoremap <M-t> <C-o>f


" ; and , in insert mode
inoremap <M-;> <C-o>;
inoremap <M-,> <C-o>,


" meta key `s` to save/update and go to normal mode
inoremap <M-s> <C-c>:update<CR>

