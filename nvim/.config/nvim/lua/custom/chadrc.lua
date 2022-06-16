local M = {}
local overrides = require('custom.plugins')

-- Require configurations
require('custom.configs')
-- require('custom.plugins.lspconfig')

-- Theme and colors
M.ui = {
  theme = 'onedark',
  transparency = false,
  -- hl_override = require('custom.highlights'),
}

-- Plugins configurations
M.plugins = {
  options = {
    separator_line = 'round',
  },
  override = {
    ['nvim-treesitter/nvim-treesitter'] = overrides.treesitter,
    ['nvim-telescope/telescope.nvim'] = overrides.telescope,
    ['lukas-reineke/indent-blankline.nvim'] = overrides.indent_blanklinke,
  },
  user = overrides.user,
}

return M
