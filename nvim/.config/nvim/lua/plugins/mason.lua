return {
  'mason-org/mason.nvim',
  opts = {
    ensure_installed = {
      -- general
      'efm',
      -- lua
      'lua-language-server',
      'stylua',
      -- web dev
      'typescript-language-server',
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
      -- yaml
      'yaml-language-server',
    },
  },
}
