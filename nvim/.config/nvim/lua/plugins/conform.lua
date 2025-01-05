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
  ['lua'] = { 'stylua' },
  ['less'] = { 'prettierd' },
  ['markdown'] = { 'prettierd' },
  ['markdown.mdx'] = { 'prettierd' },
  ['scss'] = { 'prettierd' },
  ['svelte'] = { 'prettierd', 'eslint_d' },
  ['typescript'] = { 'eslint_d' },
  ['typescriptreact'] = { 'eslint_d', 'prettierd' },
  ['vue'] = { 'eslint_d', 'prettierd' },
  ['yaml'] = { 'prettierd' },
}
local NO_PRETTIER_PATHS = {
  '/personal/projects/stack',
  '/personal/projects/angelica%-nadal',
  '/personal/open%-source/eslint%-plugin%-svelte%-tailwindcss',
  '/personal/open%-source/advent%-visualizations',
  '/personal/open%-source/dartBarrelFileGenerator',
}

-- In personal projects I don't like using prettier,
-- and I plan on increasingly remove prettier from such project
local get_formatters_by_ft = function()
  -- Get current path
  local current_path = vim.fn.getcwd()
  -- Check if current path is in NO_PRETTIER_PATHS
  for _, path in ipairs(NO_PRETTIER_PATHS) do
    if current_path:find(path) then
      local formatters = vim.deepcopy(DEFAULT_FORMATTERS)
      -- Remove prettier from svelte, ts and js
      formatters['css'] = {}
      formatters['scss'] = {}
      formatters['less'] = {}
      formatters['javascript'] = {}
      formatters['javascriptreact'] = {}
      formatters['svelte'] = { 'eslint_d' }
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
  },
}
