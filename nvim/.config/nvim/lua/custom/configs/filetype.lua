-- git
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'gitcommit' },
  command = 'call setpos(\'.\', [0, 1, 1, 0])',
})

-- Markdown
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown' },
  command = 'setlocal textwidth=80',
})

-- Golang
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'go' },
  command = 'setlocal tabstop=4 shiftwidth=4 softtabstop=4',
})

return {}
