vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function(args)
    require('conform').format({ bufnr = args.buf })
  end,
})

local DEFAULT_FORMATTERS = {
  ['css'] = { 'prettierd' },
  ['graphql'] = { 'prettierd' },
  ['html'] = { 'prettierd' },
  ['javascript'] = { 'eslint_d', 'prettierd' },
  ['javascriptreact'] = { 'eslint_d', 'prettierd' },
  ['json'] = { 'prettierd' },
  ['jsonc'] = { 'prettierd' },
  ['less'] = { 'prettierd' },
  ['markdown'] = { 'prettierd' },
  ['markdown.mdx'] = { 'prettierd' },
  ['scss'] = { 'prettierd' },
  ['svelte'] = { 'eslint_d' },
  ['typescript'] = { 'eslint_d' },
  ['typescriptreact'] = { 'eslint_d', 'prettierd' },
  ['vue'] = { 'eslint_d', 'prettierd' },
  ['yaml'] = { 'prettierd' },
}
local NO_PRETTIER_PATHS = {
  '/personal/projects/stack',
}

-- In personal projects I don't like using prettier,
-- and I plan on increasingly remove prettier from such project
local get_formatters_by_ft = function()
  -- Get current path
  local current_path = vim.fn.expand('%:p:h')
  -- Cehck if current path is in NO_PRETTIER_PATHS
  for _, path in ipairs(NO_PRETTIER_PATHS) do
    if current_path:find(path) then
      -- Remove prettier from svelte, ts and js
      -- Clone default formatters
      local formatters = vim.deepcopy(DEFAULT_FORMATTERS)
      -- Remove prettier from svelte, ts and js
      formatters['svelte'] = { 'eslint_d' }
      formatters['typescript'] = { 'eslint_d' }
      formatters['typescriptreact'] = { 'eslint_d' }
      formatters['javascript'] = { 'eslint_d' }
      formatters['javascriptreact'] = { 'eslint_d' }
      return formatters
    end
  end

  return DEFAULT_FORMATTERS
end

return {
  'stevearc/conform.nvim',
  optional = false,
  enabled = true,
  opts = {
    formatters_by_ft = get_formatters_by_ft(),
  },
}
