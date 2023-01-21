local nvim_lsp = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local setup_go = function(on_attach)
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
end

local setup_golang_lint = function(on_attach)
  nvim_lsp.golangci_lint_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

return {
  setup_go = setup_go,
  setup_golang_lint = setup_golang_lint,
}
