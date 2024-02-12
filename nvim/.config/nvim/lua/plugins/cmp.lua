return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-emoji',
      'zbirenbaum/copilot-cmp',
    },
    opts = function(_, opts)
      local lspkind = require('lspkind')
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0
          and vim.api
              .nvim_buf_get_lines(0, line - 1, line, true)[1]
              :sub(col, col)
              :match('%s')
            == nil
      end

      local cmp = require('cmp')

      opts.mapping = vim.tbl_extend('force', opts.mapping, {
        ['<C-j>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<C-k>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { 'i', 's' }),
      })
      opts.formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol',
            max_width = 50,
            symbol_map = { Copilot = '' },
          }),
        },
        format = function(entry, vim_item)
          local kind = lspkind.cmp_format({
            mode = 'symbol_text',
            maxwidth = 50,
          })(entry, vim_item)

          local strings = vim.split(kind.kind, '%s', { trimempty = true })
          kind.kind = ' ' .. strings[1] .. ' '
          kind.menu = '    (' .. strings[2] .. ')'

          return kind
        end,
      }
    end,
  },
}
