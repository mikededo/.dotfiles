local M = {}
local nvim_lsp = require('lspconfig')

-- Typescript
M.setup_tsserver = function(on_attach, capabilities)
  nvim_lsp.tsserver.setup({
    on_attach = on_attach,
    filetypes = {
      'javascript',
      'javascriptreact',
      'javascript.jsx',
      'typescript',
      'typescriptreact',
      'typescript.tsx',
      'html',
      'css',
    },
    capabilities = capabilities,
  })
end

M.setup_diagnostics = function(on_attach)
  nvim_lsp.diagnosticls.setup({
    on_attach = on_attach,
    filetypes = {
      'javascript',
      'javascriptreact',
      'json',
      'typescript',
      'typescriptreact',
      'css',
      'less',
      'scss',
      'markdown',
    },
    init_options = {
      linters = {
        eslint = {
          command = 'eslint_d',
          rootPatterns = { '.git' },
          debounce = 100,
          args = {
            '--stdin',
            '--stdin-filename',
            '%filepath',
            '--format',
            'json',
          },
          sourceName = 'eslint_d',
          parseJson = {
            errorsRoot = '[0].messages',
            line = 'line',
            column = 'column',
            endLine = 'endLine',
            endColumn = 'endColumn',
            message = '[eslint] ${message} [${ruleId}]',
            security = 'severity',
          },
          securities = {
            [2] = 'error',
            [1] = 'warning',
          },
        },
      },
      filetypes = {
        javascript = 'eslint',
        javascriptreact = 'eslint',
        typescript = 'eslint',
        typescriptreact = 'eslint',
      },
      formatters = {
        eslint_d = {
          command = 'eslint_d',
          rootPatterns = { '.git' },
          args = {
            '--stdin',
            '--stdin-filename',
            '%filename',
            '--fix-to-stdout',
          },
        },
        prettier = {
          command = 'prettier_d_slim',
          rootPatterns = { '.git' },
          args = { '--stdin', '--stdin-filepath', '%filename' },
        },
      },
    },
  })
end

return M
