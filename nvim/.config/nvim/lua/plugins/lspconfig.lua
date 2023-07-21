local signs = {
  { name = 'DiagnosticSignError', text = '' },
  { name = 'DiagnosticSignWarn', text = '' },
  { name = 'DiagnosticSignHint', text = '' },
  { name = 'DiagnosticSignInfo', text = '' },
}

return {
  {
    'neovim/nvim-lspconfig',
    ---@class PluginLspOpts
    opts = {
      autoformat = false,
      -- options for vim.diagnostic.config()
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
      -- LSP Server Settings
      ---@type lspconfig.options
      servers = {
        cssls = {},
        cssmodules_ls = {},
        diagnosticls = {},
        emmet_ls = {},
        graphql = {},
        html = {},
        jsonls = {},
        lua_ls = {},
        tsserver = {},
        yamlls = {},
      },
    },
    keys = function()
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
        vim.diagnostic.goto_next,
        desc = 'Go to next diagnostic',
      }
      keys[#keys + 1] = {
        '<leader>dN',
        vim.diagnostic.goto_prev,
        desc = 'Go to prev diagnostic',
      }
    end,
  },
}
