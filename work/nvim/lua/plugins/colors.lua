return {
    -- colorschemes
    {
        "lettertwo/laserwave.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme('laserwave-hi_c')
        end
    },   
    {
        'rose-pine/neovim',
        -- config = function()
        --     vim.cmd.colorscheme('rose-pine-main')
        -- end
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
    },
    {
        "nyoom-engineering/oxocarbon.nvim",
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {
        "nyoom-engineering/oxocarbon.nvim",
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

        -- vim.cmd.colorscheme [[cuddlefish]]
      end
    }
}
