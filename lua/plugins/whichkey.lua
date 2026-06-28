return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      { "<leader>f", group = "find" },
      { "<leader>g", group = "git" },
      { "<leader>c", group = "code" },
      { "<leader>e", group = "explorer" },
      { "<leader>b", group = "buffers" },
      { "<leader>w", group = "windows" },
    },
  },
}
