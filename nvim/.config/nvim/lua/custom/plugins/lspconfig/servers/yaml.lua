local nvim_lsp = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
require('cmp_nvim_lsp').update_capabilities(capabilities)

return {
  setup = function(on_attach)
    nvim_lsp.yamlls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end,
}
