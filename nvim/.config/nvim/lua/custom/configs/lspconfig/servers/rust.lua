local capabilities = require('cmp_nvim_lsp').default_capabilities()

local setup = function(on_attach)
  require('rust-tools').setup({
    tools = { -- These apply to the default RustSetInlayHints command
      runnables = { use_telescope = true },
      inlay_hints = {
        auto = true,
        only_current_line = false,
        show_parameter_hints = false,
        parameter_hints_prefix = '-> ',
        other_hints_prefix = '-> ',
        max_len_align = false,
        max_len_align_padding = 1,
        right_align = false,
        right_align_padding = 7,
        highlight = 'Comment',
      },
    },
    server = {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        ['rust-analyzer'] = {
          imports = {
            granularity = { group = 'module' },
            prefix = 'self',
          },
          cargo = { buildScripts = { enable = true } },
          proMacro = { enable = true },
        },
      },
    },
  })
end

return {
  setup = setup,
}
