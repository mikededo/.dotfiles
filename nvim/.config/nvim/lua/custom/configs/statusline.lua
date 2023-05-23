local limit_str = require('custom.utils.limit_str')

local git_module = function()
  if not vim.b.gitsigns_head or vim.b.gitsigns_git_status then
    return ''
  end

  local git_status = vim.b.gitsigns_status_dict

  local added = (git_status.added and git_status.added ~= 0) and ('  ' .. git_status.added) or ''
  local changed = (git_status.changed and git_status.changed ~= 0)
      and ('  ' .. git_status.changed)
    or ''
  local removed = (git_status.removed and git_status.removed ~= 0)
      and ('  ' .. git_status.removed)
    or ''
  local branch_name = ' ' .. limit_str(git_status.head)

  return '%#St_gitIcons#' .. branch_name .. added .. changed .. removed
end

local lsp_progress_module = function()
  if not rawget(vim, 'lsp') then
    return ''
  end

  local config = require('core.utils').load_config().ui.statusline
  local Lsp = vim.lsp.util.get_progress_messages()[1]

  if vim.o.columns < 120 or not Lsp then
    return ''
  end

  local msg = Lsp.message or ''
  local percentage = Lsp.percentage or 0
  local title = Lsp.title or ''
  local spinners = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷' }
  local ms = vim.loop.hrtime() / 1000000
  local frame = math.floor(ms / 120) % #spinners
  local content =
    string.format(' %%<%s %s %s (%s%%%%) ', spinners[frame + 1], title, msg, percentage)

  if config.lsprogress_len then
    content = string.sub(content, 1, config.lsprogress_len)
  end

  return ('%#St_LspProgress#' .. content) or ''
end

return {
  theme = 'minimal',
  separator_style = 'round',
  overriden_modules = function()
    return {
      git = git_module,
      LSP_progress = lsp_progress_module,
    }
  end,
}
