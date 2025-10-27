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
      servers = {
        ['*'] = {
          keys = {
            {
              '<leader>e',
              '<cmd>lua vim.diagnostic.open_float(0, { scope = "line" })<CR>',
              desc = 'Show diagnostics',
            },
            { '<leader>cr', false },
            {
              '<leader>rn',
              vim.lsp.buf.rename,
              desc = 'Rename',
              has = 'rename',
            },
            {
              '<leader>dn',
              function()
                vim.diagnostic.jump({ count = 1 })
              end,
              desc = 'Go to next diagnostic',
            },
            {
              '<leader>dN',
              function()
                vim.diagnostic.jump({ count = -1 })
              end,
              desc = 'Go to prev diagnostic',
            },
          },
        },
        tailwindcss = {
          settings = {
            tailwindCSS = {
              validate = true,
              lint = {
                cssConflict = 'warning',
                invalidApply = 'error',
                invalidScreen = 'error',
                invalidVariant = 'error',
                invalidConfigPath = 'error',
                invalidTailwindDirective = 'error',
                recommendedVariantOrder = 'warning',
              },
              classAttributes = {
                'class',
                'className',
                'twMerge',
                'cn',
                'tv',
                'cva',
              },
            },
          },
        },
      },
    },
  },
}
