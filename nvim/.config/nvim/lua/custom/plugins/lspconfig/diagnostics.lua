return {
  setup = function()
    vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics,
      {
        underline = true,
        -- This sets the spacing and the prefix, obviously.
        virtual_text = {
          spacing = 2,
          prefix = '',
        },
        update_in_insert = true,
      }
    )
  end,
}
