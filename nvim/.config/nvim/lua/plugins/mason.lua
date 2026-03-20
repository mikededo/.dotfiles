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
      'eslint-lsp',
      'eslint_d',
      'json-lsp',
      'tailwindcss-language-server',
      -- back end
      'rust-analyzer',
      -- other
      'dockerfile-language-server',
      'bash-language-server',
      'actionlint',
      -- yaml
      'yaml-language-server',
    },
  },
}
