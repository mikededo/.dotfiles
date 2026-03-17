local shared = require('shared')

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

local function find_closest_config_dir(config_names, current_file)
  local file = find_closest_config_file(config_names, current_file)
  if file == nil then
    return nil
  end

  return vim.fs.dirname(file)
end

local function find_local_node_bin(binary, current_file)
  local dir = vim.fn.fnamemodify(current_file, ':p:h')
  while dir and dir ~= '' do
    local candidate = vim.fs.joinpath(dir, 'node_modules', '.bin', binary)
    if vim.fn.executable(candidate) == 1 then
      return candidate
    end

    local parent = vim.fs.dirname(dir)
    if parent == dir then
      break
    end
    dir = parent
  end

  return binary
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

local function eslint_d_restart_augroup()
  local group =
    vim.api.nvim_create_augroup('eslint-d-restart', { clear = true })
  local eslint_config_filenames = {}
  for _, name in ipairs(shared.eslint_config_names) do
    eslint_config_filenames[name] = true
  end

  vim.api.nvim_create_autocmd('BufWritePost', {
    group = group,
    pattern = '*',
    callback = function(args)
      local filepath = args.file or vim.api.nvim_buf_get_name(args.buf)
      local basename = vim.fs.basename(filepath)
      if not eslint_config_filenames[basename] then
        return
      end

      pcall(vim.cmd, 'LspRestart eslint')

      if vim.fn.executable('eslint_d') ~= 1 then
        return
      end
      vim.system({ 'eslint_d', 'restart' }, { text = true }, function(result)
        if result.code ~= 0 then
          vim.schedule(function()
            vim.notify(
              'eslint_d restart failed: ' .. (result.stderr or 'unknown error'),
              vim.log.levels.WARN
            )
          end)
        end
      end)
    end,
  })
end

return {
  {
    'stevearc/conform.nvim',
    init = function()
      eslint_d_restart_augroup()
    end,
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },

        javascript = {
          'eslint_d',
          'prettierd',
          stop_after_first = true,
        },
        javascriptreact = {
          'eslint_d',
          'prettierd',
          stop_after_first = true,
        },
        ['javascript.jsx'] = {
          'eslint_d',
          'prettierd',
          stop_after_first = true,
        },
        typescript = {
          'eslint_d',
          'prettierd',
          stop_after_first = true,
        },
        typescriptreact = {
          'eslint_d',
          'prettierd',
          stop_after_first = true,
        },
        ['typescript.tsx'] = {
          'eslint_d',
          'prettierd',
          stop_after_first = true,
        },
        html = { 'eslint_d', 'prettierd', stop_after_first = true },
        css = { 'eslint_d', 'prettierd', stop_after_first = true },
        scss = { 'eslint_d', 'prettierd', stop_after_first = true },
        less = { 'eslint_d', 'prettierd', stop_after_first = true },
        json = { 'eslint_d', 'prettierd', stop_after_first = true },
        json5 = { 'eslint_d', 'prettierd', stop_after_first = true },
        jsonc = { 'eslint_d', 'prettierd', stop_after_first = true },
        svelte = { 'eslint_d', stop_after_first = true },
        vue = { 'eslint_d', 'prettierd', stop_after_first = true },
        markdown = {
          'eslint_d',
          'prettierd',
          stop_after_first = true,
        },
        ['markdown.mdx'] = {
          'eslint_d',
          'prettierd',
          stop_after_first = true,
        },

        graphql = { 'eslint_d', 'prettierd', stop_after_first = true },
        yaml = { 'prettierd', 'actionlint' },
      },
      formatters = {
        eslint_d = {
          -- eslint_d returns 1 when non-fixable lint errors remain after --fix
          -- Treat it as a successful formatter run so fixed output is still applied.
          exit_codes = { 0, 1 },
          condition = function(_, ctx)
            return find_closest_config_file(
              shared.eslint_config_names,
              ctx.filename
            ) ~= nil
          end,
          command = function(_, ctx)
            return find_local_node_bin('eslint_d', ctx.filename)
          end,
          stdin = false,
          tmpfile_format = 'conform-$RANDOM-$FILENAME',
          args = function(_, ctx)
            local config_file =
              find_closest_config_file(shared.eslint_config_names, ctx.filename)
            return {
              '--config',
              config_file,
              '--fix',
              '$FILENAME',
            }
          end,
          cwd = function(_, ctx)
            return find_closest_config_dir(
              shared.eslint_config_names,
              ctx.filename
            )
          end,
          require_cwd = true,
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
        'eslint_d',
        'prettierd',
        'actionlint',
      },
    },
  },
}
