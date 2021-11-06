au ColorScheme * hi Normal ctermbg=none guibg=none

" Configurations
set nocompatible
set smartindent
set smarttab
set shiftwidth=4
set tabstop=4 softtabstop=4
set expandtab
set nohlsearch
set noshowmode
set number relativenumber
set termguicolors
set guicursor=
set hidden
set incsearch
set scrolloff=12
set noswapfile
set textwidth=100
set foldcolumn=1
set ignorecase
set smartcase
syntax on
filetype plugin indent on
set ai
set ruler
set splitbelow
set splitright

au FocusGained,BufEnter * :checktime " Refresh the file on focus

augroup vimrc_help " Show vertical help
  autocmd!
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
augroup end

" Format options
set formatoptions+=t
set formatoptions+=c
set formatoptions-=a
set formatoptions+=j
set formatoptions+=r
set formatoptions-=o

" Custom file identations
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascriptreact setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript.tsx setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType typescript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType typescriptreact setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType typescript.tsx setlocal shiftwitdth=2 tabstop=2 softtabstop=2
autocmd FileType vim setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType lua setlocal shiftwidth=2 tabstop=2 softtabstop=2

" Imports
runtime ./plug.vim " Plugins
runtime ./maps.vim " Keymaps

