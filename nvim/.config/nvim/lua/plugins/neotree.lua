return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    cmd = 'Neotree',
    keys = function()
      -- override all keymaps
      return {
        {
          '<C-n>',
          function()
            require('neo-tree.command').execute({
              toggle = true,
              dir = require('lazyvim.util').get_root(),
            })
          end,
          desc = 'Explorer NeoTree (root dir)',
        },
      }
    end,
    opts = {
      popup_border_style = 'NC',
      sources = { 'filesystem', 'buffers', 'git_status', 'document_symbols' },
      hide_root_node = true,
      open_files_do_not_replace_types = {
        'terminal',
        'Trouble',
        'qf',
        'Outline',
      },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignore = false,
          never_show = {
            '.DS_Store',
          },
        },
      },
      window = {
        mappings = {
          ['<space>'] = 'none',
          ['s'] = 'none', -- disable open split
          ['S'] = 'none', -- disable open vsplit
          ['w'] = 'none', -- disable open with window picker
          ['y'] = function(state)
            local node = state.tree:get_node()

            print('Yanked: ' .. node.name)
            vim.fn.setreg('"', node.name)
            vim.fn.setreg('1', node.name)
            vim.fn.setreg('+', node.name)
          end,
          ['Y'] = function(state)
            -- Copy pathlocal filepath = node:get_id()
            local node = state.tree:get_node()
            local filepath = node:get_id()
            local value = vim.fn.fnamemodify(filepath, ':.')

            print('Yanked: ' .. value)
            vim.fn.setreg('"', value)
            vim.fn.setreg('1', value)
            vim.fn.setreg('+', value)
          end,
          ['<C-x>'] = 'split_with_window_picker',
          ['<C-v>'] = 'vsplit_with_window_picker',
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true,
          expander_collapsed = '',
          expander_expanded = '',
          expander_highlight = 'NeoTreeExpander',
        },
        name = { use_git_status_colors = false },
        git_status = {
          symbols = {
            added = '◉',
            modified = 'Δ',
            deleted = '○',
            renamed = '~',
            untracked = '?',
            ignored = '◌',
            unstaged = '●',
            staged = '✓',
            conflict = '◎',
          },
        },
      },
    },
  },
}
