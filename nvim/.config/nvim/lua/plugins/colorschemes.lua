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
