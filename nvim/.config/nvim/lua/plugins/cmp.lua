return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-emoji',
      'zbirenbaum/copilot-cmp',
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local lspkind = require('lspkind')
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0
            and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s')
            == nil
      end

      local luasnip = require('luasnip')
      local cmp = require('cmp')

      opts.mapping = vim.tbl_extend('force', opts.mapping, {
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      })

      ---@diagnostic disable-next-line: missing-fields
      opts.formatting = {
        fields = { 'kind', 'abbr', 'menu' },
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
