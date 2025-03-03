-- Part of this config is inspired/based in https://github.com/ryoppippi/dotfiles

local fmt = require('plugins.lspconfig.format')
local eslint = require('plugins.lspconfig.servers.eslint')

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

local servers = vim
  .iter({
    { 'cssls', format = false },
    { 'cssmodules_ls', format = false },
    {
      'eslint',
      format = false,
      root_dir = get_root_dir,
      filetypes = eslint.filetypes,
    },
    { 'graphql', format = false },
    { 'html', format = false },
    { 'jsonls', format = false },
    { 'lua_ls', format = false },
    { 'tailwindcss', format = false },
    { 'vtsls', format = false },
    { 'yamlls', format = false, settings = { format = { enable = false } } },
  })
  :fold({}, function(acc, t)
    acc[t[1]] = {
      on_attach = fmt.format_config(t.format),
      root_dir = t.root_dir,
      filetypes = t.filetypes,
      settings = t.settings,
    }
    return acc
  end)

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
      -- LSP Server Settings
      servers = vim.tbl_extend(
        'force',
        servers,
        require('plugins.lspconfig.servers.svelte'),
        require('plugins.lspconfig.servers.efm')
      ),
    },
    init = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          fmt.on_attach(
            assert(vim.lsp.get_client_by_id(args.data.client_id)),
            args.buf
          )
        end,
      })
    end,
    keys = get_keymaps,
  },
}
