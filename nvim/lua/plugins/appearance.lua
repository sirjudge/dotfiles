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
            -- vim.cmd.colorscheme('rose-pine-moon')
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
        config = function()
            vim.cmd.colorscheme('catppuccin-mocha')
        end
    },
    {
        "nyoom-engineering/oxocarbon.nvim",
        config = function()
            --vim.cmd.colorscheme('oxocarbon')
        end
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
        'AmberLehmann/candyland.nvim',
        config = function()
            -- vim.cmd.colorscheme('candyland')
        end
    },
    {
        "anAcc22/sakura.nvim",
        config = function()
            --vim.opt.background = "dark" -- or "light"
            -- vim.cmd.colorscheme("sakura"); -- sets the colorscheme
        end
    },
    {
	"rktjmp/lush.nvim",
	-- if you wish to use your own colorscheme:
	-- { dir = '/absolute/path/to/colorscheme', lazy = true },
    },
    {
        "matsuuu/pinkmare",
    },
    {
        "scottmckendry/cyberdream.nvim",
        lazy = false,
        priority = 1000,
    },
}
