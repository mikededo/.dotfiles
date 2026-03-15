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

  return nil
end

local function find_closest_config_dir(config_names, current_file)
  local file = find_closest_config_file(config_names, current_file)
  if file == nil then
    return nil
  end

  return vim.fs.dirname(file)
end

return {
  -- nvim-lint
  {
    'mfussenegger/nvim-lint',
    optional = true,
    opts = {
      -- Event to trigger linters
      events = { 'BufWritePost', 'BufReadPost', 'InsertLeave' },
      linters_by_ft = {
        lua = {}, -- lua_ls provides diagnostics

        javascript = { 'eslint_d' },
        javascriptreact = { 'eslint_d' },
        ['javascript.jsx'] = { 'eslint_d' },
        typescript = { 'eslint_d' },
        typescriptreact = { 'eslint_d' },
        ['typescript.tsx'] = { 'eslint_d' },

        svelte = { 'eslint_d' },
        vue = { 'eslint_d' },

        html = { 'eslint_d' },
        css = { 'eslint_d' },
        scss = { 'eslint_d' },
        less = { 'eslint_d' },
        json = { 'eslint_d' },
        json5 = { 'eslint_d' },
        jsonc = { 'eslint_d' },

        markdown = { 'eslint_d' },
        ['markdown.mdx'] = { 'eslint_d' },

        graphql = { 'eslint_d' },
        yaml = { 'actionlint' },
        handlebars = { 'eslint_d' },
      },
      -- Configuration for specific linters
      linters = {
        eslint_d = {
          condition = function(ctx)
            return find_closest_config_file(
              shared.eslint_config_names,
              ctx.filename
            ) ~= nil
          end,
          cwd = function(ctx)
            return find_closest_config_dir(
              shared.eslint_config_names,
              ctx.filename
            )
          end,
        },
        actionlint = {
          condition = function(ctx)
            -- Only lint GitHub Actions workflow files
            return ctx.filename:match('%.github/workflows/.*%.ya?ml$')
              or vim.fs.find(
                { '.github/' },
                { path = ctx.filename, upward = true }
              )[1]
          end,
        },
      },
    },
    config = function(_, opts)
      local lint = require('lint')

      for name, linter in pairs(opts.linters or {}) do
        if type(linter) == 'table' and type(lint.linters[name]) == 'table' then
          lint.linters[name] =
            vim.tbl_deep_extend('force', lint.linters[name], linter)
        else
          lint.linters[name] = linter
        end
      end

      lint.linters_by_ft = opts.linters_by_ft

      vim.api.nvim_create_autocmd(opts.events, {
        group = vim.api.nvim_create_augroup('nvim-lint', { clear = true }),
        callback = function(args)
          local bufnr = args.buf or vim.api.nvim_get_current_buf()
          local names = lint._resolve_linter_by_ft(vim.bo[bufnr].filetype)
          local filename = vim.api.nvim_buf_get_name(bufnr)
          local ctx = { filename = filename }

          for _, name in ipairs(names) do
            local linter = lint.linters[name]
            if type(linter) == 'function' then
              linter = linter()
            end

            local should_run = true
            if
              type(linter) == 'table' and type(linter.condition) == 'function'
            then
              should_run = linter.condition(ctx)
            end

            if should_run then
              local linter_cwd = nil
              if type(linter) == 'table' then
                if type(linter.cwd) == 'function' then
                  linter_cwd = linter.cwd(ctx)
                elseif type(linter.cwd) == 'string' then
                  linter_cwd = linter.cwd
                end
              end

              lint.try_lint(name, { cwd = linter_cwd })
            end
          end
        end,
      })
    end,
  },

  -- mason.nvim - ensure linters are installed
  {
    'mason-org/mason.nvim',
    opts = {
      ensure_installed = {
        'eslint_d',
        'actionlint',
      },
    },
  },
}
