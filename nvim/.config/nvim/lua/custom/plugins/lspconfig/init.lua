local capabilities = require('cmp_nvim_lsp').default_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = false

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
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

  buf_set_keymap(
    'n',
    '<space>e',
    '<cmd>lua vim.diagnostic.open_float(0, { scope = "line", border = "rounded" })<CR>',
    opts
  )
  buf_set_keymap(
    'n',
    '<space>dn',
    '<cmd>lua vim.diagnostic.goto_next()<CR>',
    opts
  )
  buf_set_keymap('n', '<space>dt', '<cmd>Telescope diagnostics<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
end

-- Enable signature
require('lsp_signature').setup()

-- require configurations
require('custom.plugins.lspconfig.servers').attach(on_attach)
-- diagnostics
require('custom.plugins.lspconfig.diagnostics').setup()

return {}
