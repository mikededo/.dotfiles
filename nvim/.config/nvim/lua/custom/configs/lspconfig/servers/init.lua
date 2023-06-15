local servers = 'custom.configs.lspconfig.servers'
local serverPath = function(server)
  return servers .. '.' .. server
end

local bash = require(serverPath('bash'))
local docker = require(serverPath('docker'))
local go = require(serverPath('go'))
local jsonls = require(serverPath('jsonls'))
local rust = require(serverPath('rust'))
local ts = require(serverPath('typescript'))
local yaml = require(serverPath('yaml'))

local latex = require(serverPath('latex')) -- TODO: remove after master

return {
  attach = function(on_attach)
    bash.setup(on_attach)
    docker.setup(on_attach)
    go.setup_go(on_attach)
    go.setup_golang_lint(on_attach)
    jsonls.setup_jsonls(on_attach)
    rust.setup(on_attach)
    ts.setup_diagnostics(on_attach)
    ts.setup_tailwindcss(on_attach)
    ts.setup_tsserver(on_attach)
    yaml.setup(on_attach)
    latex.setup(on_attach)
  end,
}
