local M = {}
local overrides = require('custom.plugins')

-- Theme and colors
M.ui = {
  theme = 'onedommed',
  transparency = false,
  hl_override = require('custom.highlights'),
}

-- Plugins configurations
local plugins = vim.tbl_deep_extend('force', {
  ['hrsh7th/nvim-cmp'] = { override_options = overrides.cmp },
  ['lukas-reineke/indent-blankline.nvim'] = {
    override_options = overrides.indent_blankline,
  },
  ['nvim-telescope/telescope.nvim'] = { override_options = overrides.telescope },
  ['nvim-treesitter/nvim-treesitter'] = {
    override_options = overrides.treesitter,
  },
  ['williamboman/mason.nvim'] = { override_options = overrides.mason },
}, overrides.user)
M.plugins = plugins

return M
