require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "lua",
    "vim",
    "javascript",
    "typescript",
    "tsx",
    "python",
    "java",
    "c",
    "cpp",
    "cmake",
    "json",
    "html",
    "css",
    "markdown",
    "markdown_inline",
  },
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
})

