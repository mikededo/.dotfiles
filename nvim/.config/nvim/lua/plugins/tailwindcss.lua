-- Tailwind CSS
return {
  {
    'NvChad/nvim-colorizer.lua',
    cond = vim.g.vscode == nil,
    opts = {
      user_default_options = {
        tailwind = true,
      },
    },
  },
}
