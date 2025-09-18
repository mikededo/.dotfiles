return {
  -- nvim-lint
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      -- Event to trigger linters
      events = { "BufWritePost", "BufReadPost", "InsertLeave" },
      linters_by_ft = {
        lua = {},  -- lua_ls provides diagnostics
        
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        ["javascript.jsx"] = { "eslint_d" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        ["typescript.tsx"] = { "eslint_d" },
        
        svelte = { "eslint_d" },
        vue = { "eslint_d" },
        
        html = { "eslint_d" },
        css = { "eslint_d" },
        scss = { "eslint_d" },
        less = { "eslint_d" },
        json = { "eslint_d" },
        json5 = { "eslint_d" },
        jsonc = { "eslint_d" },
        
        markdown = { "eslint_d" },
        ["markdown.mdx"] = { "eslint_d" },
        
        graphql = { "eslint_d" },
        yaml = { "actionlint" },
        handlebars = { "eslint_d" },
      },
      -- Configuration for specific linters
      linters = {
        eslint_d = {
          condition = function(ctx)
            return vim.fs.find({
              ".eslintrc",
              ".eslintrc.js",
              "eslint.config.js",
              "eslint.config.ts",
              "eslint.config.cjs",
              "eslint.config.cts",
              "eslint.config.mjs",
              "eslint.config.mts",
            }, { path = ctx.filename, upward = true })[1]
          end,
        },
        actionlint = {
          condition = function(ctx)
            -- Only lint GitHub Actions workflow files
            return ctx.filename:match("%.github/workflows/.*%.ya?ml$") or vim.fs.find({ ".github/" }, { path = ctx.filename, upward = true })[1]
          end,
        },
      },
    },
    config = function(_, opts)
      local lint = require("lint")
      
      for name, linter in pairs(opts.linters or {}) do
        if type(linter) == "table" and type(lint.linters[name]) == "table" then
          lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], linter)
        else
          lint.linters[name] = linter
        end
      end
      
      lint.linters_by_ft = opts.linters_by_ft

      vim.api.nvim_create_autocmd(opts.events, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = function()
          -- Use nvim-lint's logic first:
          -- * checks if linters exist for the full filetype first
          -- * otherwise will split filetype by "." and add all those linters
          -- * this enables for example adding markdown linters to "markdown.mdx" which will
          --   get both the markdown and mdx linters
          lint.try_lint()
        end,
      })
    end,
  },

  -- mason.nvim - ensure linters are installed  
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "eslint_d",
        "actionlint",
      },
    },
  },
}