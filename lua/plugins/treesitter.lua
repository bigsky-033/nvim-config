return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })
    require("nvim-treesitter").install({
      "lua",
      "python",
      "javascript",
      "typescript",
      "tsx",
      "json",
      "yaml",
      "toml",
      "bash",
      "markdown",
      "markdown_inline",
    })
  end,
}
