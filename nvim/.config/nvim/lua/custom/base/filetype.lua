-- git
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'gitcommit' },
  command = 'call setpos(\'.\', [0, 1, 1, 0])',
})

-- JavaScript, TypeScript
vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
  },
  command = 'setlocal tabstop=2 shiftwidth=2 softtabstop=2',
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

-- Latex
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'tex' },
  command = 'setlocal textwidth=80',
})

return {}
