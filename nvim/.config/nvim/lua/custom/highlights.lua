local ui = require('core.utils').load_config().ui
local fg = require('core.utils').fg

fg('Normal', '#ABB2BF')

if ui.transparency then
  fg('TelescopeBorder', '#ABB2BF')
  fg('TelescopePromptBorder', '#ABB2BF')
  fg('TelescopeBorder', '#ABB2BF')
end

fg('Delimiter', '#ABB2BF')
fg('Comment', '#818998')
fg('TSPunctDelimiter', '#ABB2BF')
fg('TSPunctBracket', '#ABB2BF')
fg('TSPunctSpecial', '#ABB2BF')
fg('TSAttribute', '#E06C75')
fg('TSField', '#E06C75')
fg('TSProperty', '#E06C75')
fg('TSConstant', '#D19A66')
