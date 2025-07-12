local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  sources = {
    -- Python
    formatting.black,
    formatting.isort,
    diagnostics.flake8,
    
    -- JavaScript/TypeScript
    formatting.prettier.with({
      filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "json",
        "css",
        "html",
        "markdown",
      },
    }),
    
    -- Java (Google Java Format)
    formatting.google_java_format,
  },
})

-- Auto format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.py", "*.js", "*.jsx", "*.ts", "*.tsx", "*.java", "*.json", "*.css", "*.html" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

