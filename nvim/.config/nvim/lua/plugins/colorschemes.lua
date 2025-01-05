return {
  {
    'catppuccin/nvim',
    lazy = false,
    priority = 1000,
    config = function(_, opts)
      require('catppuccin').setup(opts)
    end,
  },
  {
    'LazyVim/LazyVim',
    opts = {
      colorscheme = 'catppuccin',
    },
  },
}
