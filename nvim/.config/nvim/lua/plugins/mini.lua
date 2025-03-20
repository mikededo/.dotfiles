return {
  'echasnovski/mini.ai',
  opts = function()
    local ai = require('mini.ai')
    return {
      n_lines = 500,
      custom_textobjects = {
        v = ai.gen_spec.treesitter({
          a = { '@assignment.outer' },
          i = { '@assignment.inner' },
        }),
      },
    }
  end,
}
