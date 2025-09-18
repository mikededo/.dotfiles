-- Part of this config is inspired/based in https://github.com/ryoppippi/dotfiles

local signs = {
  { name = 'DiagnosticSignError', text = '' },
  { name = 'DiagnosticSignWarn', text = '' },
  { name = 'DiagnosticSignHint', text = '' },
  { name = 'DiagnosticSignInfo', text = '' },
}

-- Disable semantics from LSP

local get_root_dir = function(fname)
  local util = require('lspconfig.util')
  return util.root_pattern('.git')(fname)
      or util.root_pattern('package.json', 'tsconfig.json')(fname)
end

local get_keymaps = function()
  local keys = require('lazyvim.plugins.lsp.keymaps').get()

  keys[#keys + 1] = {
    '<leader>e',
    '<cmd>lua vim.diagnostic.open_float(0, { scope = "line" })<CR>',
    desc = 'Show diagnostics',
  }
  keys[#keys + 1] = { '<leader>cr', false }
  keys[#keys + 1] = {
    '<leader>rn',
    vim.lsp.buf.rename,
    desc = 'Rename',
    has = 'rename',
  }
  keys[#keys + 1] = {
    '<leader>dn',
    function()
      vim.diagnostic.jump({ count = 1 })
    end,
    desc = 'Go to next diagnostic',
  }
  keys[#keys + 1] = {
    '<leader>dN',
    function()
      vim.diagnostic.jump({ count = -1 })
    end,
    desc = 'Go to prev diagnostic',
  }
end

local servers = {
  cssls = {},
  cssmodules_ls = {},
  eslint = {
    root_dir = get_root_dir,
    filetypes = {
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
    settings = {
      workingDirectories = { mode = 'auto' },
      format = true
    }
  },
  graphql = {},
  html = {},
  jsonls = {},
  lua_ls = {},
  tailwindcss = {
    settings = {
      tailwindCSS = {
        experimental = {
          classRegex = ' (["\'`][^"\'`]*.*?["\'`])', '["\'`]([^"\'`]*).*?["\'`]',
        },
      },
    },
  },
  vtsls = {},
  yamlls = {
    settings = {
      format = { enable = false }
    }
  },
}

return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      -- options for vim.diagnostic.config()
      inlay_hints = { enabled = false },
      format = { timeout_ms = 2000 },
      diagnostics = {
        underline = true,
        update_in_insert = true,
        severity_sort = true,
        virtual_text = { spacing = 2, prefix = '' },
        signs = { active = signs },
        float = {
          focusable = true,
          style = 'minimal',
          border = 'single',
          header = '',
          prefix = '',
          source = 'if_many',
        },
      },
      servers
    },

    keys = get_keymaps,
  },
}
