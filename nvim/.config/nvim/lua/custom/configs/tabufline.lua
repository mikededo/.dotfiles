local api = vim.api
local fn = vim.fn

local limit = { left = '', right = '' }

local function new_hl(opts)
  local fg = opts.fg
  local bg = opts.bg
  local group1 = opts.group1
  local group2 = opts.group2
  local name = opts.name

  if group1 ~= nil and group2 ~= nil then
    fg = fn.synIDattr(fn.synIDtrans(fn.hlID(group1)), 'fg#')
    bg = fn.synIDattr(fn.synIDtrans(fn.hlID(group2)), 'bg#')
    name = 'Tbline' .. group1 .. group2
  end

  api.nvim_set_hl(0, name, { fg = fg, bg = bg })
  return '%#' .. name .. '#'
end

local hl = {
  on = new_hl({ name = 'HlCurrentBufferOn', fg = '#98c379', bg = '#252931' }),
  off = new_hl({ name = 'HlCurrentBufferOff', fg = '#676b73', bg = '#252931' }),
  icon = new_hl({ name = 'HlCurrentBufferIcon', fg = '#1E222A', bg = '#98c379' }),
  icon_off = function(icon_hl)
    return new_hl({ group1 = icon_hl, group2 = 'TbLineBufOff' })
  end,
  l_limit = new_hl({ name = 'TbBufLineLimitLeftHl', fg = '#98c379', bg = '#252931' }),
  r_limit = new_hl({ name = 'TbBufLineLimitRightHl', fg = '#1E222A', bg = '#252931' }),
  content = new_hl({ name = 'TbBufLineContentHl', fg = '#98c379', bg = '#1E222A' }),
  modified = new_hl({ name = 'TbBufLineBufModified', fg = '#e06c75', bg = '#1E222A' }),
}

local is_buf_valid = function(bufnr)
  return vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted
end

local function get_nvimtree_width()
  for _, win in pairs(api.nvim_tabpage_list_wins(0)) do
    if vim.bo[api.nvim_win_get_buf(win)].ft == 'NvimTree' then
      return api.nvim_win_get_width(win) + 1
    end
  end
  return 0
end

local function get_buttons_width() -- right side buttons
  local width = 6
  if fn.tabpagenr('$') ~= 1 then
    width = width + ((3 * fn.tabpagenr('$')) + 2) + 10
    width = not vim.g.TbTabsToggled and 8 or width
  end
  return width
end

local function add_file_info(file_name, bufnr)
  local present, devicons = pcall(require, 'nvim-web-devicons')

  if present then
    local icon, icon_hl = devicons.get_icon(file_name, string.match(file_name, '%a+$'))

    if not icon then
      icon = '󰈚'
      icon_hl = 'DevIconDefault'
    end

    icon = (api.nvim_get_current_buf() == bufnr and hl.icon .. icon or hl.icon_off(icon_hl) .. icon)

    for _, value in ipairs(vim.t.bufs) do
      if is_buf_valid(value) then
        if file_name == fn.fnamemodify(api.nvim_buf_get_name(value), ':t') and value ~= bufnr then
          local other = {}
          for match in (vim.fs.normalize(api.nvim_buf_get_name(value)) .. '/'):gmatch('(.-)' .. '/') do
            table.insert(other, match)
          end

          local current = {}
          for match in (vim.fs.normalize(api.nvim_buf_get_name(bufnr)) .. '/'):gmatch('(.-)' .. '/') do
            table.insert(current, match)
          end

          file_name = current[#current]

          for i = #current - 1, 1, -1 do
            local value_current = current[i]
            local other_current = other[i]

            if value_current ~= other_current then
              if (#current - i) < 2 then
                file_name = value_current .. '/' .. file_name
              else
                file_name = value_current .. '/../' .. file_name
              end
              break
            end
          end
          break
        end
      end
    end

    local maxname_len = 18

    file_name = (#file_name > maxname_len and string.sub(file_name, 1, maxname_len) .. '...')
      or file_name
    file_name = (api.nvim_get_current_buf() == bufnr and hl.content .. ' ' .. file_name)
      or (hl.off .. file_name)

    return icon .. ' ' .. file_name
  end
end

local function style_buff_tab(nr)
  local close_btn = '%' .. nr .. '@TbKillBuf@ 󰅙'
  local name = (#api.nvim_buf_get_name(nr) ~= 0) and fn.fnamemodify(api.nvim_buf_get_name(nr), ':t')
    or ' No Name '
  name = '%' .. nr .. '@TbGoToBuf@' .. add_file_info(name, nr) .. '%X'

  -- color close btn for focused / hidden  buffers
  if nr == api.nvim_get_current_buf() then
    close_btn = (vim.bo[0].modified and '%' .. nr .. '@TbKillBuf@' .. hl.modified .. ' ')
      or (hl.modified .. close_btn)
    name = hl.off
      .. ' '
      .. hl.l_limit
      .. limit.left
      .. name
      .. hl.modified
      .. close_btn
      .. hl.r_limit
      .. limit.right
  else
    close_btn = (vim.bo[nr].modified and '%' .. nr .. '@TbKillBuf@' .. hl.off .. ' ')
      or close_btn
    name = hl.off .. ' ' .. name .. close_btn
  end

  return name .. ' '
end

return {
  overriden_modules = function()
    return {
      bufferlist = function()
        local buffers = {} -- buffersults
        local available_space = vim.o.columns - get_nvimtree_width() - get_buttons_width()
        local current_buf = api.nvim_get_current_buf()
        local has_current = false -- have we seen current buffer yet?

        for _, bufnr in ipairs(vim.t.bufs) do
          if is_buf_valid(bufnr) then
            if ((#buffers + 1) * 21) > available_space then
              if has_current then
                break
              end

              table.remove(buffers, 1)
            end

            has_current = (bufnr == current_buf and true) or has_current
            table.insert(buffers, style_buff_tab(bufnr))
          end
        end

        vim.g.visibuffers = buffers
        return table.concat(buffers) .. '%#TblineFill#' .. '%=' -- buffers + empty space
      end,
    }
  end,
}
