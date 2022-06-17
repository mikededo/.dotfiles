-- Plugins configuration
return {
  ['mhartington/formatter.nvim'] = {
    config = function()
      require('custom.plugins.user.formatter')
    end,
  },
  ['fatih/vim-go'] = {},
  ['hrsh7th/nvim-cmp'] = { disable = false },
  ['terrortylor/nvim-comment'] = { disable = false },
  ['goolord/alpha-nvim'] = { disable = false },
  ['onsails/lspkind.nvim'] = { disable = false },
  ['ray-x/lsp_signature.nvim'] = { disable = false },
}
