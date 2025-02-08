---@diagnostic disable: missing-fields

local fmt = require('plugins.lspconfig.format')

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end
    if client.server_capabilities == nil then
      client.server_capabilities = {}
    end

    client.server_capabilities.semanticTokensProvider = nil
  end,
})

return {
  ---@type vim.lsp.ClientConfig
  svelte = {
    on_attach = function(client)
      client.capabilities.workspace =
          vim.lsp.protocol.make_client_capabilities().workspace
      client.capabilities.workspace.didChangeWatchedFiles.dynamicRegistration =
          true
      client.capabilities.workspace.didChangeWatchedFiles.relativePatternSupport =
          true

      vim.api.nvim_create_autocmd('BufWritePost', {
        pattern = { '*.js', '*.ts' },
        callback = function(ctx)
          ---@diagnostic disable-next-line: param-type-mismatch
          client.notify('$/onDidChangeTsOrJsFile', { uri = ctx.match })
        end,
      })
      fmt.format_config(false)(client)
    end,
  }
}
