local present, cmp = pcall(require, 'cmp')
if not present then
  return {}
end

local nvchad_cmp = require('plugins.configs.cmp')

local compare = cmp.config.compare
local options = {
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp', keyword_length = 3 },
    { name = 'buffer', keyword_length = 3 },
    { name = 'luasnip', keyword_length = 2 },
  },
  sorting = {
    priority_weight = 2,
    comparators = {
      compare.offset,
      compare.exact,
      compare.score,
      compare.recently_used,
      compare.locality,
      compare.sort_text,
      compare.length,
      compare.order,
    },
  },
}

return vim.tbl_deep_extend('force', nvchad_cmp, options)
