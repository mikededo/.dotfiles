-- Plugins configuration
return {
  {
    'ray-x/lsp_signature.nvim',
    lazy = false,
    config = function()
      require('custom.configs.user.lsp-signature')
    end,
  },
  {
    'neovim/nvim-lspconfig',
    lazy = false,
    config = function()
      require('plugins.configs.lspconfig')
      require('custom.configs.lspconfig')
    end,
  }, -- lsp config has to be placed here
  {
    'mhartington/formatter.nvim',
    lazy = false,
    config = function()
      require('custom.configs.user.formatter')
    end,
  },
  { 'hrsh7th/nvim-cmp', lazy = false },
  {
    'terrortylor/nvim-comment',
    lazy = false,
    config = function()
      require('nvim_comment')
    end,
  },
  {
    'onsails/lspkind.nvim',
    lazy = false,
    config = function()
      require('lspkind').init()
    end,
  },
  { 'folke/which-key.nvim', lazy = false },
  { 'b0o/schemastore.nvim' },
  {
    'simrat39/rust-tools.nvim',
    lazy = false,
    -- Plugin is configured in the lspconfig/servers/rust directory
  },
}
