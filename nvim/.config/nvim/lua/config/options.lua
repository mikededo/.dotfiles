vim.api.nvim_set_option('guicursor', 'i:block')
vim.cmd('set relativenumber')
vim.cmd('set incsearch')
vim.cmd('set noshowmode')
vim.cmd('set tabstop=4')
vim.cmd('set wrap')
vim.cmd('set pumblend=0')
vim.cmd('set scrolloff=0')
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.foldcolumn = '1'

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
