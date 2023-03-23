local nvchad_tree = require('plugins.configs.nvimtree')

local options = {
  view = {
    adaptive_size = true,
  },
  renderer = {
    icons = {
      glyphs = {
        default = '',
        symlink = '',
        folder = {
          default = '',
          empty = '',
          empty_open = '',
          open = '',
          symlink = '',
          symlink_open = '',
          arrow_open = '',
          arrow_closed = '',
        },
        git = {
          unstaged = '✗',
          staged = '✓',
          unmerged = '',
          renamed = '➜',
          untracked = '★',
          deleted = '',
          ignored = '◌',
        },
      },
    },
  },
}

return vim.tbl_deep_extend('force', nvchad_tree, options)
