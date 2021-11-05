" Configurations
set nocompatible
set smartindent
set smarttab
set expandtab
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
set shiftwidth=2
set tabstop=2
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

" Imports
runtime ./plug.vim " Plugins
runtime ./maps.vim " Keymaps

