-- Part of this config is inspired/based in https://github.com/ryoppippi/dotfiles

local signs = {
  { name = 'DiagnosticSignError', text = '' },
  { name = 'DiagnosticSignWarn', text = '' },
  { name = 'DiagnosticSignHint', text = '' },
  { name = 'DiagnosticSignInfo', text = '' },
}

local function get_preferences()
  if vim.fn.getcwd():find('stackweb') then
    return {
      importModuleSpecifier = 'non-relative',
    }
  end

  return {}
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
        vtsls = {
          settings = {
            typescript = {
              preferences = get_preferences(),
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
              classFunctions = {
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
        ruff = {
          init_options = {
            settings = {
              configurationPreference = 'filesystemFirst',
            },
          },
        },
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                typeCheckingMode = 'standard',
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = 'openFilesOnly',
                indexing = true,
                autoImportCompletions = true,
                exclude = {
                  '**/node_modules',
                  '**/__pycache__',
                  '**/.venv',
                  '**/venv',
                  '**/.git',
                },
              },
            },
            python = { pythonPath = vim.fn.getcwd() .. '/.venv/bin/python' },
          },
        },
      },
    },
  },
}
