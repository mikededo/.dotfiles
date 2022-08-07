-- Plugins configuration
return {
  ['neovim/nvim-lspconfig'] = {
    config = function()
      require('plugins.configs.lspconfig')
      require('custom.plugins.lspconfig')
    end,
  }, -- lsp config has to be placed here
  ['mhartington/formatter.nvim'] = {
    config = function()
      require('custom.plugins.user.formatter')
    end,
  },
  ['hrsh7th/nvim-cmp'] = { disable = false },
  ['terrortylor/nvim-comment'] = { disable = false },
  ['goolord/alpha-nvim'] = { disable = false },
  ['onsails/lspkind.nvim'] = { disable = false },
  ['ray-x/lsp_signature.nvim'] = { disable = false },
  ['folke/which-key.nvim'] = { disable = false },
}
