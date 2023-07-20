return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "css",
        "dockerfile",
        "fish",
        "graphql",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
      highlight = { enable = true, use_languagetree = true },
      incremental_selection = { enable = true },
      textobjects = { enable = true },
      indent = { enable = true },
    },
  },
}
