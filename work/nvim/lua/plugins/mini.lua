return {
    {
        'echasnovski/mini.comment',
        version = '*',
        opts = {
            -- Module mappings. Use `''` (empty string) to disable one.
            mappings = {
                -- Toggle comment (like `gcip` - comment inner paragraph) for both
                -- Normal and Visual modes
                comment = 'gc',
                -- Toggle comment on current line
                comment_line = 'gcc',
                -- Toggle comment on visual selection
                comment_visual = 'gc',
                -- Define 'comment' textobject (like `dgc` - delete whole comment block)
                -- Works also in Visual mode if mapping differs from `comment_visual`
                textobject = 'gc',
            },
        }
    },
    {
        'echasnovski/mini.icons',
        version = false
    },
    {
        'echasnovski/mini.pairs',
        version = false
    },
    {
        'echasnovski/mini.starter',
        version = false
    },
    -- {
    --     'echasnovski/mini.sessions',
    --     version = false,
    --     keys = {
    --         {
    --             "<leader>sn",
    --             desc = "New session"
    --         },
    --         {
    --             "<leader>ss",
    --             function()
    --                 require('mini.sessions').write()
    --             end,
    --             desc = "Save Session"
    --         },
    --         {
    --             "<leader>sd",
    --             function()
    --                 require('mini.sessions').delete()
    --             end,
    --             desc = "Delete Session"
    --         },
    --
    --     },
    --     opts = {
    --         autoread = true,
    --         autowrite = true,
    --         directory = vim.fn.expand("~/.vim/sessions/"),
    --         file = 'Session.vim',
    --     },
    --     config = function()
    --         require('mini.sessions').setup()
    --     end
    -- },
}
