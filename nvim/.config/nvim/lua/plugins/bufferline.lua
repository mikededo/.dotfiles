return {
  {
    'akinsho/bufferline.nvim',
    opts = {
      options = {
        separator_style = 'thick',
      },
    },
    keys = {
      {
        '<Tab>',
        ':BufferLineCycleNext<CR>',
        { desc = 'Next buffer' },
      },
      {
        '<S-Tab>',
        ':BufferLineCyclePrev<CR>',
        { desc = 'Prev buffer' },
      },
      {
        '<leader><leader>',
        function()
          require('lazyvim.util.ui').bufremove(vim.api.nvim_get_current_buf())
        end,
        { desc = 'Delete current buffer' },
      },
    },
  },
}
