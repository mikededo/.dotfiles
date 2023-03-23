local M = {}

-- local ui = require('NvChad/ui.nvim')

-- Theme and colors
M.ui = {
  theme = 'onedommed',
  transparency = false,
  hl_override = require('custom.highlights'),
  nvdash = {
    load_on_startup = true,
  },
  cmp = {
    style = 'flat_dark',
    selected_item_bg = 'colored',
  },
  statusline = require('custom.configs.statusline'),
}

M.plugins = 'custom.plugins'

return M
