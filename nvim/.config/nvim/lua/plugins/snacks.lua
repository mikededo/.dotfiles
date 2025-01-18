local layout = {
  reverse = false,
  layout = {
    box = 'horizontal',
    backdrop = false,
    width = 0.8,
    height = 0.9,
    border = 'none',
    {
      box = 'vertical',
      {
        win = 'input',
        title = ' {source} {live} ',
        title_pos = 'center',
        border = 'solid',
        height = 1,
      },
      {
        win = 'list',
        title = '  Results  ',
        title_pos = 'center',
        border = 'solid',
      },
    },
    {
      win = 'preview',
      width = 0.45,
      title_pos = 'center',
    },
  },
}

return {
  'folke/snacks.nvim',
  ---@type snacks.Config
  opts = {
    animate = { enabled = false },
    notifier = { enabled = false },
    notify = { enabled = false },
    indent = {
      animate = { enabled = false },
      indent = { char = '→', hl = 'SignColumn' },
      scope = { hl = 'FloatTitle' },
      blank = { char = '·', hl = 'SignColumn' },
    },
    scroll = { enabled = false },
    dashboard = {
      sections = {
        {
          header = [[
███╗   ██╗██╗   ██╗██╗███╗   ███╗
████╗  ██║██║   ██║██║████╗ ████║
██╔██╗ ██║██║   ██║██║██╔████╔██║
██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝]],
          padding = 1,
        },
        { title = 'Shortcuts', padding = 1 },
        { section = 'keys' },
        { section = 'startup', padding = { 0, 2 } },
      },
    },
    picker = {
      prompt = '   ',
      sources = {
        files = { hidden = true },
      },
      layout = layout,
    },
  },
  keys = {
    -- disabled default mappings
    { '<leader>/', false },
    { '<leader>,', false },
    { '<leader>fF', false },
    { '<leader><space>', false },
    { '<leader>sd', false },
    { '<leader>sD', false },
    { '<leader>sG', false },
    { '<leader>ss', false },
    { '<leader>sS', false },
    { '<leader>uC', false },
    { '<leader>x', false },
    { '<leader>xX', false },
    { '<leader><space>', false },
    { '<leader>fc', false },
    { '<leader>fg', false },
    { '<leader>fr', false },
    { '<leader>,', false },
    { '<leader>:', false },

    {
      '<leader>fw',
      function()
        Snacks.picker.grep()
      end,
      desc = 'Grep',
    },
    {
      '<leader>th',
      function()
        Snacks.picker.colorschemes()
      end,
      desc = 'Grep',
    },
  },
}
