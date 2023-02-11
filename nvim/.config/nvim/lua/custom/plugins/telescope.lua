return {
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
      '^.git/',
      '^coverage*',
      '^node_modules*',
      '^target*',
    },
    initial_mode = 'normal',
  },
  pickers = {
    find_files = { hidden = true },
    buffers = {
      show_all_buffers = true,
      sort_lastused = true,
      mappings = {
        -- Insert mode
        i = {
          ['<C-d>'] = 'delete_buffer',
        },
      },
    },
  },
}
