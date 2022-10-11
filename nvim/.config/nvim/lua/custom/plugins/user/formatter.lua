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
    exe = 'gofmt',
    stdin = true,
  }
end

require('formatter').setup({
  filetype = {
    graphql = { prettierConfig },
    go = { goConfig },
    html = { prettierConfig, eslintConfig },
    javascript = { prettierConfig, eslintConfig },
    javascriptreact = { prettierConfig, eslintConfig },
    json = { prettierConfig, eslintConfig },
    lua = { luaConfig },
    typescript = { prettierConfig, eslintConfig },
    typescriptreact = { prettierConfig, eslintConfig },
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
