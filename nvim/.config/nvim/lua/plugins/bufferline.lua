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
          require('snacks').bufdelete()
        end,
        { desc = 'Delete current buffer' },
      },
    },
  },
}
