--- @param name string
local function disable(name)
  return { name, enabled = false }
end

return {
  -- disable tokyonight
  disable("folke/tokyonight.nvim"),
  disable("catppuccin/nvim"),
  disable("folke/flash.nvim"),
  disable("echasnovski/mini.indentscope"),
  disable("rcarriga/nvim-notify"),
}
