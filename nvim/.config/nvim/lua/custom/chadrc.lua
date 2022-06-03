local M = {}

-- Require configurations
require('custom.configs')
require('custom.plugins.lspconfig')

-- Theme and colors
M.ui = {
  theme = 'onedark',
  hl_override = require('custom.highlights'),
}

-- Plugins configurations
M.plugins = {
  options = {
    separator_line = 'round',
  },
  override = {
    ['nvim-treesitter/nvim-treesitter'] = require('custom.plugins.treesitter'),
    ['nvim-telescope/telescope.nvim'] = require('custom.plugins.telescope'),
    ['lukas-reineke/indent-blankline.nvim'] = require(
      'custom.plugins.indent-blankline'
    ),
  },
  user = require('custom.plugins.configs'),
}

return M
