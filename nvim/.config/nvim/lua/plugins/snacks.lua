local uv = vim.uv or vim.loop

return {
  'folke/snacks.nvim',
  ---@type snacks.Config
  opts = {
    notifier = { enabled = false },
    notify = { enabled = false },
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
