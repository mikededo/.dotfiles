vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function(args)
    require('conform').format({ bufnr = args.buf })
  end,
})

return {
  'stevearc/conform.nvim',
  optional = false,
  enabled = true,
  opts = {
    formatters_by_ft = {
      ['javascript'] = { 'eslint_d', 'prettier' },
      ['javascriptreact'] = { 'eslint_d', 'prettier' },
      ['typescript'] = { 'eslint_d', 'prettier' },
      ['typescriptreact'] = { 'eslint_d', 'prettier' },
      ['vue'] = { 'eslint_d', 'prettier' },
      ['css'] = { 'prettier' },
      ['scss'] = { 'prettier' },
      ['less'] = { 'prettier' },
      ['html'] = { 'prettier' },
      ['json'] = { 'prettier' },
      ['jsonc'] = { 'prettier' },
      ['yaml'] = { 'prettier' },
      ['markdown'] = { 'prettier' },
      ['markdown.mdx'] = { 'prettier' },
      ['graphql'] = { 'prettier' },
      ['handlebars'] = { 'prettier' },
    },
  },
}
