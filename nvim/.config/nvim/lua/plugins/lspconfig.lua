---@diagnostic disable: missing-fields

local signs = {
  { name = 'DiagnosticSignError', text = '' },
  { name = 'DiagnosticSignWarn', text = '' },
  { name = 'DiagnosticSignHint', text = '' },
  { name = 'DiagnosticSignInfo', text = '' },
}

-- Disable semantics from LSP
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil
  end,
})

-- Disable autoformat
vim.g.autoformat = false

local get_root_dir = function(fname)
  local util = require('lspconfig.util')
  return util.root_pattern('.git')(fname)
    or util.root_pattern('package.json', 'tsconfig.json')(fname)
end

return {
  {
    'neovim/nvim-lspconfig',
    setup = {
      eslint = function()
        require('lazyvim.util').lsp.on_attach(function(client)
          if client.name == 'eslint' then
            client.server_capabilities.documentFormattingProvider = true
          elseif client.name == 'tsserver' then
            client.server_capabilities.documentFormattingProvider = false
          end
        end)
      end,
    },
    ---@class PluginLspOpts
    opts = {
      -- options for vim.diagnostic.config()
      inlay_hints = { enabled = false },
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
      ---@type lsp
      servers = {
        cssls = {},
        cssmodules_ls = {},
        eslint = {
          root_dir = get_root_dir,
          filetypes = {
            'javascript',
            'javascript.jsx',
            'javascriptreact',
            'tsx',
            'typescript',
            'typescript.tsx',
            'typescriptreact',
            'svelte',
          },
        },
        graphql = {},
        html = {},
        jsonls = {},
        lua_ls = {},
        tailwindcss = {},
        svelte = {
          on_attach = function()
            vim.api.nvim_create_autocmd('BufWritePre', {
              callback = function()
                LazyVim.format({ force = true })
              end,
            })

            --  TODO: Check if still required
            -- -- Update svelte client on ts/js save
            -- vim.api.nvim_create_autocmd('BufWritePost', {
            --   pattern = { '*.js', '*.ts' },
            --   group = vim.api.nvim_create_augroup(
            --     'svelte_ondidchangetsorjsfile',
            --     { clear = true }
            --   ),
            --   callback = function(ctx)
            --     client.notify('$/onDidChangeTsOrJsFile', { uri = ctx.match })
            --   end,
            -- })
          end,
        },
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
        function() vim.diagnostic.jump({ count = 1 }) end,
        desc = 'Go to next diagnostic',
      }
      keys[#keys + 1] = {
        '<leader>dN',
        function() vim.diagnostic.jump({ count = -1 }) end,
        desc = 'Go to prev diagnostic',
      }
    end,
  },
}
