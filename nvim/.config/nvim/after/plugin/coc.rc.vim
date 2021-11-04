" CoC mappings
" Basic
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implmentation)
nmap <silent> gr <Plug>(coc-references)

" Tab for trigger completion
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent><expr> <c-space> coc#refresh()

" [SETUP] Language servers to install
"   coc-tsserver
"   coc-eslint
"   coc-json
"   coc-html
"   coc-css
" [SETUP] Additional installations
"   coc-snippets
