--- @param name string
local function disable(name)
  return { name, enabled = false }
end

return {
  disable('catppuccin/nvim'),
  disable('echasnovski/mini.indentscope'),
  disable('folke/flash.nvim'),
  -- disable('folke/tokyonight.nvim'),
  disable('zbirenbaum/copilot-cmp'),
  disable('zbirenbaum/copilot.lua'),
  -- disable('L3MON4D3/LuaSnip'),
  -- disable('rafamadriz/friendly-snippets'),
  disable('rcarriga/nvim-notify'),
}
