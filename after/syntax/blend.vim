" Custom syntax for .blend files
syntax keyword blendKeyword BlendHeader BlendData
syntax match blendComment "#.*"
syntax match blendNumber /\d\+/

" Highlight groups
highlight link blendKeyword Keyword
highlight link blendComment Comment
highlight link blendNumber Number

