return {
  {
    'catppuccin/nvim',
    lazy = false,
    priority = 1000,
    opts = {
      flavour = 'macchiato',
      color_overrides = {
        macchiato = {
          rosewater = '#efc9c2',
          flamingo = '#ebb2b2',
          pink = '#f2a7de',
          mauve = '#b889f4',
          red = '#ea7183',
          maroon = '#ea838c',
          peach = '#f39967',
          yellow = '#eaca89',
          green = '#96d382',
          teal = '#78cec1',
          sky = '#91d7e3',
          sapphire = '#68bae0',
          blue = '#739df2',
          lavender = '#a0a8f6',
          text = '#b5c1f1',
          subtext1 = '#a6b0d8',
          subtext0 = '#959ec2',
          overlay2 = '#848cad',
          overlay1 = '#717997',
          overlay0 = '#6e738d',
          surface2 = '#5b6078',
          surface1 = '#494d64',
          surface0 = '#363a4f',
          base = '#24273a',
          mantle = '#1e2030',
          crust = '#181926',
        },
      },
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
    end,
  },
  {
    'LazyVim/LazyVim',
    opts = {
      colorscheme = 'catppuccin',
    },
  },
}
