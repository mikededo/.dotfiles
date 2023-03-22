local M = {}

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
  statusline = {
    theme = 'minimal',
    separator_style = 'round',
  },
}

M.plugins = 'custom.plugins'

return M
