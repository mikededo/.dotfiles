local nvim_lsp = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

return {
  setup = function(on_attach)
    nvim_lsp.ltex.setup({
      on_attach,
      capabilities = capabilities,
      settings = { ltex = { language = 'en-GB' } },
    })
  end,
}
