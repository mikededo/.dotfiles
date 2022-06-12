vim.api.nvim_set_option('guicursor', 'i:block')
vim.cmd('set incsearch')
vim.cmd('set noshowmode')

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'go',
  callback = function()
    vim.cmd('setlocal noet ts=4 sw=4 sts=4')
  end,
})

return {}
