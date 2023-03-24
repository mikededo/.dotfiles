local nvchad_blankline = require('plugins.configs.others').blankline

vim.opt.list = true
vim.opt.listchars:append('space:⋅')
vim.opt.listchars:append('eol:↴')

local options = { show_current_context = true }

-- return vim.tbl_deep_extend('force', nvchad_blankline, options)
return options
