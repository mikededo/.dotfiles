-- local nvchad_modules = require('nvchad_ui').statusline
local limit_str = require('custom.utils.limit_str')

local git_module = function()
  if not vim.b.gitsigns_head or vim.b.gitsigns_git_status then
    return ''
  end

  local git_status = vim.b.gitsigns_status_dict

  local added = (git_status.added and git_status.added ~= 0)
      and ('  ' .. git_status.added)
    or ''
  local changed = (git_status.changed and git_status.changed ~= 0)
      and ('  ' .. git_status.changed)
    or ''
  local removed = (git_status.removed and git_status.removed ~= 0)
      and ('  ' .. git_status.removed)
    or ''
  local branch_name = ' ' .. limit_str(git_status.head)

  return '%#St_gitIcons#' .. branch_name .. added .. changed .. removed
end

return {
  theme = 'minimal',
  separator_style = 'round',
  overriden_modules = function()
    return {
      git = git_module,
      -- TODO: Check if NvChad/ui can be used as a plugin
      -- run = function()
      --   local def_modules = nvchad_modules.default
      --   return table.concat({
      --     def_modules.mode(),
      --     def_modules.fileInfo(),
      --     git_module(),
      --     '%=',
      --     def_modules.LSP_progress(),
      --     '%=',
      --
      --     def_modules.LSP_Diagnostics(),
      --     def_modules.LSP_status() or '',
      --     def_modules.cwd(),
      --     def_modules.cursor_position(),
      --   })
      -- end,
    }
  end,
}
