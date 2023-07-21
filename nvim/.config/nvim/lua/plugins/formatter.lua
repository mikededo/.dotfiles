local prettierConfig = function()
  return {
    exe = 'prettierd',
    args = { vim.api.nvim_buf_get_name(0) },
    stdin = true,
  }
end

local eslintConfig = function()
  return {
    exe = 'eslint_d',
    args = {
      '--stdin',
      '--stdin-filename',
      vim.api.nvim_buf_get_name(0),
      '--fix-to-stdout',
    },
    stdin = true,
  }
end

local luaConfig = function()
  return {
    exe = 'stylua',
    args = {
      '--column-width 100',
      '--indent-type Spaces',
      '--indent-width 2',
      '--quote-style ForceSingle',
    },
    stdin = false,
  }
end

local yamlConfig = function()
  return { exe = 'yamlfmt' }
end

vim.api.nvim_exec(
  [[
  augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost * FormatWrite
  augroup END
  ]],
  true
)

return {
  {
    'mhartington/formatter.nvim',
    event = 'VeryLazy',
    opts = {
      filetype = {
        graphql = { prettierConfig },
        html = { prettierConfig, eslintConfig },
        javascript = { prettierConfig, eslintConfig },
        javascriptreact = { prettierConfig, eslintConfig },
        json = { prettierConfig, eslintConfig },
        lua = { luaConfig },
        typescript = { prettierConfig, eslintConfig },
        typescriptreact = { prettierConfig, eslintConfig },
        yaml = { yamlConfig },
        ['yaml.docker-compose'] = { yamlConfig },
      },
    },
  },
}
