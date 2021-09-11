" Use completion-nvim in every buffer
autocmd BufEnter * lua require'completion'.on_attach()


" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

" let g:completion_enable_auto_popup = 1

" map <c-p> to manually trigger completion
" imap <silent> <c-p> <Plug>(completion_trigger)
imap <silent> <c-space> <Plug>(completion_trigger)

" possible value: 'UltiSnips', 'Neosnippet', 'vim-vsnip', 'snippets.nvim'
let g:completion_enable_snippet = 'vim-vsnip'

" Changing Completion Confirm key
" let g:completion_confirm_key = "\<C-y>"


" let g:completion_enable_auto_hover = 1

" let g:completion_enable_auto_signature = 1


" Sorting completion items
" possible value: "length", "alphabet", "none"
let g:completion_sorting = "length"

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy', 'all']

let g:completion_matching_ignore_case = 1

let g:completion_matching_smart_case = 1

let g:completion_trigger_character = ['.', '::']

augroup CompletionTriggerCharacter
    autocmd!
    autocmd BufEnter * let g:completion_trigger_character = ['.']
    autocmd BufEnter *.c,*.cpp let g:completion_trigger_character = ['.', '::']
augroup end


" let g:completion_trigger_keyword_length = 1 " default = 1

" let g:completion_trigger_on_delete = 1

" let g:completion_timer_cycle = 80 "default value is 80

