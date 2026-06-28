-- Leader keys MUST be set before lazy.nvim and plugins load.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Load core settings before plugins.
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Bootstrap lazy.nvim.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", repo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Set up plugins from lua/plugins/*.lua.
require("lazy").setup({
  spec = { { import = "plugins" } },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = false },          -- no automatic update checks; updates are deliberate
  change_detection = { notify = false },
})
