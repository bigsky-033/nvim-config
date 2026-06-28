local augroup = function(name)
  return vim.api.nvim_create_augroup("config_" .. name, { clear = true })
end

-- Briefly highlight yanked text.
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Enable Treesitter highlighting from core when a parser is available
-- for the buffer's filetype. No-ops (falls back to regex syntax) otherwise.
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("treesitter_highlight"),
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    if ft == "" then
      return
    end
    local lang = vim.treesitter.language.get_lang(ft) or ft
    if vim.treesitter.language.add(lang) then
      vim.treesitter.start(args.buf, lang)
    end
  end,
})
