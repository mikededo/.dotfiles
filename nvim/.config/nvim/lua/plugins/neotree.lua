return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    keys = function()
      -- override all keymaps
      return {
        {
          "<C-n>",
          function()
            require("neo-tree.command").execute({
              toggle = true,
              dir = require("lazyvim.util").get_root(),
            })
          end,
          desc = "Explorer NeoTree (root dir)",
        },
      }
    end,
    opts = {
      sources = { "filesystem", "buffers", "git_status", "document_symbols" },
      open_files_do_not_replace_types = {
        "terminal",
        "Trouble",
        "qf",
        "Outline",
      },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = {
        mappings = {
          ["<space>"] = "none",
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
        name = { use_git_status_colors = false },
        git_status = {
          symbols = {
            added = "◉",
            modified = "Δ",
            deleted = "○",
            renamed = "~",
            untracked = "?",
            ignored = "◌",
            unstaged = "●",
            staged = "✓",
            conflict = "◎",
          },
        },
        filesystem = {
          filtered_items = true,
          hide_dotfiles = false,
          hide_gitignore = false,
          never_show = {
            ".DS_Store",
          },
        },
      },
    },
  },
}
