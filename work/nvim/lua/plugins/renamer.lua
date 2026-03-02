return {
  "smjonas/inc-rename.nvim",
  keys = {
    { "<leader>rn", mode = "n", desc = "Incremental Rename" },
  },
  -- config = function()
  --   require("inc_rename").setup()
  --   vim.keymap.set("n", "<leader>rn", function()
  --       return ":IncRename " .. vim.fn.expand("<cword>")
  --   end, { expr = true })  end,
}
