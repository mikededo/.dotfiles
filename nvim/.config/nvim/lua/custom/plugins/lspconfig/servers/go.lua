local nvim_lsp = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
require('cmp_nvim_lsp').update_capabilities(capabilities)

return {
  setup = function(on_attach)
    nvim_lsp.gopls.setup({
      cmd = { 'gopls' },
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        gopls = {
          experimentalPostfixCompletions = true,
          analyses = {
            unusedparams = true,
            shadow = true,
          },
          staticcheck = true,
        },
      },
      init_options = {
        usePlaceholders = true,
      },
    })
  end,
}
