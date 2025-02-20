return {
  efm = {
    on_attach = function()
      require('lspconfig').efm.setup({
        filetypes = {
          'lua',
          'rust',
          'javascript',
          'javascriptreact',
          'javascript.jsx',
          'typescript',
          'typescriptreact',
          'typescript.tsx',
          'svelte',
          'astro',
          'vue',
          'markdown',
          'markdown.mdx',
          'css',
          'scss',
          'less',
          'json',
          'jsonc',
          'graphql',
          'yaml',
        },
        init_options = {
          documentFormatting = true,
          rangeFormatting = true,
          hover = true,
          documentSymbol = true,
          codeAction = true,
          completion = true,
        },
      })
    end,
  },
}
