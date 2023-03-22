local M = {}

M.base_30 = {
  white = '#bbc2cf',
  darker_black = '#1b1f27',
  black = '#1e222a', --  nvim bg
  black2 = '#252931',
  one_bg = '#282c34', -- real bg of onedark
  one_bg2 = '#1e222a',
  one_bg3 = '#373b43',
  grey = '#495360',
  grey_fg = '#535d6a',
  grey_fg2 = '#5c6673',
  light_grey = '#646e7b',
  red = '#c94f6d',
  baby_pink = '#e26886',
  pink = '#d85e7c',
  line = '#2a3441',
  green = '#8ebaa4',
  vibrant_green = '#a9cf76',
  blue = '#719cd6',
  nord_blue = '#86abdc',
  yellow = '#dbc074',
  sun = '#e0c989',
  purple = '#baa1e2',
  dark_purple = '#9d79d6',
  teal = '#e5c07b',
  orange = '#fe9373',
  cyan = '#63adf2',
  statusline_bg = '#202a37',
  lightbg = '#313b48',
  pmenu_bg = '#719cd6',
  folder_bg = '#719cd6',
}

M.base_16 = {
  base00 = '#192330',
  base01 = '#252f3c',
  base02 = '#313b48',
  base03 = '#3d4754',
  base04 = '#495360',
  base05 = '#c0c8d5',
  base06 = '#c7cfdc',
  base07 = '#ced6e3',
  base08 = '#e26886',
  base09 = '#fe9373',
  base0A = '#dbc074',
  base0B = '#8ebaa4',
  base0C = '#7ad4d6',
  base0D = '#86abdc',
  base0E = '#9d79d6',
  base0F = '#d85e7c',
}

M.type = 'dark'
vim.opt.bg = 'dark'

return M
