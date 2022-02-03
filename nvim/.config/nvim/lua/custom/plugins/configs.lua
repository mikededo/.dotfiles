local M = {}
local actions = require('telescope.actions')

M.treesitter = {
  ensure_installed = {
    'bash',
    'css',
    'javascript',
    'jsdoc',
    'json',
    'jsonc',
    'lua',
    'tsx',
    'typescript',
    'vim',
    'yaml',
  },
  highlight = { enable = true },
  incremental_selection = { enabled = true },
  textobjects = { enabled = true },
}

M.telescope = {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--hidden',
      '--smart-case',
    },
    file_ignore_patterns = {
      '^node_modules*',
      '^out*',
      '^coverage*',
      '^dist*',
      '^.git/+',
    },
    initial_mode = 'normal',
    mappings = {
      n = {
        ['q'] = actions.close,
      },
    },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
    buffers = {
      show_all_buffers = true,
      sort_lastused = true,
      mappings = {
        i = {
          ['<C-d>'] = 'delete_buffer',
        },
      },
    },
  },
}

return M
