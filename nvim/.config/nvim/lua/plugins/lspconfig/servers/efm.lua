local modules = require('plugins.lspconfig.servers.efm-configs')

local stylua = modules.lua
local eslint = modules.eslint
local prettier = modules.prettier
local actionlint = modules.actionlint

local languages = {
  lua = { stylua },

  ['markdown.mdx'] = { eslint, prettier },
  handlebars = { eslint, prettier },
  html = { eslint, prettier },
  javascript = { eslint, prettier },
  javascriptreact = { eslint, prettier },
  ['javascript.jsx'] = { eslint, prettier },
  typescript = { eslint, prettier },
  typescriptreact = { eslint, prettier },
  ['typescript.tsx'] = { eslint, prettier },
  svelte = { eslint, prettier },
  vue = { eslint, prettier },
  json = { eslint, prettier },
  json5 = { eslint, prettier },
  jsonc = { eslint, prettier },
  markdown = { eslint, prettier },
  css = { eslint, prettier },
  less = { eslint, prettier },
  scss = { eslint, prettier },
  graphql = { eslint, prettier },
  yaml = { eslint, prettier, actionlint },
}

return {
  efm = {
    on_attach = function()
      ---@type lspconfig.Config
      local opts = {
        filetypes = vim.tbl_keys(languages),
        init_options = {
          documentFormatting = true,
          rangeFormatting = true,
          hover = true,
          documentSymbol = true,
          codeAction = true,
          completion = true,
        },
        settings = {
          version = 2,
          logLevel = 5,
          logFile = '/tmp/efm-langserver.log',
          rootMarkers = { '.git/', 'package.json' },
          languages = languages,
        },
      }

      require('lspconfig').efm.setup(opts)
    end,
  },
}
