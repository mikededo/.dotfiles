return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      opts.ensure_installed = {
        'bash',
        'css',
        'dockerfile',
        'fish',
        'graphql',
        'javascript',
        'jsdoc',
        'json',
        'jsonc',
        'lua',
        'markdown',
        'svelte',
        'tsx',
        'typescript',
        'vim',
        'yaml',
      }
      opts.highlight = { enable = true, use_languagetree = true }
      opts.incremental_selection = { enable = true }
      opts.textobjects = { enable = true }
      opts.indent = { enable = true }

      -- Register mdx as a markdown language
      vim.filetype.add({ extension = { mdx = 'mdx' } })
      vim.treesitter.language.register('markdown', 'mdx')
    end,
  },
}
