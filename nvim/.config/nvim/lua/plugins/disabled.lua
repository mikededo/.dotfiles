local function disable(name)
  return { name, enabled = false }
end

return {
  disable('SmiteshP/nvim-navic'),
  disable('echasnovski/mini.indentscope'),
  disable('folke/flash.nvim'),
  disable('folke/noice.nvim'),
  disable('folke/persistence.nvim'),
  disable('folke/tokyonight.nvim'),
  disable('ibhagwan/fzf-lua'),
  disable('rcarriga/nvim-notify'),
  disable('zbirenbaum/copilot-cmp'),
}
