return {
  'nvimtools/none-ls.nvim',
  config = function()
    local nls = require('null-ls')
    nls.setup({
      debug = false,
      debounce = 50,
      save_after_format = false,
      sources = {
        nls.builtins.code_actions.eslint_d,
        nls.builtins.diagnostics.eslint_d,
        nls.builtins.diagnostics.fish,
        nls.builtins.diagnostics.stylelint,
        nls.builtins.diagnostics.tsc,
        nls.builtins.formatting.fish_indent,
        nls.builtins.formatting.prettierd.with({
          filetypes = {
            'astro',
            'css',
            'graphql',
            'html',
            'javascript',
            'javascriptreact',
            'json',
            'less',
            'markdown',
            'scss',
            'svelte',
            'typescript',
            'typescriptreact',
            'yaml',
          },
        }),
        nls.builtins.formatting.shfmt,
        nls.builtins.formatting.stylelint,
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.trim_newlines,
        nls.builtins.formatting.trim_whitespace,
      },
      root_dir = require('null-ls.utils').root_pattern(
        'package.json',
        '.null-ls-root',
        '.neoconf.json',
        '.git'
      ),
    })
  end,
}
