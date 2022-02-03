local ui = require('core.utils').load_config().ui
local fg = require('core.utils').fg
local bg = require('core.utils').bg

fg('Normal', '#ABB2BF')
fg('StatusLineNC', '#ABB2BF')
bg('Pmenu', '#343A48')

if ui.transparency then
  fg('TelescopeBorder', '#ABB2BF')
  fg('TelescopePromptBorder', '#ABB2BF')
  fg('TelescopeBorder', '#ABB2BF')
end

fg('DashboardCenter', '#ABB2BF')
fg('DashboardFooter', '#ABB2BF')
fg('DashboardHeader', '#ABB2BF')
fg('DashboardShortcut', '#ABB2BF')

fg('IndentBlanklineChar', '#3F4854')

fg('Delimiter', '#ABB2BF')
fg('Comment', '#818998')
fg('TSPunctDelimiter', '#ABB2BF')
fg('TSPunctBracket', '#ABB2BF')
fg('TSPunctSpecial', '#ABB2BF')
fg('TSAttribute', '#E06C75')
fg('TSField', '#E06C75')
fg('TSSymbol', '#E5C07B')
fg('TSNamespace', '#E5C07B')
fg('TSProperty', '#E06C75')
fg('TSConstant', '#D19A66')
fg('TSTagAttribute', '#E5C07B')
