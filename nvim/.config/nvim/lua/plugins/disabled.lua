local function disable(name)
  return { name, enabled = false }
end

return {
  disable('SmiteshP/nvim-navic'),
  disable('echasnovski/mini.indentscope'),
  disable('folke/flash.nvim'),
  disable('folke/persistence.nvim'),
  disable('rcarriga/nvim-notify'),
}
