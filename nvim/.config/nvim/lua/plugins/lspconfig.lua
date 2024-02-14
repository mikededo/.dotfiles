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

local update_svelte_on_ts_js_save = function(client)
  vim.api.nvim_create_autocmd(
    { 'TextChanged', 'TextChangedI', 'TextChangedP' },
    {
      pattern = { '*.js', '*.ts' },
      callback = function(ctx)
        if client.name == 'svelte' then
          client.notify('$/onDidChangeTsOrJsFile', {
            uri = ctx.match,
            changes = {
              {
                text = table.concat(
                  vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false),
                  '\n'
                ),
              },
            },
          })
        end
      end,
      group = vim.api.nvim_create_augroup(
        'svelte_ondidchangetsorjsfile',
        { clear = true }
      ),
    }
  )
end

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
    ---@class PluginLspOpts
    opts = {
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
        eslint = { root_dir = get_root_dir },
        graphql = {},
        html = {},
        jsonls = {},
        lua_ls = {},
        svelte = {},
        tsserver = { root_dir = get_root_dir },
        yamlls = {},
      },
    },
    init = function()
      require('lazyvim.util').lsp.on_attach(function(client)
        update_svelte_on_ts_js_save(client)
      end)
    end,
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
