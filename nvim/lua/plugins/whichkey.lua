return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      { "<leader>j", group = "JetBrains" },
      { "<leader>q", group = "Dotnet" },
      { "<leader>p", group = "Picker" },
      { "<leader>l", group = "lsp" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
