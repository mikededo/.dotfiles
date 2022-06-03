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
      '^node_modules*',
      '^.git/',
      '^coverage*',
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
