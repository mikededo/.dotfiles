return {
  'folke/snacks.nvim',
  ---@type snacks.Config
  opts = {
    animate = { enabled = false },
    notifier = { enabled = false },
    notify = { enabled = false },
    indent = {
      animate = { enabled = false },
      indent = { hl = 'SignColumn' },
      scope = { hl = 'FloatTitle' },
      blank = {
        char = '·',
        hl = 'SignColumn',
      },
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
  },
}
