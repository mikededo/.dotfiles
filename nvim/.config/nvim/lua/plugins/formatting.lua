local function find_closest_config_file(config_names, current_file)
  if config_names == nil then
    return nil
  end
  for _, config_name in ipairs(config_names) do
    local found = vim.fs.find(
      config_name,
      { upward = true, path = vim.fn.fnamemodify(current_file, ':p:h') }
    )
    if #found > 0 then
      return found[1] -- Return the closest config file found
    end
  end
  return nil -- No config file found
end

---@param keys string[]
local function package_json_has_keys(keys)
  local pkgjson = vim.fs.find({ 'package.json' }, {
    upward = false,
    path = vim.loop.cwd(),
  })[1]
  if not pkgjson then
    return false
  end

  local root = io.open(pkgjson, 'r')
  if not root then
    return false
  end

  local content = root:read('*a')
  root:close()

  local ok, json = pcall(vim.fn.json_decode, content)
  if not ok then
    return false
  end

  for _, key in ipairs(keys) do
    if json[key] ~= nil then
      return true
    end
  end

  return false
end

return {
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },

        -- JavaScript/TypeScript
        javascript = { 'eslint_d', 'prettierd' },
        javascriptreact = { 'eslint_d', 'prettierd' },
        ['javascript.jsx'] = { 'eslint_d', 'prettierd' },
        typescript = { 'eslint_d', 'prettierd' },
        typescriptreact = { 'eslint_d', 'prettierd' },
        ['typescript.tsx'] = { 'eslint_d', 'prettierd' },

        -- Web technologies
        html = { 'eslint_d', 'prettierd' },
        css = { 'eslint_d', 'prettierd' },
        scss = { 'eslint_d', 'prettierd' },
        less = { 'eslint_d', 'prettierd' },
        json = { 'eslint_d', 'prettierd' },
        json5 = { 'eslint_d', 'prettierd' },
        jsonc = { 'eslint_d', 'prettierd' },

        -- Frameworks
        svelte = { 'eslint_d' },
        vue = { 'eslint_d', 'prettierd' },

        -- Markdown
        markdown = { 'eslint_d', 'prettierd' },
        ['markdown.mdx'] = { 'eslint_d', 'prettierd' },

        -- Others
        graphql = { 'eslint_d', 'prettierd' },
        yaml = { 'prettierd', 'actionlint' },
      },
      formatters = {
        eslint_d = {
          condition = function(_, ctx)
            local file = find_closest_config_file({
              '.eslintrc',
              '.eslintrc.js',
              'eslint.config.js',
              'eslint.config.ts',
              'eslint.config.cjs',
              'eslint.config.cts',
              'eslint.config.mjs',
              'eslint.config.mts',
            }, ctx.filename)
            if file ~= nil then
              return true
            end

            return package_json_has_keys({ 'eslintConfig', 'eslint' })
          end,
        },
        prettierd = {
          condition = function(_, ctx)
            local file = find_closest_config_file({
              '.prettierrc',
              '.prettierrc.json',
              '.prettierrc.js',
              '.prettierrc.yml',
              '.prettierrc.yaml',
              '.prettierrc.json5',
              '.prettierrc.mjs',
              '.prettierrc.cjs',
              '.prettierrc.toml',
              'prettier.config.js',
              'prettier.config.cjs',
              'prettier.config.mjs',
            }, ctx.filename)
            if file ~= nil then
              return true
            end

            return package_json_has_keys({ 'prettier', 'prettierrc' })
          end,
        },
        stylua = {
          condition = function(_, ctx)
            return vim.fs.find(
              { 'stylua.toml', '.stylua.toml' },
              { path = ctx.filename, upward = true }
            )[1]
          end,
        },
        actionlint = {
          condition = function(_, ctx)
            return vim.fs.find(
              { '.github/' },
              { path = ctx.filename, upward = true }
            )[1]
          end,
        },
      },
    },
  },
  {
    'mason-org/mason.nvim',
    opts = {
      ensure_installed = {
        'stylua',
        'eslint_d',
        'prettierd',
        'actionlint',
      },
    },
  },
}
