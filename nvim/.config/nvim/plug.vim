call plug#begin(stdpath('data') . '/plugged')
        Plug 'joshdick/onedark.vim' 
        Plug 'neovim/nvim-lspconfig'
        Plug 'glepnir/lspsaga.nvim' 
        Plug 'nvim-lua/completion-nvim'
        Plug 'nvim-lua/popup.nvim'
        Plug 'nvim-lua/plenary.nvim'
        Plug 'nvim-telescope/telescope.nvim'
        Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
        Plug 'hoob3rt/lualine.nvim'
call plug#end()

colorscheme onedark
