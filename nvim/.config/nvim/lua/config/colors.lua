local M = {}

-- Inspirated in https://github.com/catppuccin/nvim/discussions/323#discussioncomment-4410359
M.catppuccin = function()
  require('catppuccin').setup({
    integrations = {
      treesitter = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { 'italic' },
          hints = { 'italic' },
          warnings = { 'italic' },
          information = { 'italic' },
        },
        underlines = {
          errors = { 'underline' },
          hints = { 'underline' },
          warnings = { 'underline' },
          information = { 'underline' },
        },
      },
      coc_nvim = false,
      lsp_trouble = false,
      cmp = true,
      lsp_saga = true,
      gitgutter = false,
      gitsigns = true,
      telescope = true,
      nvimtree = false,
      dap = {
        enabled = false,
        enable_ui = false,
      },
      neotree = true,
      which_key = true,
      indent_blankline = {
        enabled = true,
        colored_indent_levels = false,
      },
      dashboard = false,
      neogit = false,
      vim_sneak = false,
      fern = false,
      barbar = false,
      markdown = true,
      lightspeed = false,
      leap = false,
      ts_rainbow = false,
      hop = false,
      notify = true,
      telekasten = false,
      symbols_outline = false,
      mini = false,
      aerial = false,
      vimwiki = false,
      beacon = false,
      overseer = false,
      fidget = true,
      treesitter_context = false,
    },
    color_overrides = {
      macchiato = {
        rosewater = '#efc9c2',
        flamingo = '#ebb2b2',
        pink = '#f2a7de',
        mauve = '#b889f4',
        red = '#ea7183',
        maroon = '#ea838c',
        peach = '#f39967',
        yellow = '#eaca89',
        green = '#96d382',
        teal = '#78cec1',
        sky = '#91d7e3',
        sapphire = '#68bae0',
        blue = '#739df2',
        lavender = '#a0a8f6',
        text = '#b5c1f1',
        subtext1 = '#a6b0d8',
        subtext0 = '#959ec2',
        overlay2 = '#848cad',
        overlay1 = '#717997',
        overlay0 = '#6e738d',
        surface2 = '#5b6078',
        surface1 = '#494d64',
        surface0 = '#363a4f',
        base = '#24273a',
        mantle = '#1e2030',
        crust = '#181926',
      },
    },
    custom_highlights = function(C)
      return {
        CmpItemKindSnippet = { fg = C.base, bg = C.mauve },
        CmpItemKindKeyword = { fg = C.base, bg = C.red },
        CmpItemKindText = { fg = C.base, bg = C.teal },
        CmpItemKindMethod = { fg = C.base, bg = C.blue },
        CmpItemKindConstructor = { fg = C.base, bg = C.blue },
        CmpItemKindFunction = { fg = C.base, bg = C.blue },
        CmpItemKindFolder = { fg = C.base, bg = C.blue },
        CmpItemKindModule = { fg = C.base, bg = C.blue },
        CmpItemKindConstant = { fg = C.base, bg = C.peach },
        CmpItemKindField = { fg = C.base, bg = C.green },
        CmpItemKindProperty = { fg = C.base, bg = C.green },
        CmpItemKindEnum = { fg = C.base, bg = C.green },
        CmpItemKindUnit = { fg = C.base, bg = C.green },
        CmpItemKindClass = { fg = C.base, bg = C.yellow },
        CmpItemKindVariable = { fg = C.base, bg = C.flamingo },
        CmpItemKindFile = { fg = C.base, bg = C.blue },
        CmpItemKindInterface = { fg = C.base, bg = C.yellow },
        CmpItemKindColor = { fg = C.base, bg = C.red },
        CmpItemKindReference = { fg = C.base, bg = C.red },
        CmpItemKindEnumMember = { fg = C.base, bg = C.red },
        CmpItemKindStruct = { fg = C.base, bg = C.blue },
        CmpItemKindValue = { fg = C.base, bg = C.peach },
        CmpItemKindEvent = { fg = C.base, bg = C.blue },
        CmpItemKindOperator = { fg = C.base, bg = C.blue },
        CmpItemKindTypeParameter = { fg = C.base, bg = C.blue },
        CmpItemKindCopilot = { fg = C.base, bg = C.teal },
      }
    end,
  })

  vim.g.catppuccin_flavour = 'macchiato'
  vim.cmd.colorscheme('catppuccin')
end

M.setup = function()
  M.catppuccin()
end

return M
