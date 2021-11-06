local prettierConfig = function()
  return {
    exe = "prettier",
    args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
    stdin = true
  }
end

local eslintConfig = function()
  return {
    exe = "eslint_d",
    args = { "--stdin", "--stdin-filename", vim.api.nvim_buf_get_name(0), "--fix-to-stdout" },
    stdin = true
  }
end

require("formatter").setup(
  {
    filetype = {
      json = { prettierConfig, eslintConfig },
      html = { prettierConfig, eslintConfig },
      javascript = { prettierConfig, eslintConfig },
      javascriptreact = { prettierConfig, eslintConfig },
      typescript = { prettierConfig, eslintConfig },
      typescriptreact = { prettierConfig, eslintConfig }
    }
  }
)

vim.api.nvim_exec([[
  augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost *.js,*.jsx,*.ts,*.tsx,*.lua FormatWrite
  augroup END
]], true)
