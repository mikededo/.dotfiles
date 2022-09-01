return {
  attach = function(on_attach)
    require('custom.plugins.lspconfig.servers.typescript').setup_diagnostics(
      on_attach
    )
    require('custom.plugins.lspconfig.servers.typescript').setup_tsserver(
      on_attach
    )
    require('custom.plugins.lspconfig.servers.jsonls').setup_jsonls(on_attach)
    require('custom.plugins.lspconfig.servers.go').setup(on_attach)
  end,
}
