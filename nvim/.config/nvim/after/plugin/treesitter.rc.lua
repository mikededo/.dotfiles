-- Treesitter configurations and mappings
local status, treesitter = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

treesitter.setup {
  ensure_installed = { 
    "bash",
    "css",
    "javascript",
    "jsdoc",
    "json",
    "jsonc",
    "lua",
    "tsx",
    "typescript",
    "vim",
    "yaml"
  },
  highlight = { enable = true },
  incremental_selection = { enabled = true },
  textobjects = { enabled = true }
}
