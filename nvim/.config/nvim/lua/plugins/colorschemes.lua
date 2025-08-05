return {
  {
    'catppuccin/nvim',
    lazy = false,
    priority = 10000,
    config = function(_, opts)
      require('catppuccin').setup(opts)
    end,
    opts = {
      integrations = {
        snacks = true,
      },
      custom_highlights = function(C)
        return {
          FloatBorder = { bg = C.mantle, fg = C.peach },
          FloatTitle = { fg = C.text, bg = C.mantle },
          NormalFloat = { fg = C.text, bg = C.mantle },

          -- NeoTree
          NeoTreeTitleBar = { fg = C.peach, bg = C.mantle },
          NeoTreeFloatBorder = { fg = C.peach, bg = C.mantle },
          NeoTreeFloatTitle = { fg = C.peach },

          -- Snacks specific
          SnacksPickerMatch = { fg = C.mauve, style = { 'italic' } },
          SnacksPickerInput = { fg = C.text, bg = C.crust },
          SnacksPickerInputTitle = { fg = C.crust, bg = C.mauve },
          SnacksPickerInputBorder = { fg = C.text, bg = C.crust },
          SnacksPickerListTitle = { fg = C.mantle, bg = C.red },
          SnacksPickerListCursorLine = { bg = C.base },
          SnacksInputBorder = { bg = C.base, fg = C.peach },
          SnacksInputTitle = { bg = C.base, fg = C.peach },
          SnacksInputIcon = { bg = C.base, fg = C.peach },
          SnacksInputNormal = { bg = C.base, fg = C.text },

          -- WhichKey
          WhichKeyBorder = { fg = C.peach, bg = C.mantle },

          -- There was a change of colors in here, which I dislike. This
          -- reverts some of them: https://github.com/catppuccin/nvim/pull/804
          ['@variable.member'] = { fg = C.lavender },
          ['@module'] = {
            fg = C.lavender,
          },
          ['@string.special.url'] = {
            fg = C.rosewater,
            style = { 'italic', 'underline' },
          },
          ['@type.builtin'] = {
            fg = C.yellow,
          },
          ['@property'] = { fg = C.lavender },
          ['@constructor'] = { fg = C.sapphire },
          ['@keyword.operator'] = { link = 'Operator' },
          ['@keyword.directive.css'] = { link = 'Keyword' },
          ['@keyword.export'] = { fg = C.sky },
          ['@tag'] = { fg = C.mauve },
          ['@tag.attribute'] = {
            fg = C.teal,
          },
          ['@property.css'] = { fg = C.lavender },
          ['@property.id.css'] = { fg = C.blue },
          ['@type.tag.css'] = { fg = C.mauve },
          ['@string.plain.css'] = { fg = C.peach },
          ['@constructor.lua'] = { fg = C.flamingo },
          ['@property.typescript'] = {
            fg = C.lavender,
          },
          ['@constructor.typescript'] = { fg = C.lavender },
          ['@constructor.tsx'] = { fg = C.lavender },
          ['@tag.attribute.tsx'] = {
            fg = C.teal,
          },
        }
      end,
    },
  },
  {
    'LazyVim/LazyVim',
    dependecies = { 'catppuccin/nvim' },
    opts = {
      colorscheme = 'catppuccin',
    },
  },
}
