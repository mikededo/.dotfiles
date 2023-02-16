local wk = require('which-key')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lsp_mappings = require('custom.plugins.lspconfig.mappings')

capabilities.textDocument.completion.completionItem.snippetSupport = false

local len = function(t)
  local c = 0
  for _, _ in ipairs(t) do
    c = c + 1
  end
  return c
end

local build_which_key = function(map, cmd, desc)
  local map_len = len(map)
  local res
  for i, _ in ipairs(map) do
    local pos = map_len - i + 1
    if i == 1 then
      res = { [map[pos]] = { cmd, desc } }
    else
      res = { [map[pos]] = res }
    end
  end
  return res
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true, silent = true }

  for _, m in ipairs(lsp_mappings) do
    buf_set_keymap(m.mode, table.concat(m.map), m.cmd, opts)
    wk.register(build_which_key(m.map, m.cmd, m.desc), { mode = m.mode })
  end
end

-- Enable signature
require('lsp_signature').setup()

-- require configurations
require('custom.plugins.lspconfig.servers').attach(on_attach)
-- diagnostics
require('custom.plugins.lspconfig.diagnostics').setup()

return {}
