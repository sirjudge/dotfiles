if vim.g.loaded_jetbrains_format then
  return
end
vim.g.loaded_jetbrains_format = true

require("jetbrains-format").setup({
  executable = "jb",
  dotnet_tool = true,
})

vim.api.nvim_create_user_command("JetBrainsFormat", function()
  require("jetbrains-format").format_buffer(0)
end, { desc = "Format current buffer with JetBrains command-line formatter" })

vim.keymap.set("n", "<leader>jc", "<cmd>JetBrainsFormat<CR>", { desc = "cleanup code (jetbrains)" })
