require('onedark').setup({
  styke = 'dark',
  transparent = true,
  code_style = {
    coments = 'none',
  },
  colors = {},
  highlights = {
    Delimiter = { fg = '#ABB2BF' },
    TSPunctDelimiter = { fg = '#ABB2DF' },
    TSPunctBracket = { fg = '#ABB2DF' },
    TSAttribute = { fg = '#E06C75' },
    TSField = { fg = '#E06C75' },
    TSProperty = { fg = '#E06C75' },
    TSConstant = { fg = '#D19A66' },
  },
})

require('onedark').load()
