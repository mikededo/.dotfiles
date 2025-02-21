return {
  'saghen/blink.cmp',
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
