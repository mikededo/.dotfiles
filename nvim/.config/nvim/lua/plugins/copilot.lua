return {
  'zbirenbaum/copilot-cmp',
  dependencies = 'zbirenbaum/copilot.lua',
  cond = vim.g.vscode == nil,
  opts = function()
    require('copilot').setup()
  end,
}
