local present, schemastore = pcall(require, 'schemastore')
if not present then
  return
end

local M = {}
local nvim_lsp = require('lspconfig')

M.setup_jsonls = function(on_attach)
  nvim_lsp.jsonls.setup({
    on_attach,
    settings = {
      json = {
        schemas = schemastore.json.schemas(),
      },
    },
  })
end

return M
