local M = {}
local overrides = require('custom.plugins')

-- Theme and colors
M.ui = {
  theme = 'onedommed',
  transparency = false,
  hl_override = require('custom.highlights'),
}

-- Plugins configurations
M.plugins = {
  options = {
    separator_line = 'round',
  },
  override = {
    ['hrsh7th/nvim-cmp'] = overrides.cmp,
    ['kyazdani42/nvim-tree.lua'] = overrides.nvimtree,
    ['lukas-reineke/indent-blankline.nvim'] = overrides.indent_blankline,
    ['nvim-telescope/telescope.nvim'] = overrides.telescope,
    ['nvim-treesitter/nvim-treesitter'] = overrides.treesitter,
    ['williamboman/mason.nvim'] = overrides.mason,
  },
  user = overrides.user,
}

return M
