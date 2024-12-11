return{
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
    {
        'echasnovski/mini.animate',
        version = false,
        config = function ()
            require("mini.animate").setup()
        end,
        opts = {
            -- Cursor path
            cursor = {
                -- Whether to enable this animation
                enable = true,
            },

            -- Vertical scroll
            scroll = {
                -- Whether to enable this animation
                enable = true,
            },

            -- Window resize
            resize = {
                -- Whether to enable this animation
                enable = true,
            },

            -- Window open
            open = {
                -- Whether to enable this animation
                enable = true,
            },

            -- Window close
            close = {
                -- Whether to enable this animation
                enable = true,
            }
        }
    },
}
