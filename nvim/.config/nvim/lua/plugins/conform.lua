vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('EslintFixAll', { clear = true }),
  pattern = {
    '*.tsx',
    '*.ts',
    '*.jsx',
    '*.js',
    '*.svelte',
    '*.css',
    '*.scss',
    '*.less',
    '*.json',
    '*.jsonc',
  },
  command = 'silent! EslintFixAll',
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
  '/personal/open%-source/eslint%-plugin%-svelte%-tailwindcss',
}

-- In personal projects I don't like using prettier,
-- and I plan on increasingly remove prettier from such project
local get_formatters_by_ft = function()
  -- Get current path
  local current_path = vim.fn.getcwd()
  -- Check if current path is in NO_PRETTIER_PATHS
  for _, path in ipairs(NO_PRETTIER_PATHS) do
    -- print(current_path)
    -- print(path)
    if current_path:find(path) then
      -- Remove prettier from svelte, ts and js
      -- Clone default formatters
      local formatters = vim.deepcopy(DEFAULT_FORMATTERS)
      -- Remove prettier from svelte, ts and js
      formatters['css'] = {}
      formatters['scss'] = {}
      formatters['less'] = {}
      formatters['javascript'] = {}
      formatters['javascriptreact'] = {}
      formatters['svelte'] = {}
      formatters['typescript'] = {}
      formatters['typescriptreact'] = {}
      return formatters
    end
  end

  return DEFAULT_FORMATTERS
end

return {
  'stevearc/conform.nvim',
  optional = false,
  enabled = true,
  lazy = false,
  opts = {
    notify_no_formatters = true,
    notify_on_error = true,
    formatters_by_ft = get_formatters_by_ft(),
  }
}
