-- Use lualine's internal git branch helpers for non-jj repos.
-- Do not call git.init() here: it registers a lualine autocmd group that
-- does not exist yet at module load time in this config.
local git = require('lualine.components.branch.git_branch')

local jj_symbol = '∂'

local jj_cache = {
  root = nil, -- string path if inside a jj repo, false if not
  result = '',
  last_cwd = nil,
  dirty = true,
}

local augroup = vim.api.nvim_create_augroup('LualineJjBranch', { clear = true })
vim.api.nvim_create_autocmd({ 'DirChanged', 'BufWritePost', 'FocusGained' }, {
  group = augroup,
  callback = function()
    jj_cache.dirty = true
  end,
})

local function find_jj_root(dir)
  local path = dir
  while true do
    if vim.fn.isdirectory(path .. '/.jj') == 1 then
      return path
    end
    local parent = vim.fn.fnamemodify(path, ':h')
    if parent == path then
      return false
    end -- false = "checked, not found"
    path = parent
  end
end

local function jj_status()
  local out = vim.fn.system({
    'jj',
    'log',
    '-r',
    '@',
    '--no-graph',
    '--ignore-working-copy',
    '--template',
    'change_id ++ "\\n" ++ change_id.shortest() ++ "\\n" ++ bookmarks',
  })
  if vim.v.shell_error ~= 0 or out == '' then
    return ''
  end

  local lines = vim.split(vim.trim(out), '\n')
  local change_id = vim.trim(lines[1] or '')
  local shortest_id = vim.trim(lines[2] or '')
  local bookmarks = vim.trim(lines[3] or '')
  local shortest_len = #shortest_id
  local short_part = change_id:sub(1, shortest_len)
  local rest_part = change_id:sub(shortest_len + 1, 8)
  local bookmark_text = bookmarks ~= '' and bookmarks or '[~]'

  return ('%s %%#VcsJJShortestChangeId#%s%%#VcsJJRestChangeId#%s%%#Normal# %s%%*'):format(
    jj_symbol,
    short_part,
    rest_part,
    bookmark_text
  )
end

local function vcs_branch()
  local cwd = vim.fn.getcwd()
  local cwd_changed = cwd ~= jj_cache.last_cwd

  -- Re-detect jj root whenever cwd changes or cache is dirty.
  if cwd_changed or jj_cache.dirty then
    jj_cache.last_cwd = cwd
    jj_cache.dirty = false
    jj_cache.root = find_jj_root(cwd)

    if jj_cache.root then
      jj_cache.result = jj_status()
    end
  end

  if jj_cache.root then
    -- jj repo: return our cached result.
    return jj_cache.result
  else
    -- git repo: delegate entirely to lualine's internal module.
    -- Refresh git dir/branch cache explicitly before reading.
    git.find_git_dir()
    local branch = git.get_branch()
    return branch ~= '' and ' ' .. branch or ''
  end
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  opts = function()
    local icons = require('lazyvim.config').icons

    return {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = { 'alpha', 'dashboard', 'lazy ' },
        always_divide_middle = true,
        globalstatus = true,
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { { vcs_branch, color = 'Normal' } },
        lualine_c = {
          {
            'diagnostics',
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          {
            'filetype',
            icon_only = true,
            separator = '',
            padding = { left = 1, right = 0 },
          },
          {
            'filename',
            path = 1,
            symbols = { modified = '  ', readonly = '', unnamed = '' },
          },
        },
        lualine_x = {
          {
            function()
              return require('noice').api.status.command.get()
            end,
            cond = function()
              return package.loaded['noice']
                and require('noice').api.status.command.has()
            end,
            color = 'Statement',
          },
          {
            function()
              return require('noice').api.status.mode.get()
            end,
            cond = function()
              return package.loaded['noice']
                and require('noice').api.status.mode.has()
            end,
            color = 'Constant',
          },
          {
            require('lazy.status').updates,
            cond = require('lazy.status').has_updates,
            color = 'Special',
          },
          {
            'diff',
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
          },
        },
        lualine_y = {
          {
            function()
              local line = vim.fn.line('.')
              local col = vim.fn.charcol('.')
              return line .. '·' .. col
            end,
            color = 'Normal',
          },
        },
        lualine_z = {
          function()
            return ' ' .. os.date('%R')
          end,
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { 'neo-tree' },
    }
  end,
}
