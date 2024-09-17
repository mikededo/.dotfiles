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
      ['css'] = { 'prettierd' },
      ['graphql'] = { 'prettierd' },
      ['html'] = { 'prettierd' },
      ['javascript'] = { 'eslint_d', 'prettierd' },
      ['javascriptreact'] = { 'eslint_d', 'prettierd' },
      ['json'] = { 'prettierd' },
      ['jsonc'] = { 'prettierd' },
      ['less'] = { 'prettierd' },
      ['markdown'] = { 'prettierd' },
      ['markdown.mdx'] = { 'prettierd' },
      ['scss'] = { 'prettierd' },
      ['svelte'] = { 'eslint' },
      ['typescript'] = { 'eslint_d', 'prettierd' },
      ['typescriptreact'] = { 'eslint_d', 'prettierd' },
      ['vue'] = { 'eslint_d', 'prettierd' },
      ['yaml'] = { 'prettierd' },
    },
  },
}
