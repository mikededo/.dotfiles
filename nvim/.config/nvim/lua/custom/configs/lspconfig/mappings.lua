return {
  {
    mode = 'n',
    map = { '<leader>', 'c', 'a' },
    cmd = '<Cmd>lua vim.lsp.buf.code_action()<CR>',
    desc = 'Show code actions',
  },
  {
    mode = 'n',
    map = { '<leader>', 'd', 'n' },
    cmd = '<cmd>lua vim.diagnostic.goto_next()<CR>',
    desc = 'Go to next diagnostic',
  },
  {
    mode = 'n',
    map = { '<leader>', 'e' },
    cmd = '<cmd>lua vim.diagnostic.open_float(0, { scope = "line", border = "rounded" })<CR>',
    desc = 'Show diagnostic',
  },
  {
    mode = 'n',
    map = { '<leader>', 'r', 'n' },
    cmd = '<Cmd>lua require(\'nvchad_ui.renamer\').open()<CR>',
    desc = 'Rename',
  },
  {
    mode = 'n',
    map = { '<leader>', 'd', 't' },
    cmd = '<cmd>Telescope diagnostics<CR>',
    desc = 'Telescope diagnostics',
  },
  {
    mode = 'n',
    map = { 'K' },
    cmd = '<Cmd>lua vim.lsp.buf.hover()<CR>',
    'LSP hover',
  },
  { -- normally not implemented by servers
    mode = 'n',
    map = { 'g', 'D' },
    cmd = '<Cmd>lua vim.lsp.buf.declaration()<CR>',
    desc = 'Go to declaration',
  },
  {
    mode = 'n',
    map = { 'g', 'S' },
    cmd = '<Cmd>lua vim.lsp.buf.signature_help()<CR>',
    desc = 'Show signature help',
  },
  {
    mode = 'n',
    map = { 'g', 'd' },
    cmd = '<Cmd>lua vim.lsp.buf.definition()<CR>',
    desc = 'Go to definition',
  },
  {
    mode = 'n',
    map = { 'g', 'i' },
    cmd = '<Cmd>lua vim.lsp.buf.implementation()<CR>',
    desc = 'Go to implementation',
  },
}
