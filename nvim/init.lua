-- Ensure the config directory is in the runtime path
vim.opt.runtimepath:prepend(vim.fn.stdpath("config"))

require("config")

vim.api.nvim_create_autocmd('FileType', {
  pattern = { '<filetype>' },
  callback = function()
      vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.wo[0][0].foldmethod = 'expr'
      vim.treesitter.start()
  end,
})
