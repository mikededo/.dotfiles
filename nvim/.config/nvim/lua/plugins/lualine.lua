return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  opts = function()
    local icons = require('lazyvim.config').icons

    return {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = { 'alpha', 'dashboard', 'lazy ' },
        always_divide_middle = true,
        globalstatus = true,
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { { 'branch', color = 'Normal' } },
        lualine_c = {
          {
            'diagnostics',
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          {
            'filetype',
            icon_only = true,
            separator = '',
            padding = { left = 1, right = 0 },
          },
          {
            'filename',
            path = 1,
            symbols = { modified = '  ', readonly = '', unnamed = '' },
          },
        },
        lualine_x = {
          {
            function()
              return require('noice').api.status.command.get()
            end,
            cond = function()
              return package.loaded['noice']
                and require('noice').api.status.command.has()
            end,
            color = 'Statement',
          },
          {
            function()
              return require('noice').api.status.mode.get()
            end,
            cond = function()
              return package.loaded['noice']
                and require('noice').api.status.mode.has()
            end,
            color = 'Constant',
          },
          {
            require('lazy.status').updates,
            cond = require('lazy.status').has_updates,
            color = 'Special',
          },
          {
            'diff',
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
          },
        },
        lualine_y = {
          {
            function()
              local line = vim.fn.line('.')
              local col = vim.fn.charcol('.')
              return line .. '·' .. col
            end,
            color = 'Normal',
          },
        },
        lualine_z = {
          function()
            return ' ' .. os.date('%R')
          end,
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { 'neo-tree' },
    }
  end,
}
