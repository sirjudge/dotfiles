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
            vim.cmd.colorscheme('rose-pine-moon')
        end
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
    -- provides nice little notifications for neovim and lsp progress
    -- messages in the bottom right corner
    {
        "j-hui/fidget.nvim",
        config = function()
            require("fidget").setup({})
        end
    },
}
