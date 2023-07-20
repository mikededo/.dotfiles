local Util = require("lazyvim.util")

return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- disabled default mappings
      { "<leader>/", false, desc = "Grep (root dir)" },
      { "<leader>,", false, desc = "Switch Buffer" },
      { "<leader>fF", false, desc = "Find Files (cwd)" },
      { "<leader><space>", false, desc = "Find Files (root dir)" },
      { "<leader>sd", false, desc = "Document diagnostics" },
      { "<leader>sD", false, desc = "Workspace diagnostics" },
      { "<leader>sG", false, desc = "Grep (cwd)" },
      { "<leader>ss", false, desc = "Goto Symbol" },
      { "<leader>sS", false },
      { "<leader>uC", false, desc = "Colorscheme with preview" },
      -- added/updated mappings
      { "<leader>fw", Util.telescope("live_grep"), desc = "Find word" },
      {
        "<leader>dt",
        "<cmd>Telescope diagnostics bufnr=0<cr>",
        desc = "Document diagnostics",
      },
      {
        "<leader>dT",
        "<cmd>Telescope diagnostics<cr>",
        desc = "Workspace diagnostics",
      },
      { "<leader>sg", Util.telescope("live_grep"), desc = "Grep (root dir)" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      {
        "<leader>sH",
        "<cmd>Telescope highlights<cr>",
        desc = "Search Highlight Groups",
      },
      {
        "<leader>th",
        Util.telescope("colorscheme", { enable_preview = true }),
        desc = "Colorscheme with preview",
      },
      {
        "<leader>ds",
        Util.telescope("lsp_document_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        }),
        desc = "Goto Symbol",
      },
      {
        "<leader>dS",
        Util.telescope("lsp_dynamic_workspace_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        }),
        desc = "Goto Symbol (Workspace)",
      },
    },
    opts = {
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--hidden",
          "--smart-case",
        },
        file_ignore_patterns = {
          "^.git/",
          "^coverage*",
          "^node_modules*",
          "^target*",
        },
        initial_mode = "normal",
        prompt_prefix = "   ",
        selection_caret = "➔ ",
      },
    },
  },
}
