local present, lsp_signature = pcall(require, 'lsp_signature')
if not present then
  return
end

local config = {
  hint_prefix = ' ',
  hint_scheme = 'Comment',
}

lsp_signature.setup(config)

return {}
