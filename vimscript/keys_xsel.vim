" Register Keymaps for both normal and visual mode
"
" Format:
" <leader> (+) [a]ction (+) register (+) [c]opy | [x]cut | [v]paste
"
" for paste, the registers from 0-9 are added as well.
" Ex: `<leader>a2v` to paste the contents at register `2`
"
" changes made by `<leader>a{key}x` can be reverted using `<leader>a{key}v`


nnoremap <leader>avv "+P
nnoremap <leader>acc V"+y
nnoremap <leader>axx V"+d
vnoremap <leader>avv "+P
vnoremap <leader>acc "+y
vnoremap <leader>axx "+d

nnoremap <leader>aqc V"qy
nnoremap <leader>awc V"wy
nnoremap <leader>aec V"ey
nnoremap <leader>arc V"ry
nnoremap <leader>atc V"ty
nnoremap <leader>ayc V"yy
nnoremap <leader>auc V"uy
nnoremap <leader>aic V"iy
nnoremap <leader>aoc V"oy
nnoremap <leader>apc V"py
nnoremap <leader>aac V"ay
nnoremap <leader>asc V"sy
nnoremap <leader>adc V"dy
nnoremap <leader>afc V"fy
nnoremap <leader>agc V"gy
nnoremap <leader>ahc V"hy
nnoremap <leader>ajc V"jy
nnoremap <leader>akc V"ky
nnoremap <leader>alc V"ly

nnoremap <leader>aQc V"Qy
nnoremap <leader>aWc V"Wy
nnoremap <leader>aEc V"Ey
nnoremap <leader>aRc V"Ry
nnoremap <leader>aTc V"Ty
nnoremap <leader>aYc V"Yy
nnoremap <leader>aUc V"Uy
nnoremap <leader>aIc V"Iy
nnoremap <leader>aOc V"Oy
nnoremap <leader>aPc V"Py
nnoremap <leader>aAc V"Ay
nnoremap <leader>aSc V"Sy
nnoremap <leader>aDc V"Dy
nnoremap <leader>aFc V"Fy
nnoremap <leader>aGc V"Gy
nnoremap <leader>aHc V"Hy
nnoremap <leader>aJc V"Jy
nnoremap <leader>aKc V"Ky
nnoremap <leader>aLc V"Ly

vnoremap <leader>aqc "qy
vnoremap <leader>awc "wy
vnoremap <leader>aec "ey
vnoremap <leader>arc "ry
vnoremap <leader>atc "ty
vnoremap <leader>ayc "yy
vnoremap <leader>auc "uy
vnoremap <leader>aic "iy
vnoremap <leader>aoc "oy
vnoremap <leader>apc "py
vnoremap <leader>aac "ay
vnoremap <leader>asc "sy
vnoremap <leader>adc "dy
vnoremap <leader>afc "fy
vnoremap <leader>agc "gy
vnoremap <leader>ahc "hy
vnoremap <leader>ajc "jy
vnoremap <leader>akc "ky
vnoremap <leader>alc "ly

vnoremap <leader>aQc "Qy
vnoremap <leader>aWc "Wy
vnoremap <leader>aEc "Ey
vnoremap <leader>aRc "Ry
vnoremap <leader>aTc "Ty
vnoremap <leader>aYc "Yy
vnoremap <leader>aUc "Uy
vnoremap <leader>aIc "Iy
vnoremap <leader>aOc "Oy
vnoremap <leader>aPc "Py
vnoremap <leader>aAc "Ay
vnoremap <leader>aSc "Sy
vnoremap <leader>aDc "Dy
vnoremap <leader>aFc "Fy
vnoremap <leader>aGc "Gy
vnoremap <leader>aHc "Hy
vnoremap <leader>aJc "Jy
vnoremap <leader>aKc "Ky
vnoremap <leader>aLc "Ly

nnoremap <leader>aqx V"qd
nnoremap <leader>awx V"wd
nnoremap <leader>aex V"ed
nnoremap <leader>arx V"rd
nnoremap <leader>atx V"td
nnoremap <leader>ayx V"yd
nnoremap <leader>aux V"ud
nnoremap <leader>aix V"id
nnoremap <leader>aox V"od
nnoremap <leader>apx V"pd
nnoremap <leader>aax V"ad
nnoremap <leader>asx V"sd
nnoremap <leader>adx V"dd
nnoremap <leader>afx V"fd
nnoremap <leader>agx V"gd
nnoremap <leader>ahx V"hd
nnoremap <leader>ajx V"jd
nnoremap <leader>akx V"kd
nnoremap <leader>alx V"ld

nnoremap <leader>aQx V"Qd
nnoremap <leader>aWx V"Wd
nnoremap <leader>aEx V"Ed
nnoremap <leader>aRx V"Rd
nnoremap <leader>aTx V"Td
nnoremap <leader>aYx V"Yd
nnoremap <leader>aUx V"Ud
nnoremap <leader>aIx V"Id
nnoremap <leader>aOx V"Od
nnoremap <leader>aPx V"Pd
nnoremap <leader>aAx V"Ad
nnoremap <leader>aSx V"Sd
nnoremap <leader>aDx V"Dd
nnoremap <leader>aFx V"Fd
nnoremap <leader>aGx V"Gd
nnoremap <leader>aHx V"Hd
nnoremap <leader>aJx V"Jd
nnoremap <leader>aKx V"Kd
nnoremap <leader>aLx V"Ld

vnoremap <leader>aqx "qd
vnoremap <leader>awx "wd
vnoremap <leader>aex "ed
vnoremap <leader>arx "rd
vnoremap <leader>atx "td
vnoremap <leader>ayx "yd
vnoremap <leader>aux "ud
vnoremap <leader>aix "id
vnoremap <leader>aox "od
vnoremap <leader>apx "pd
vnoremap <leader>aax "ad
vnoremap <leader>asx "sd
vnoremap <leader>adx "dd
vnoremap <leader>afx "fd
vnoremap <leader>agx "gd
vnoremap <leader>ahx "hd
vnoremap <leader>ajx "jd
vnoremap <leader>akx "kd
vnoremap <leader>alx "ld

vnoremap <leader>aQx "Qd
vnoremap <leader>aWx "Wd
vnoremap <leader>aEx "Ed
vnoremap <leader>aRx "Rd
vnoremap <leader>aTx "Td
vnoremap <leader>aYx "Yd
vnoremap <leader>aUx "Ud
vnoremap <leader>aIx "Id
vnoremap <leader>aOx "Od
vnoremap <leader>aPx "Pd
vnoremap <leader>aAx "Ad
vnoremap <leader>aSx "Sd
vnoremap <leader>aDx "Dd
vnoremap <leader>aFx "Fd
vnoremap <leader>aGx "Gd
vnoremap <leader>aHx "Hd
vnoremap <leader>aJx "Jd
vnoremap <leader>aKx "Kd
vnoremap <leader>aLx "Ld

nnoremap <leader>aqv "qP
nnoremap <leader>awv "wP
nnoremap <leader>aev "eP
nnoremap <leader>arv "rP
nnoremap <leader>atv "tP
nnoremap <leader>ayv "yP
nnoremap <leader>auv "uP
nnoremap <leader>aiv "iP
nnoremap <leader>aov "oP
nnoremap <leader>apv "pP
nnoremap <leader>aav "aP
nnoremap <leader>asv "sP
nnoremap <leader>adv "dP
nnoremap <leader>afv "fP
nnoremap <leader>agv "gP
nnoremap <leader>ahv "hP
nnoremap <leader>ajv "jP
nnoremap <leader>akv "kP
nnoremap <leader>alv "lP

nnoremap <leader>aQv "QP
nnoremap <leader>aWv "WP
nnoremap <leader>aEv "EP
nnoremap <leader>aRv "RP
nnoremap <leader>aTv "TP
nnoremap <leader>aYv "YP
nnoremap <leader>aUv "UP
nnoremap <leader>aIv "IP
nnoremap <leader>aOv "OP
nnoremap <leader>aPv "PP
nnoremap <leader>aAv "AP
nnoremap <leader>aSv "SP
nnoremap <leader>aDv "DP
nnoremap <leader>aFv "FP
nnoremap <leader>aGv "GP
nnoremap <leader>aHv "HP
nnoremap <leader>aJv "JP
nnoremap <leader>aKv "KP
nnoremap <leader>aLv "LP

vnoremap <leader>aqv "qP
vnoremap <leader>awv "wP
vnoremap <leader>aev "eP
vnoremap <leader>arv "rP
vnoremap <leader>atv "tP
vnoremap <leader>ayv "yP
vnoremap <leader>auv "uP
vnoremap <leader>aiv "iP
vnoremap <leader>aov "oP
vnoremap <leader>apv "pP
vnoremap <leader>aav "aP
vnoremap <leader>asv "sP
vnoremap <leader>adv "dP
vnoremap <leader>afv "fP
vnoremap <leader>agv "gP
vnoremap <leader>ahv "hP
vnoremap <leader>ajv "jP
vnoremap <leader>akv "kP
vnoremap <leader>alv "lP

vnoremap <leader>aQv "QP
vnoremap <leader>aWv "WP
vnoremap <leader>aEv "EP
vnoremap <leader>aRv "RP
vnoremap <leader>aTv "TP
vnoremap <leader>aYv "YP
vnoremap <leader>aUv "UP
vnoremap <leader>aIv "IP
vnoremap <leader>aOv "OP
vnoremap <leader>aPv "PP
vnoremap <leader>aAv "AP
vnoremap <leader>aSv "SP
vnoremap <leader>aDv "DP
vnoremap <leader>aFv "FP
vnoremap <leader>aGv "GP
vnoremap <leader>aHv "HP
vnoremap <leader>aJv "JP
vnoremap <leader>aKv "KP
vnoremap <leader>aLv "LP


nnoremap <leader>a1v "1P
nnoremap <leader>a2v "2P
nnoremap <leader>a3v "3P
nnoremap <leader>a4v "4P
nnoremap <leader>a5v "5P
nnoremap <leader>a6v "6P
nnoremap <leader>a7v "7P
nnoremap <leader>a8v "8P
nnoremap <leader>a9v "9P
nnoremap <leader>a0v "0P
nnoremap <leader>a-v "-P
nnoremap <leader>a%v "%P
nnoremap <leader>a/v "/P
nnoremap <leader>a.v ".P
nnoremap <leader>a*v "*P
nnoremap <leader>a+v "+P
nnoremap <leader>a#v "#P
nnoremap <leader>a=v "=P
nnoremap <leader>a9v "9P

vnoremap <leader>a1v "1P
vnoremap <leader>a2v "2P
vnoremap <leader>a3v "3P
vnoremap <leader>a4v "4P
vnoremap <leader>a5v "5P
vnoremap <leader>a6v "6P
vnoremap <leader>a7v "7P
vnoremap <leader>a8v "8P
vnoremap <leader>a9v "9P
vnoremap <leader>a0v "0P
vnoremap <leader>a-v "-P
vnoremap <leader>a%v "%P
vnoremap <leader>a/v "/P
vnoremap <leader>a.v ".P
vnoremap <leader>a*v "*P
vnoremap <leader>a+v "+P
vnoremap <leader>a#v "#P
vnoremap <leader>a=v "=P
vnoremap <leader>a9v "9P

nnoremap <leader>a-x "-d
vnoremap <leader>a-x "-d

nnoremap <leader>a-c "-y
vnoremap <leader>a-c "-y

nnoremap <leader>a-v "-P
vnoremap <leader>a-v "-P

