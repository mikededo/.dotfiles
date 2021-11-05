call plug#begin(stdpath('data') . '/plugged')
  " Theme
  Plug 'hoob3rt/lualine.nvim'
  Plug 'navarasu/onedark.nvim' 
  Plug 'ryanoasis/vim-devicons'
  Plug 'mhinz/vim-startify'

  " Syntax highlighting
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

  " Completion
  Plug 'neoclide/coc.nvim', { 'branch': 'release' }

  " Utils
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'preservim/nerdtree'
call plug#end()

" Custom configurations
let g:onedark_italic_comment = v:false
let g:onedark_darker_diagnostics = v:false
let g:onedark_transparent_background = v:true
" Enable colorscheme
colorscheme onedark
