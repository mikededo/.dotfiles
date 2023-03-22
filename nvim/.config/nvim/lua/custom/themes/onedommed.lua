local M = {}

M.base_30 = {
  white = '#bbc2cf',
  darker_black = '#1b1f27',
  black = '#1e222a', --  nvim bg
  black2 = '#252931',
  one_bg = '#282c34', -- real bg of onedark
  one_bg2 = '#353b45',
  one_bg3 = '#373b43',
  grey = '#494d55',
  grey_fg = '#53575f',
  grey_fg2 = '#556f7a',
  light_grey = '#676b73',
  red = '#e06c75',
  baby_pink = '#ff8365',
  pink = '#ff75a0',
  line = '#31353d', -- for lines like vertsplit
  green = '#a7e07a',
  vibrant_green = '#a9cf76',
  nord_blue = '#81A1C1',
  blue = '#63adf2',
  yellow = '#ECBE7B',
  sun = '#f2c481',
  purple = '#dc8ef3',
  dark_purple = '#c678dd',
  teal = '#e5c07b',
  orange = '#ea9558',
  cyan = '#63adf2',
  statusline_bg = '#2d3139',
  lightbg = '#3a3e46',
  pmenu_bg = '#98be65',
  folder_bg = '#51afef',
}

M.base_16 = {
  base00 = '#1e222a',
  base01 = '#353b45',
  base02 = '#3e4451',
  base03 = '#545862',
  base04 = '#565c64',
  base05 = '#abb2bf',
  base06 = '#b6bdca',
  base07 = '#c8ccd4',
  base08 = '#e06c75',
  base09 = '#d19a66',
  base0A = '#e5c07b',
  base0B = '#98c379',
  base0C = '#e5c07b',
  base0D = '#61afef',
  base0E = '#c678dd',
  base0F = '#c8ccd4',
}

M.type = 'dark'

vim.opt.bg = 'dark'

return M
