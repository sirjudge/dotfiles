return {
    {
        'rose-pine/neovim',
        -- config = function()
        --     vim.cmd.colorscheme('rose-pine-moon')
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
        config = function()
            vim.cmd.colorscheme('oxocarbon')
        end
    }
}

