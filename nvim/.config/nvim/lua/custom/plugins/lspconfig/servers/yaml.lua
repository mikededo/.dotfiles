local nvim_lsp = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local schemas = {
  kubernetes = '*.yaml',
  ['http://json.schemastore.org/github-workflow'] = '.github/workflows/*',
  ['http://json.schemastore.org/github-action'] = '.github/action.{yml,yaml}',
  ['http://json.schemastore.org/prettierrc'] = '.prettierrc.{yml,yaml}',
  ['https://json.schemastore.org/gitlab-ci'] = '*gitlab-ci*.{yml,yaml}',
  ['https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json'] = '*api*.{yml,yaml}',
  ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = '*docker-compose*.{yml,yaml}',
}

return {
  setup = function(on_attach)
    nvim_lsp.yamlls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = { yaml = { schemas = schemas } },
    })
  end,
}
