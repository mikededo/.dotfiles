vim.api.nvim_set_option('guicursor', 'i:block')
vim.cmd('set incsearch')
vim.cmd('set noshowmode')
vim.cmd('set tabstop=4')

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'gitcommit' },
  command = "call setpos('.', [0, 1, 1, 0])",
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'go' },
  command = 'setlocal tabstop=4 shiftwidth=4 softtabstop=4',
})

return {}
