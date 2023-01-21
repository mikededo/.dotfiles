local present, schemastore = pcall(require, 'schemastore')
if not present then
  return
end

local M = {}
local nvim_lsp = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

M.setup_jsonls = function(on_attach)
  nvim_lsp.jsonls.setup({
    on_attach,
    capabilities = capabilities,
    settings = {
      json = {
        schemas = schemastore.json.schemas(),
      },
    },
  })
end

return M
