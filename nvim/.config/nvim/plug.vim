call plug#begin(stdpath('data') . '/plugged')
  " Theme
  Plug 'hoob3rt/lualine.nvim'
  Plug 'navarasu/onedark.nvim'
  Plug 'ryanoasis/vim-devicons'
  Plug 'mhinz/vim-startify'

  " LSP
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-compe'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'folke/lsp-colors.nvim'
  Plug 'onsails/lspkind-nvim'
  Plug 'L3MON4D3/LuaSnip'

  " Syntax highlighting
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

  " Git
  Plug 'airblade/vim-gitgutter'

  " Utils
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'windwp/nvim-autopairs'
  Plug 'mhartington/formatter.nvim'
call plug#end()

" Enable colorscheme
colorscheme onedark

