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
        '<leader>xx',
        function()
          require('mini.bufremove').delete(vim.api.nvim_get_current_buf(), false)
        end,
        { desc = 'Delete current buffer' },
      },
    },
  },
}
