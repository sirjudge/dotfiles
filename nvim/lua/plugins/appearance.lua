return
{
    -- makes cursor be all smooth like
    {
        'gen740/SmoothCursor.nvim',
        config = function()
            require('smoothcursor').setup()
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
}
