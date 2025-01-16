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
          FloatBorder = { bg = C.mantle },
          FloatTitle = { fg = C.text, bg = C.mantle },
          NormalFloat = { fg = C.text, bg = C.mantle },

          -- Snacks specific
          SnacksPickerMatch = { fg = C.mauve, style = { 'italic' } },
          SnacksPickerInput = { fg = C.text, bg = C.crust },
          SnacksPickerInputTitle = { fg = C.crust, bg = C.mauve },
          SnacksPickerInputBorder = { fg = C.text, bg = C.crust },
          SnacksPickerListTitle = { fg = C.mantle, bg = C.red },
          SnacksPickerListCursorLine = { bg = C.base },
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
