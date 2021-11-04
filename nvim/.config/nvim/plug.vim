call plug#begin(stdpath('data') . '/plugged')
  " Theme
  Plug 'hoob3rt/lualine.nvim'
  Plug 'joshdick/onedark.vim' 
  Plug 'ryanoasis/vim-devicons'

  " Syntax highlighting
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

  " Completion
  Plug 'neoclide/coc.nvim', { 'branch': 'release' }

  " Utils
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'preservim/nerdtree'
call plug#end()

colorscheme onedark
