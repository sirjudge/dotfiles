return {
  "mistricky/codesnap.nvim",
  build = "make build_generator",
  keys = {
    { "<leader>cc", "<cmd>CodeSnap<cr>", mode = "x", desc = "Save selected code snapshot into clipboard" },
    { "<leader>cs", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "Save selected code snapshot in ~/Pictures" },
  },
  opts = {
    save_path = os.getenv("XDG_PICTURES_DIR") or (os.getenv("HOME").. "/Pictures"),
    has_breadcrumbs = true,
    bg_theme = "bamboo",
    has_line_number = true,
    code_font_family = "JetBrains Mono Nerd Font",
  },
}

