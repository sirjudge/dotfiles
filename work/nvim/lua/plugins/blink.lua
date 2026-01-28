return {
    {
        'saghen/blink.compat',
        version = '*',
        lazy = true,
        opts = {},
    },
    {
        'saghen/blink.cmp',
        lazy = false,
        dependencies = 'rafamadriz/friendly-snippets',
        version = '*',
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = { 
                preset = 'default',
            },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono'
            },
            fuzzy = { implementation = "prefer_rust_with_warning" },
            sources = {
                -- default = { 'lsp', 'path', 'snippets', 'buffer' },
                default = { 'lsp', 'path', 'buffer'}, -- , 'easy-dotnet'},
                providers = {
                    -- ["easy-dotnet"] = {
                    --     name = "easy-dotnet",
                    --     enabled = true,
                    --     module = "easy-dotnet.completion.blink",
                    --     score_offset = 10000,
                    --     async = true,
                    -- },
                }
            },
        },
        opts_extend = {
            "sources.completion.enabled_provides"
        },
        completion = {
            ghost_text = {
                enabled = true
            },
            keyword = {
                range = 'prefix',
                regex = '[-_]\\|\\k',
                exclude_from_prefix_regex = '[\\-]',
                menu = { 
                    border = 'single' 
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                    window = { 
                        border = 'single' 
                    }
                },
            },
        },
        signature = { 
            window = {
                border = 'single' 
            } 
        },
    }
}
