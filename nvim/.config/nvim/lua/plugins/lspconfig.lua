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
    if client == nil then
      return
    end
    if client.server_capabilities == nil then
      client.server_capabilities = {}
    end

    client.server_capabilities.semanticTokensProvider = nil
    if client.name == 'svelte' then
      client.capabilities.workspace =
        vim.lsp.protocol.make_client_capabilities().workspace
      client.capabilities.workspace.didChangeWatchedFiles.dynamicRegistration =
        true
      client.capabilities.workspace.didChangeWatchedFiles.relativePatternSupport =
        true
    end
  end,
})

-- Disable autoformat
vim.g.autoformat = false

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

require('lazyvim.util').lsp.on_attach(function(client)
  if client.name == 'tsserver' then
    client.server_capabilities.documentFormattingProvider = false
  end
end)

return {
  {
    'neovim/nvim-lspconfig',
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
      servers = {
        cssls = {},
        cssmodules_ls = {},
        eslint = { root_dir = get_root_dir },
        graphql = {},
        html = {},
        jsonls = {},
        lua_ls = {},
        tailwindcss = {},
        ---@type vim.lsp.ClientConfig
        svelte = {
          on_attach = function(client)
            vim.api.nvim_create_autocmd('BufWritePost', {
              pattern = { '*.js', '*.ts' },
              callback = function(ctx)
                client.notify('$/onDidChangeTsOrJsFile', { uri = ctx.match })
              end,
            })
          end,
        },
        yamlls = {},
      },
    },
    keys = get_keymaps,
  },
}
