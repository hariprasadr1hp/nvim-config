" assigned meta-keys
" <M-@@>, @@ = [a,b,d,e,f,g,h,j,k,l,o,t]

" meta(alt) keys in insert and command line mode
" *warning*: not to use <M-D>
noremap! <M-h> <Left>
noremap! <M-j> <Down>
noremap! <M-k> <Up>
noremap! <M-l> <Right>
noremap! <M-Left> <Left>
noremap! <M-Right> <Right>
noremap! <M-Up> <Up>
noremap! <M-Down> <DOwn>


" meta keys only for insert mode
inoremap <M-b> <C-o>^
inoremap <M-e> <C-o>$


" meta keys for deleting stuff
inoremap <M-d>d <C-o>dd
inoremap <M-d>p <C-o>dap
inoremap <M-d>w <C-o>daw
inoremap <M-d>W <C-o>daW


" meta keys for g-stuff
inoremap <M-g>j <C-o>gj
inoremap <M-g>k <C-o>gk
inoremap <M-g>m <C-o>gm
inoremap <M-g>M <C-o>gM


" meta keys for entering a new line
inoremap <M-o> <C-o>o
inoremap <M-O> <C-o>O


" ; and , in insert mode
inoremap <M-;> <C-o>;
inoremap <M-,> <C-o>,


" meta key 's' to save/update and go to normal mode
inoremap <M-s> <C-c>:update<CR>

" meta keys for 'f' for F motion(backward), use <M-;> and <M-,> for next/prev
inoremap <M-f> <C-o>T


" meta keys for 't' for deleting till that character(forward)
inoremap <M-t> <C-o>dt


" meta keys for around operations
inoremap <M-a>{ <C-o>da{
inoremap <M-a>} <C-o>da}
inoremap <M-a>[ <C-o>da[
inoremap <M-a>] <C-o>da]
inoremap <M-a>( <C-o>da(
inoremap <M-a>) <C-o>da)
inoremap <M-a>< <C-o>da<
inoremap <M-a>> <C-o>da>
inoremap <M-a>p <C-o>dap
inoremap <M-a>s <C-o>das
inoremap <M-a>t <C-o>dat
inoremap <M-a>w <C-o>daw
inoremap <M-a>W <C-o>daW
inoremap <M-a>b <C-o>da(
inoremap <M-a>c <C-o>da{
inoremap <M-a>d <C-o>da"
inoremap <M-a>q <C-o>da'
inoremap <M-a>x <C-o>da`
inoremap <M-a>B <C-o>da[
inoremap <M-a>Q <C-o>da"


" meta keys for inside operations
inoremap <M-i>{ <C-o>di{
inoremap <M-i>} <C-o>di}
inoremap <M-i>[ <C-o>di[
inoremap <M-i>] <C-o>di]
inoremap <M-i>( <C-o>di(
inoremap <M-i>) <C-o>di)
inoremap <M-i>< <C-o>di<
inoremap <M-i>> <C-o>di>
inoremap <M-i>p <C-o>dip
inoremap <M-i>s <C-o>dis
inoremap <M-i>t <C-o>dit
inoremap <M-i>w <C-o>diw
inoremap <M-i>W <C-o>diW
inoremap <M-i>b <C-o>di(
inoremap <M-i>c <C-o>di{
inoremap <M-i>d <C-o>di"
inoremap <M-i>q <C-o>di'
inoremap <M-i>x <C-o>di`
inoremap <M-i>B <C-o>di[
inoremap <M-i>Q <C-o>di"

