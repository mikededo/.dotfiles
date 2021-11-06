if !exists('g:loaded_telescope') | finish | endif

nnoremap <silent> ff <cmd>Telescope find_files<cr>
nnoremap <silent> fb <cmd>Telescope buffers<cr>
" grep_string requires ripgrep
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Search: ") })<CR>

lua << EOF
local actions = require('telescope.actions')
-- Global remapping
require('telescope').setup{
  defaults = {
    file_ignore_patterns = { "node_modules", "out", "dist" },
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  },
  pickers = {
    buffers = {
      show_all_buffers = true,
      sort_lastused = true,
      mappings = {
        i = {
          ['<C-d>'] = "delete_buffer"
        }
      }
    }
  }
}

EOF
