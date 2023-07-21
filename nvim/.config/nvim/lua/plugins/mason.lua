return {
  'williamboman/mason.nvim',
  opts = {
    ensure_installed = {
      -- lua
      'lua-language-server',
      'stylua',
      -- web dev
      'typescript-language-server',
      'diagnostic-languageserver',
      'eslint_d',
      'prettierd',
      'json-lsp',
      'tailwindcss-language-server',
      -- back end
      'gopls',
      'golangci-lint',
      'rustfmt',
      'rust-analyzer',
      -- other
      'dockerfile-language-server',
      'bash-language-server',
      -- yaml
      'yaml-language-server',
      'yamlfmt',
    },
  },
}
