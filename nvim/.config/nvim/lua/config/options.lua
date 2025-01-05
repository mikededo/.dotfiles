vim.cmd('set relativenumber')
vim.cmd('set incsearch')
vim.cmd('set noshowmode')
vim.cmd('set tabstop=4')
vim.cmd('set wrap')
vim.cmd('set pumblend=0')
vim.cmd('set scrolloff=0')
vim.api.nvim_set_option_value('guicursor', 'i:block', {})
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.foldcolumn = '1'

vim.g.catppuccin_flavour = 'macchiato'
vim.g.lazyvim_blink_main = true

-- git
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'gitcommit' },
  command = 'call setpos(\'.\', [0, 1, 1, 0])',
})

-- Rust
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'rust' },
  command = 'lua vim.b.autoformat=1',
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
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'svelte' },
  command = 'setlocal tabstop=4 shiftwidth=4 softtabstop=4',
})
-- for .releaserc file name, set filetype to json
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead', 'FileType' }, {
  pattern = { '.releaserc' },
  command = 'set filetype=json',
})

-- Markdown
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown' },
  command = 'setlocal textwidth=80',
})
