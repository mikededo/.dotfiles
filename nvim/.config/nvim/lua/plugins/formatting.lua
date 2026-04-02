local uv = vim.uv or vim.loop

local function find_closest_config_file(config_names, current_file)
  if config_names == nil then
    return nil
  end

  local dir = vim.fn.fnamemodify(current_file, ':p:h')
  while dir and dir ~= '' do
    for _, config_name in ipairs(config_names) do
      local candidate = vim.fs.joinpath(dir, config_name)
      if uv.fs_stat(candidate) then
        return candidate
      end
    end

    local parent = vim.fs.dirname(dir)
    if parent == dir then
      break
    end
    dir = parent
  end

  return nil -- No config file found
end

---@param keys string[]
---@param current_file string
local function package_json_has_keys(keys, current_file)
  local pkgjson = vim.fs.find({ 'package.json' }, {
    upward = true,
    path = vim.fn.fnamemodify(current_file, ':p:h'),
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

        javascript = {
          'prettierd',
          stop_after_first = true,
        },
        javascriptreact = {
          'prettierd',
          stop_after_first = true,
        },
        ['javascript.jsx'] = {
          'prettierd',
          stop_after_first = true,
        },
        typescript = {
          'prettierd',
          stop_after_first = true,
        },
        typescriptreact = {
          'prettierd',
          stop_after_first = true,
        },
        ['typescript.tsx'] = {
          'prettierd',
          stop_after_first = true,
        },
        html = { 'prettierd', stop_after_first = true },
        css = { 'prettierd', stop_after_first = true },
        scss = { 'prettierd', stop_after_first = true },
        less = { 'prettierd', stop_after_first = true },
        json = { 'prettierd', stop_after_first = true },
        json5 = { 'prettierd', stop_after_first = true },
        jsonc = { 'prettierd', stop_after_first = true },
        vue = { 'prettierd', stop_after_first = true },
        markdown = {
          'prettierd',
          stop_after_first = true,
        },
        ['markdown.mdx'] = {
          'prettierd',
          stop_after_first = true,
        },

        graphql = { 'prettierd', stop_after_first = true },
        yaml = { 'prettierd', 'actionlint' },
      },
      formatters = {
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

            return package_json_has_keys(
              { 'prettier', 'prettierrc' },
              ctx.filename
            )
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
        'prettierd',
        'actionlint',
      },
    },
  },
}
