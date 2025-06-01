return {
  'bngarren/checkmate.nvim',
  ft = 'markdown',
  keys = {
    {
      '<leader>tt',
      function()
        local root =
          string.match(require('lazyvim.util').root.get(), '([^/]+)$')
        local checkmate_dir = vim.fn.expand('~/.local/share/nvim/checkmate/')
          .. root
          .. '/'
        local filepath = checkmate_dir .. 'todo.md'

        local dir = vim.fn.fnamemodify(checkmate_dir, ':h')
        vim.fn.mkdir(dir, 'p')

        local file, err = io.open(filepath, 'w')
        if not file then
          vim.notify('Could not create todo file', vim.log.levels.ERROR)
          vim.notify(err, vim.log.levels.ERROR)
          return
        end
        file:close()

        vim.cmd('edit ' .. filepath)
      end,
      desc = 'Open/Create project todo file',
    },
  },
  opts = {},
}
