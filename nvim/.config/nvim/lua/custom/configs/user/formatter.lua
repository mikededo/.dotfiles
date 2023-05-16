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
      '--column-width 80',
      '--indent-type Spaces',
      '--indent-width 2',
      '--quote-style ForceSingle',
    },
    stdin = false,
  }
end

local goConfig = function()
  return {
    exe = 'goimports',
    stdin = true,
  }
end

local yamlConfig = function()
  return { exe = 'yamlfmt' }
end

local rustfmtConfig = function()
  return {
    exe = 'rustfmt',
    args = { '--edition 2021' },
    stdin = true,
  }
end

local latexConfig = function()
  return {
    exe = 'latexindent',
    args = { '-w', '-s' },
  }
end

require('formatter').setup({
  filetype = {
    go = { goConfig },
    graphql = { prettierConfig },
    html = { prettierConfig, eslintConfig },
    javascript = { prettierConfig, eslintConfig },
    javascriptreact = { prettierConfig, eslintConfig },
    json = { prettierConfig, eslintConfig },
    rust = { rustfmtConfig },
    lua = { luaConfig },
    tex = { latexConfig },
    typescript = { prettierConfig, eslintConfig },
    typescriptreact = { prettierConfig, eslintConfig },
    yaml = { yamlConfig },
    ['yaml.docker-compose'] = { yamlConfig },
  },
})

vim.api.nvim_exec(
  [[
  augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost * FormatWrite
  augroup END
  ]],
  true
)
