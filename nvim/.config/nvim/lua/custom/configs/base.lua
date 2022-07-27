vim.api.nvim_set_option('guicursor', 'i:block')
vim.cmd('set incsearch')
vim.cmd('set noshowmode')
vim.cmd('set tabstop=4')

vim.keymap.set(
  'n',
  'k',
  'v:count == 0 ? "gk" : "k""',
  { expr = true, silent = true }
)
vim.keymap.set(
  'n',
  'j',
  'v:count == 0 ? "gj" : "j""',
  { expr = true, silent = true }
)

return {}
