function sort_file()
  vim.api.nvim_command('normal! ggVG')
  vim.api.nvim_command('sort')
end

-- Set mappings below
vim.keymap.set( -- up on wrapped line
  'n',
  'k',
  'v:count == 0 ? "gk" : "k""',
  { expr = true, silent = true }
)
vim.keymap.set( -- down on wrapped line
  'n',
  'j',
  'v:count == 0 ? "gj" : "j""',
  { expr = true, silent = true }
)
vim.api.nvim_set_keymap( -- sort file
  'n',
  '<leader>s',
  ':lua sort_file()<CR>',
  { noremap = true, silent = true }
)

-- Comment
vim.api.nvim_set_keymap(
  'n',
  '<leader>/',
  ':lua require("Comment.api").toggle.linewise.current()<CR>',
  {}
)
vim.api.nvim_set_keymap(
  'v',
  '<leader>/',
  ':lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>',
  {}
)

return {}
