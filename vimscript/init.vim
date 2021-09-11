"#######################################################################
" mappings
" let mapleader = "\<Space>"

" continued visual selection while indenting
vnoremap < <gv
vnoremap > >gv

" continued visual selection while counting
vnoremap <C-a> <C-a>gv
vnoremap <C-x> <C-x>gv

" buffer chain
nnoremap [b :bp<CR>
nnoremap ]b :bn<CR>

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


" xsel commands
nnoremap <leader>avv "+p
nnoremap <leader>acc V"+y
nnoremap <leader>axx V"+d
vnoremap <leader>avv "+p
vnoremap <leader>acc "+y
vnoremap <leader>axx "+d

nnoremap <leader>acq V"qy
nnoremap <leader>acw V"wy
nnoremap <leader>ace V"ey
nnoremap <leader>acr V"ry
nnoremap <leader>act V"ty
nnoremap <leader>acy V"yy
nnoremap <leader>acu V"uy
nnoremap <leader>aci V"iy
nnoremap <leader>aco V"oy
nnoremap <leader>acp V"py
nnoremap <leader>aca V"ay
nnoremap <leader>acs V"sy
nnoremap <leader>acd V"dy
nnoremap <leader>acf V"fy
nnoremap <leader>acg V"gy
nnoremap <leader>ach V"hy
nnoremap <leader>acj V"jy
nnoremap <leader>ack V"ky
nnoremap <leader>acl V"ly

nnoremap <leader>acQ V"Qy
nnoremap <leader>acW V"Wy
nnoremap <leader>acE V"Ey
nnoremap <leader>acR V"Ry
nnoremap <leader>acT V"Ty
nnoremap <leader>acY V"Yy
nnoremap <leader>acU V"Uy
nnoremap <leader>acI V"Iy
nnoremap <leader>acO V"Oy
nnoremap <leader>acP V"Py
nnoremap <leader>acA V"Ay
nnoremap <leader>acS V"Sy
nnoremap <leader>acD V"Dy
nnoremap <leader>acF V"Fy
nnoremap <leader>acG V"Gy
nnoremap <leader>acH V"Hy
nnoremap <leader>acJ V"Jy
nnoremap <leader>acK V"Ky
nnoremap <leader>acL V"Ly

vnoremap <leader>acq "qy
vnoremap <leader>acw "wy
vnoremap <leader>ace "ey
vnoremap <leader>acr "ry
vnoremap <leader>act "ty
vnoremap <leader>acy "yy
vnoremap <leader>acu "uy
vnoremap <leader>aci "iy
vnoremap <leader>aco "oy
vnoremap <leader>acp "py
vnoremap <leader>aca "ay
vnoremap <leader>acs "sy
vnoremap <leader>acd "dy
vnoremap <leader>acf "fy
vnoremap <leader>acg "gy
vnoremap <leader>ach "hy
vnoremap <leader>acj "jy
vnoremap <leader>ack "ky
vnoremap <leader>acl "ly

vnoremap <leader>acQ "Qy
vnoremap <leader>acW "Wy
vnoremap <leader>acE "Ey
vnoremap <leader>acR "Ry
vnoremap <leader>acT "Ty
vnoremap <leader>acY "Yy
vnoremap <leader>acU "Uy
vnoremap <leader>acI "Iy
vnoremap <leader>acO "Oy
vnoremap <leader>acP "Py
vnoremap <leader>acA "Ay
vnoremap <leader>acS "Sy
vnoremap <leader>acD "Dy
vnoremap <leader>acF "Fy
vnoremap <leader>acG "Gy
vnoremap <leader>acH "Hy
vnoremap <leader>acJ "Jy
vnoremap <leader>acK "Ky
vnoremap <leader>acL "Ly

nnoremap <leader>axq V"qd
nnoremap <leader>axw V"wd
nnoremap <leader>axe V"ed
nnoremap <leader>axr V"rd
nnoremap <leader>axt V"td
nnoremap <leader>axy V"yd
nnoremap <leader>axu V"ud
nnoremap <leader>axi V"id
nnoremap <leader>axo V"od
nnoremap <leader>axp V"pd
nnoremap <leader>axa V"ad
nnoremap <leader>axs V"sd
nnoremap <leader>axd V"dd
nnoremap <leader>axf V"fd
nnoremap <leader>axg V"gd
nnoremap <leader>axh V"hd
nnoremap <leader>axj V"jd
nnoremap <leader>axk V"kd
nnoremap <leader>axl V"ld

nnoremap <leader>axQ V"Qd
nnoremap <leader>axW V"Wd
nnoremap <leader>axE V"Ed
nnoremap <leader>axR V"Rd
nnoremap <leader>axT V"Td
nnoremap <leader>axY V"Yd
nnoremap <leader>axU V"Ud
nnoremap <leader>axI V"Id
nnoremap <leader>axO V"Od
nnoremap <leader>axP V"Pd
nnoremap <leader>axA V"Ad
nnoremap <leader>axS V"Sd
nnoremap <leader>axD V"Dd
nnoremap <leader>axF V"Fd
nnoremap <leader>axG V"Gd
nnoremap <leader>axH V"Hd
nnoremap <leader>axJ V"Jd
nnoremap <leader>axK V"Kd
nnoremap <leader>axL V"Ld

vnoremap <leader>axq "qd
vnoremap <leader>axw "wd
vnoremap <leader>axe "ed
vnoremap <leader>axr "rd
vnoremap <leader>axt "td
vnoremap <leader>axy "yd
vnoremap <leader>axu "ud
vnoremap <leader>axi "id
vnoremap <leader>axo "od
vnoremap <leader>axp "pd
vnoremap <leader>axa "ad
vnoremap <leader>axs "sd
vnoremap <leader>axd "dd
vnoremap <leader>axf "fd
vnoremap <leader>axg "gd
vnoremap <leader>axh "hd
vnoremap <leader>axj "jd
vnoremap <leader>axk "kd
vnoremap <leader>axl "ld

vnoremap <leader>axQ "Qd
vnoremap <leader>axW "Wd
vnoremap <leader>axE "Ed
vnoremap <leader>axR "Rd
vnoremap <leader>axT "Td
vnoremap <leader>axY "Yd
vnoremap <leader>axU "Ud
vnoremap <leader>axI "Id
vnoremap <leader>axO "Od
vnoremap <leader>axP "Pd
vnoremap <leader>axA "Ad
vnoremap <leader>axS "Sd
vnoremap <leader>axD "Dd
vnoremap <leader>axF "Fd
vnoremap <leader>axG "Gd
vnoremap <leader>axH "Hd
vnoremap <leader>axJ "Jd
vnoremap <leader>axK "Kd
vnoremap <leader>axL "Ld

nnoremap <leader>avq "qp
nnoremap <leader>avw "wp
nnoremap <leader>ave "ep
nnoremap <leader>avr "rp
nnoremap <leader>avt "tp
nnoremap <leader>avy "yp
nnoremap <leader>avu "up
nnoremap <leader>avi "ip
nnoremap <leader>avo "op
nnoremap <leader>avp "pp
nnoremap <leader>ava "ap
nnoremap <leader>avs "sp
nnoremap <leader>avd "dp
nnoremap <leader>avf "fp
nnoremap <leader>avg "gp
nnoremap <leader>avh "hp
nnoremap <leader>avj "jp
nnoremap <leader>avk "kp
nnoremap <leader>avl "lp

nnoremap <leader>avQ "Qp
nnoremap <leader>avW "Wp
nnoremap <leader>avE "Ep
nnoremap <leader>avR "Rp
nnoremap <leader>avT "Tp
nnoremap <leader>avY "Yp
nnoremap <leader>avU "Up
nnoremap <leader>avI "Ip
nnoremap <leader>avO "Op
nnoremap <leader>avP "Pp
nnoremap <leader>avA "Ap
nnoremap <leader>avS "Sp
nnoremap <leader>avD "Dp
nnoremap <leader>avF "Fp
nnoremap <leader>avG "Gp
nnoremap <leader>avH "Hp
nnoremap <leader>avJ "Jp
nnoremap <leader>avK "Kp
nnoremap <leader>avL "Lp

vnoremap <leader>avq "qp
vnoremap <leader>avw "wp
vnoremap <leader>ave "ep
vnoremap <leader>avr "rp
vnoremap <leader>avt "tp
vnoremap <leader>avy "yp
vnoremap <leader>avu "up
vnoremap <leader>avi "ip
vnoremap <leader>avo "op
vnoremap <leader>avp "pp
vnoremap <leader>ava "ap
vnoremap <leader>avs "sp
vnoremap <leader>avd "dp
vnoremap <leader>avf "fp
vnoremap <leader>avg "gp
vnoremap <leader>avh "hp
vnoremap <leader>avj "jp
vnoremap <leader>avk "kp
vnoremap <leader>avl "lp

vnoremap <leader>avQ "Qp
vnoremap <leader>avW "Wp
vnoremap <leader>avE "Ep
vnoremap <leader>avR "Rp
vnoremap <leader>avT "Tp
vnoremap <leader>avY "Yp
vnoremap <leader>avU "Up
vnoremap <leader>avI "Ip
vnoremap <leader>avO "Op
vnoremap <leader>avP "Pp
vnoremap <leader>avA "Ap
vnoremap <leader>avS "Sp
vnoremap <leader>avD "Dp
vnoremap <leader>avF "Fp
vnoremap <leader>avG "Gp
vnoremap <leader>avH "Hp
vnoremap <leader>avJ "Jp
vnoremap <leader>avK "Kp
vnoremap <leader>avL "Lp



"#######################################################################

"#######################################################################
