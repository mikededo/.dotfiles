local nvim_lsp = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

return {
  setup = function(on_attach)
    nvim_lsp.yamlls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end,
}
