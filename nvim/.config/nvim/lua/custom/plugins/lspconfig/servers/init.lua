local servers = 'custom.plugins.lspconfig.servers'
local serverPath = function(server)
  return servers .. '.' .. server
end

local docker = require(serverPath('docker'))
local go = require(serverPath('go'))
local jsonls = require(serverPath('jsonls'))
local ts = require(serverPath('typescript'))
local yaml = require(serverPath('yaml'))

return {
  attach = function(on_attach)
    docker.setup(on_attach)
    go.setup(on_attach)
    jsonls.setup_jsonls(on_attach)
    ts.setup_diagnostics(on_attach)
    ts.setup_tailwindcss(on_attach)
    ts.setup_tsserver(on_attach)
    yaml.setup(on_attach)
  end,
}
