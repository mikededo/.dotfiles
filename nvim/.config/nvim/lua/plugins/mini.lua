return {
  {
    'nvim-mini/mini.ai',
    opts = function()
      local ai = require('mini.ai')
      return {
        n_lines = 500,
        custom_textobjects = {
          A = ai.gen_spec.treesitter({
            a = { '@attribute.outer' },
            i = { '@attribute.inner' },
          }),
          v = ai.gen_spec.treesitter({
            a = { '@assignment.outer' },
            i = { '@assignment.inner' },
          }),
        },
      }
    end,
  },
  {
    'nvim-mini/mini.surround',
    version = '*',
    keys = function(_, keys)
      local mappings = {
        { 'j', desc = 'JS template', mode = { 'n', 'v' } },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      custom_surroundings = {
        ['j'] = {
          input = { '`%${().-()}`' },
          output = { left = '`${', right = '}`' },
        },
      },
    },
  },
}
