local colors = require('onenord.colors').load()

require('onenord').setup({
  theme = 'dark',
  borders = true,
  fade_nc = false,
  styles = {
    comments = 'NONE',
    strings = 'NONE',
    keywords = 'NONE',
    functions = 'NONE',
    variables = 'NONE',
    diagnostics = 'underline',
  },
  disable = {
    background = false,
    float_background = false,
    cursorline = false,
    eob_lines = true,
  },
  inverse = {
    match_paren = false,
  },
  custom_highlights = {
    FloatBorder = { bg = colors.bg, fg = colors.blue },
    FloatTitle = { fg = colors.fg, bg = colors.bg },
    NormalFloat = { fg = colors.fg, bg = colors.bg },

    -- NeoTree
    NeoTreeTitleBar = { fg = colors.blue, bg = colors.bg },
    NeoTreeFloatBorder = { fg = colors.blue, bg = colors.bg },
    NeoTreeFloatTitle = { fg = colors.blue },

    -- Snacks specific
    SnacksPickerMatch = { fg = colors.purple, style = { 'italic' } },
    SnacksPickerInput = { fg = colors.fg, bg = colors.bg },
    SnacksPickerInputTitle = { fg = colors.bg, bg = colors.purple },
    SnacksPickerInputBorder = { fg = colors.fg, bg = colors.bg },
    SnacksPickerListTitle = { fg = colors.bg, bg = colors.red },
    SnacksPickerListCursorLine = { bg = colors.bg },
    SnacksInputBorder = { bg = colors.bg, fg = colors.blue },
    SnacksInputTitle = { bg = colors.bg, fg = colors.blue },
    SnacksInputIcon = { bg = colors.bg, fg = colors.blue },
    SnacksInputNormal = { bg = colors.bg, fg = colors.fg },

    -- WhichKey
    WhichKeyBorder = { fg = colors.blue, bg = colors.bg },

    -- VCS Lualine
    VcsJJShortestChangeId = {
      fg = colors.blue,
      bg = colors.bg,
      style = { 'bold' },
    },
    VcsJJRestChangeId = { fg = colors.grey, bg = colors.bg },

    -- There was a change of colors in here, which I dislike. This reverts
    -- some of them to keep the syntax emphasis close to the Catppuccin setup.
    ['@variable.member'] = { fg = colors.blue },
    ['@module'] = {
      fg = colors.blue,
    },
    ['@string.special.url'] = {
      fg = colors.cyan,
      style = { 'italic', 'underline' },
    },
    ['@type.builtin'] = {
      fg = colors.yellow,
    },
    ['@property'] = { fg = colors.blue },
    ['@constructor'] = { fg = colors.dark_blue },
    ['@keyword.operator'] = { link = 'Operator' },
    ['@keyword.directive.css'] = { link = 'Keyword' },
    ['@keyword.export'] = { fg = colors.cyan },
    ['@tag'] = { fg = colors.purple },
    ['@tag.attribute'] = {
      fg = colors.green,
    },
    ['@property.css'] = { fg = colors.blue },
    ['@property.id.css'] = { fg = colors.cyan },
    ['@type.tag.css'] = { fg = colors.purple },
    ['@string.plain.css'] = { fg = colors.orange },
    ['@constructor.lua'] = { fg = colors.dark_blue },
    ['@property.typescript'] = {
      fg = colors.blue,
    },
    ['@constructor.typescript'] = { fg = colors.blue },
    ['@constructor.tsx'] = { fg = colors.blue },
    ['@tag.attribute.tsx'] = {
      fg = colors.green,
    },
  },
})
