local concat = require('custom.utils.concat')

local opts = {
  cmp = require('custom.configs.cmp'),
  indent_blankline = require('custom.configs.indent-blankline'),
  mason = require('custom.configs.mason'),
  nvimtree = require('custom.configs.nvimtree'),
  telescope = require('custom.configs.telescope'),
  treesitter = require('custom.configs.treesitter'),
  user = require('custom.configs.user'),
}

local default_plugins = {
  { 'hrsh7th/nvim-cmp', opts = opts.cmp },
  { 'lukas-reineke/indent-blankline.nvim', opts = opts.indent_blankline },
  { 'nvim-tree/nvim-tree.lua', opts = opts.nvimtree },
  { 'nvim-telescope/telescope.nvim', opts = opts.telescope },
  { 'nvim-treesitter/nvim-treesitter', opts = opts.treesitter },
  {
    'williamboman/mason.nvim',
    config = function(_, plugin_opts)
      dofile(vim.g.base46_cache .. 'mason')
      require('mason').setup(plugin_opts)

      vim.api.nvim_create_user_command('MasonInstallAll', function()
        vim.cmd('MasonInstall ' .. table.concat(opts.mason.ensure_installed, ' '))
      end, {})
    end,
  },
}

return concat(default_plugins, require('custom.configs.user'))
