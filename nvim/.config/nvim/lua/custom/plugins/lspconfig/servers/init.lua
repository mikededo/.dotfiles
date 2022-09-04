local servers = 'custom.plugins.lspconfig.servers'
local ts = require(servers .. '.typescript')
local jsonls = require(servers .. '.jsonls')
local go = require(servers .. '.go')

return {
  attach = function(on_attach)
    ts.setup_diagnostics(on_attach)
    ts.setup_tsserver(on_attach)
    ts.setup_tailwindcss(on_attach)
    jsonls.setup_jsonls(on_attach)
    go.setup(on_attach)
  end,
}
