local layout = {
  reverse = false,
  layout = {
    box = 'horizontal',
    backdrop = true,
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

--- @type snacks.dashboard.Section
local dashboard = {
  enabled = true,
  width = 18,
  sections = {
    {
      hidden = true,
      key = 't',
      desc = 'Find [T]ext',
      action = ':lua Snacks.dashboard.pick(\'live_grep\')',
    },
    {
      hidden = true,
      icon = ' ',
      key = 'r',
      desc = '[R]ecent Files',
      action = ':lua Snacks.dashboard.pick(\'oldfiles\')',
    },
    {
      hidden = true,
      icon = '󰒲 ',
      key = 'l',
      desc = '[L]azy',
      action = ':Lazy',
    },

    {
      padding = 2,
      text = { { 'Neovim :: Δ Ε Δ Ο · 力', hl = 'Normal' } },
      action = ':lua Snacks.dashboard.pick(\'files\')',
      key = 'f',
    },

    {
      padding = 1,
      text = {
        { '  Find [F]ile', width = 19, hl = 'NonText' },
        { '  Find [T]ext', hl = 'NonText' },
      },
      action = ':lua Snacks.dashboard.pick(\'files\')',
      key = 'f',
    },
    {
      padding = 1,
      text = {
        { ' ', width = 3 },
        { '  [N]ew File', width = 19, hl = 'NonText' },
        { '  [R]ecent File', hl = 'NonText' },
      },
      action = ':ene | startinsert',
      key = 'n',
    },
    {
      padding = 2,
      text = {
        { ' ', width = 9 },
        { '  [C]onfig', hl = 'NonText' },
        { ' ', width = 8 },
        { '󰒲  [L]azy', hl = 'NonText' },
        { ' ', width = 14 },
      },
      action = ':lua Snacks.dashboard.pick(\'files\', {cwd = vim.fn.stdpath(\'config\')})',
      key = 'c',
    },
    {
      padding = 2,
      text = {
        { ' ', width = 5 },
        { '  [Q]uit', hl = 'NonText' },
      },
      action = ':quitall',
      key = 'q',
    },

    { section = 'startup', padding = 1 },

    { text = ' ', padding = 6 },

    {
      align = 'center',
      text = {
        '@mikededo',
        hl = 'NonText',
      },
    },
  },

  formats = { key = { '' } },
}

return {
  'folke/snacks.nvim',
  ---@type snacks.Config
  opts = {
    animate = { enabled = false },
    notifier = { enabled = false },
    notify = { enabled = false },
    image = { enabled = false },
    input = {
      win = { style = 'rename' },
      icon_pos = false,
    },
    styles = {
      rename = {
        backdrop = false,
        relative = 'cursor',
        row = 1,
        col = 1,
        border = 'single',
        title_pos = 'center',
        height = 1,
        width = 60,
        noautocmd = true,
        wo = { cursorline = false },
        bo = { filetype = 'snacks_input', buftype = 'prompt' },
        b = { completion = false },
        keys = {
          n_esc = {
            '<esc>',
            { 'cmp_close', 'cancel' },
            mode = 'n',
            expr = true,
          },
          i_esc = {
            '<esc>',
            { 'cmp_close', 'stopinsert' },
            mode = 'i',
            expr = true,
          },
          i_cr = {
            '<cr>',
            { 'cmp_accept', 'confirm' },
            mode = 'i',
            expr = true,
          },
          i_tab = {
            '<tab>',
            { 'cmp_select_next', 'cmp' },
            mode = 'i',
            expr = true,
          },
          i_ctrl_w = { '<c-w>', '<c-s-w>', mode = 'i', expr = true },
          q = 'cancel',
        },
      },
    },
    indent = {
      animate = { enabled = false },
      indent = { char = '→', hl = 'SignColumn' },
      scope = { hl = 'FloatTitle' },
      blank = { char = '·', hl = 'SignColumn' },
    },
    scroll = { enabled = false },
    dashboard = dashboard,
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
      '<leader>ff',
      function()
        Snacks.picker.files()
      end,
      desc = 'Find files',
    },
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
