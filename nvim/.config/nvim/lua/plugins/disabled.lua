--- @param name string
local function disable(name)
  return { name, enabled = false }
end

return {
  -- disable('catppuccin/nvim'),
  disable('echasnovski/mini.indentscope'),
  disable('folke/flash.nvim'),
  disable('folke/persistence.nvim'),
  disable('zbirenbaum/copilot-cmp'),
  disable('zbirenbaum/copilot.lua'),
  disable('rcarriga/nvim-notify'),
  disable('SmiteshP/nvim-navic'),
}
