if !exists('g:loaded_telescope') | finish | endif

nnoremap <silent> ff <cmd>Telescope find_files<cr>
nnoremap <silent> fb <cmd>Telescope file_browser<cr>
nnoremap <silent> fg <cmd>Telescope live_grep<cr>
nnoremap <silent> \\ <cmd>Telescope buffers<cr>
nnoremap <silent> ;; <cmd>Telescope help_tags<cr>

lua << EOF
local actions = require('telescope.actions')
-- Global remapping
require('telescope').setup{
  defaults = {
    file_ignore_patterns = { "node_modules" },
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  }
}

EOF
