local nvim_lsp = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

return {
  setup = function(on_attach)
    nvim_lsp.bashls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end,
}
