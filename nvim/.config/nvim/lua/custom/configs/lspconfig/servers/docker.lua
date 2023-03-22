local nvim_lsp = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

return {
  setup = function(on_attach)
    nvim_lsp.dockerls.setup({
      cmd = { 'docker-langserver', '--stdio' },
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end,
}
