local M = {}
local configs = require('custom.plugins.configs')

-- Custom configurations
vim.api.nvim_set_option('guicursor', 'i:block')
vim.cmd('set incsearch')
vim.cmd('set noshowmode')

M.ui = {
  theme = 'onedark',
  transparency = true,
  hl_override = 'custom.highlights',
}

-- Install plugins
local userPlugins = require('custom.plugins') -- path to table

M.plugins = {
  status = {
    cmp = true,
    comment = true,
    dashboard = true,
    lspkind = true,
    lspsignature = true,
    nvim_cmp = true,
  },
  default_plugin_config_replace = {
    nvim_treesitter = configs.treesitter,
    telescope = configs.telescope,
  },
  install = userPlugins,
}

-- Require file so it is loaded
require('custom.plugins.lspconfig')

return M
