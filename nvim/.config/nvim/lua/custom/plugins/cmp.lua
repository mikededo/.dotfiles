local present, cmp = pcall(require, 'cmp')
if not present then
  return {}
end

local compare = cmp.config.compare

return {
  sources = {
    { name = 'nvim_lsp', group_index = 1 },
    { name = 'luasnip', group_index = 2 },
    { name = 'buffer', group_index = 2 },
    { name = 'path', group_index = 2 },
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
