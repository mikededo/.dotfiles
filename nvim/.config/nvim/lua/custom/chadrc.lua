local M = {}
local overrides = require('custom.plugins')

-- Theme and colors
M.ui = {
  theme = 'onedommed',
  transparency = false,
  hl_override = require('custom.highlights'),
}

-- Plugins configurations
-- NvChad ui configurations
local nv_chad_ui = {
  statusline = overrides.statusline,
}

M.plugins = vim.tbl_deep_extend('force', {
  ['NvChad/ui'] = {
    override_options = nv_chad_ui,
  },
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

return M
