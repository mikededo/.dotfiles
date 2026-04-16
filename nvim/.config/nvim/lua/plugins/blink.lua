return {
  'saghen/blink.cmp',
  build = 'cargo +nightly build --release',
  version = '1.*',
  opts = {
    appearance = {
      kind_icons = {
        Text = '󰉿',
        Method = '󰆧',
        Function = '󰊕',
        Constructor = '󰒓',
        Field = '󰜢',
        Variable = '󰆦',
        Property = '󰖷',
        Class = '󰠱',
        Interface = '',
        Struct = '󱡠',
        Module = '',
        Unit = '󰪚',
        Value = '󰎠',
        Enum = '',
        EnumMember = '',
        Keyword = '󰌋',
        Constant = '󰏿',
        Snippet = '',
        Color = '󰏘',
        File = '󰈔',
        Reference = '󰈇',
        Folder = '󰉋',
        Event = '',
        Operator = '󰆕',
        TypeParameter = '󰬛',
      },
    },
    sources = {
      compat = {},
      -- Disable all snippets
      transform_items = function(_, items)
        return vim.tbl_filter(function(item)
          return item.kind
            ~= require('blink.cmp.types').CompletionItemKind.Snippet
        end, items)
      end,
      default = { 'lsp', 'path', 'buffer' },
    },
    completion = {
      ghost_text = { enabled = false },
    },
    keymap = {
      preset = 'default',
      ['<Enter>'] = { 'accept', 'fallback' },
      ['<C-j>'] = { 'select_next', 'fallback' },
      ['<C-k>'] = { 'select_prev', 'fallback' },
      ['<Tab>'] = { 'accept', 'fallback' },
    },
  },
}
