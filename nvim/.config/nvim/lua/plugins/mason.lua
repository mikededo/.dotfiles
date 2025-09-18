return {
  'mason-org/mason.nvim',
  opts = {
    ensure_installed = {
      -- lua
      'lua-language-server',
      'stylua',
      -- web dev
      'vtsls',
      'diagnostic-languageserver',
      'svelte-language-server',
      'eslint_d',
      'prettierd',
      'json-lsp',
      'tailwindcss-language-server',
      -- back end
      'rustfmt',
      'rust-analyzer',
      -- other
      'dockerfile-language-server',
      'bash-language-server',
      'actionlint',
      -- yaml
      'yaml-language-server',
      -- NOTE: efm removed in favor of conform.nvim + nvim-lint
    },
  },
}
