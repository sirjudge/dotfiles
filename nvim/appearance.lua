return
{
    -- makes cursor be all smooth like
    {
        'gen740/SmoothCursor.nvim',
        config = function()
            require('smoothcursor').setup()
        end
    },
    -- colorschemes
    {
        'rose-pine/neovim',
        config = function()
            --vim.cmd.colorscheme('rose-pine-moon')
        end
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
    },
    {
        "nyoom-engineering/oxocarbon.nvim",
    },
    -- provides nice little notifications for neovim and lsp progress
    -- messages in the bottom right corner
    {
        "j-hui/fidget.nvim",
        config = function()
            require("fidget").setup({})
        end
    },
    {
      "comfysage/cuddlefish.nvim",
      config = function()
        require('cuddlefish').setup({
          theme = {
            accent = 'pink',
          },
          editor = {
            transparent_background = false,
          },
          style = {
            tabline = { 'reverse' },
            search = { 'italic', 'reverse' },
            incsearch = { 'italic', 'reverse' },
            types = { 'italic' },
            keyword = { 'italic' },
            comment = { 'italic' },
          },
          overrides = function(colors)
            return {}
          end,
        })

        vim.cmd.colorscheme [[cuddlefish]]
      end
    }
}
