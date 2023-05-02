local present, _ = pcall(require, 'lsp_signature')
if not present then
  return
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lsp_mappings = require('custom.configs.lspconfig.mappings')
local register_wk = require('custom.utils.register-wk')

capabilities.textDocument.completion.completionItem.snippetSupport = false

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  client.server_capabilities.semanticTokensProvider = nil

  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true, silent = true }

  for _, m in ipairs(lsp_mappings) do
    buf_set_keymap(m.mode, table.concat(m.map), m.cmd, opts)
    register_wk(m.map, m.cmd, m.mode, m.desc)
  end
end

-- Enable signature
require('lsp_signature').setup({
  bind = true,
  handler_opts = { border = 'single' },
  hint_prefix = ' ',
  hint_scheme = 'Comment',
})

-- require configurations
require('custom.configs.lspconfig.servers').attach(on_attach)
-- diagnostics
require('custom.configs.lspconfig.diagnostics').setup()

return {}
